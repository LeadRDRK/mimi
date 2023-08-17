import 'dart:async';
import 'version.dart' as v;
import '../utils/multi_stream_controller_depend.dart';

import '../api/api_client.dart';
import '../api/users_api.dart';
import '../api/notifications_api.dart';
import '../api/account_api.dart';
import '../api/notes_api.dart';

import '../stream/web_socket_client.dart';
import '../stream/channel_connection_manager.dart';
import '../stream/channel_connection.dart';
import '../stream/timeline_streams.dart';
import '../stream/note_subscription_manager.dart';

import '../entities/client_user.dart';
import '../structs/notification.dart';
import '../entities/note.dart';

/// The main object to interact with the API.
class Client {
  Client(this.host, {
    ApiClientOptions? apiClient
  })
  : api = ApiClient(host, apiClient)
  {
    channelConnectionManager = ChannelConnectionManager(wsClient);
    noteSubscriptionManager = NoteSubscriptionManager(wsClient);
    users = UsersApi(this);
    notifications = NotificationsApi(this);
    _account = AccountApiEx(this);
    notes = NotesApi(this);

    onNotification = _onNotificationController.stream;
    onMention = _onMentionController.stream;

    MultiStreamControllerDepend<ChannelConnection>(
      [_onNotificationController, _onMentionController],
      _initMainChannel,
      _uninitMainChannel
    );

    timelineStreams = TimelineStreams(this);
  }

  /// The current version of Mimi.
  String get version => v.version;

  /// The API client.
  final ApiClient api;
  
  /// The WebSocket client.
  final wsClient = WebSocketClient();

  Timer? _wsHeartbeatTimer;

  /// The streaming channel connection manager.
  late final ChannelConnectionManager channelConnectionManager;

  /// The note subscriptions manager.
  late final NoteSubscriptionManager noteSubscriptionManager;

  /// The host.
  final String host;

  /// The client user. Alias for `account.user`
  ClientUser get user => account.user;
  
  /// The users API.
  late final UsersApi users;

  /// The notifications API.
  late final NotificationsApi notifications;

  /// The account API.
  AccountApi get account => _account;
  late final AccountApiEx _account;

  /// The notes API.
  late final NotesApi notes;

  /// Emitted when a notification is created.
  late final Stream<Notification> onNotification;
  final _onNotificationController = StreamController<Notification>.broadcast();

  /// Emitted when the client user is mentioned in a note.
  /// 
  /// This event might be redundant if you're already listening to [onNotification].
  late final Stream<Note> onMention;
  final _onMentionController = StreamController<Note>.broadcast();

  /// The timeline streams.
  late final TimelineStreams timelineStreams;

  /// Login with an authentication token.
  /// 
  /// [user] is optional and can be used to initialize the client user.
  /// If set, the client won't fetch the user again if [fetchUser] is true.
  /// 
  /// If [initWs] is `true`, the `initWs` function will also be called.
  Future<void> login(String token, {ClientUser? user, bool fetchUser = true, bool initWs = true}) async {
    api.token = token;
    if (user != null) {
      _account.user = user;
    }
    else if (fetchUser) {
      await account.fetchUser();
    }

    if (initWs) await this.initWs(token);
  }

  /// Initializes the WebSocket stream.
  /// 
  /// This will connect to the WebSocket stream and run a periodic timer for the heartbeat.
  Future<void> initWs([String? token]) async {
    if (wsClient.state == WsClientState.connected) return;
    await wsClient.connect(host, token);

    if (_wsHeartbeatTimer != null) _wsHeartbeatTimer!.cancel();
    _wsHeartbeatTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (wsClient.state != WsClientState.connected) {
        timer.cancel();
        return;
      }
      wsClient.heartbeat();
    });
  }

  ChannelConnection _initMainChannel() {
    final channel = channelConnectionManager.connect('main');
    channel.stream.listen((message) {
      final body = message.body;
      final content = body.body;
      switch (body.type) {
        case 'notification':
          _onNotificationController.add(Notification(this, content));
          break;
        
        case 'mention':
          _onMentionController.add(Note(this, content));
          break;
      }
    });
    return channel;
  }

  void _uninitMainChannel(ChannelConnection channel) {
    channel.close();
  }

  /// Closes the client and cleans up any resources associated with it.
  /// 
  /// This must be called once the client is no longer needed or when
  /// the application needs to exit, otherwise it might hang due to the
  /// internal HTTP client, and some resources will still be held.
  void close() {
    api.close();
    _wsHeartbeatTimer?.cancel();
    wsClient.close();
  }
}