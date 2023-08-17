import 'dart:async';
import '../entities/note.dart';
import '../core/client.dart';
import 'channel_connection.dart';

class _TimelineController {
  _TimelineController(this.client, this.name, [bool withReplies = false]) {
    controller.onListen = () {
      if (connection != null) return;
      connection = client.channelConnectionManager.connect('${name}Timeline',
        params: { 'withReplies': withReplies }
      );
      connection!.stream.listen((message) {
        if (message.body.type != 'note') return;
        controller.add(Note(client, message.body.body));
      });
    };

    controller.onCancel = () {
      if (controller.hasListener) return;
      connection?.close();
      connection = null;
    };
  }

  final Client client;
  final String name;

  final controller = StreamController<Note>.broadcast();
  Stream<Note> get stream => controller.stream;

  ChannelConnection? connection;
}

class TimelineStreams {
  TimelineStreams(this.client) {
    home = _TimelineController(client, 'home').stream;
    local = _TimelineController(client, 'local').stream;
    global = _TimelineController(client, 'global').stream;
    hybrid = _TimelineController(client, 'hybrid').stream;

    homeWithReplies = _TimelineController(client, 'home', true).stream;
    localWithReplies = _TimelineController(client, 'local', true).stream;
    globalWithReplies = _TimelineController(client, 'global', true).stream;
    hybridWithReplies = _TimelineController(client, 'hybrid', true).stream;
  }

  /// The client.
  final Client client;

  /// The home timeline.
  late final Stream<Note> home;

  /// The local timeline.
  late final Stream<Note> local;

  /// The global timeline.
  late final Stream<Note> global;

  /// The hybrid timeline.
  late final Stream<Note> hybrid;

  /// The home timeline with replies.
  late final Stream<Note> homeWithReplies;

  /// The local timeline with replies.
  late final Stream<Note> localWithReplies;

  /// The global timeline with replies.
  late final Stream<Note> globalWithReplies;

  /// The hybrid timeline with replies.
  late final Stream<Note> hybridWithReplies;
}