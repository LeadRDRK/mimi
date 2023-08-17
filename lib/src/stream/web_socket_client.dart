import 'dart:convert';
import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'stream_message.dart';

/// Small wrapper around WebSocketChannel.
class WebSocketClient {
  WebSocketClient() {
    onStateChange = _onStateChangeController.stream;
    stream = _streamController.stream;
  }

  /// The WebSocket channel.
  WebSocketChannel get channel =>
      _channel == null ?
      throw StateError('WebSocket channel has not been connected') :
      _channel!;

  WebSocketChannel? _channel;

  /// The current state of the client.
  WsClientState get state => _state;
  WsClientState _state = WsClientState.disconnected;

  /// The close code set when the WebSocket connection is closed.
  ///
  /// Before the connection has been closed, this will be null.
  int? get closeCode => _closeCode;
  int? _closeCode;

  /// Emitted when the state of the client changes.
  late final Stream<WsClientState> onStateChange;
  final _onStateChangeController = StreamController<WsClientState>.broadcast();

  void _updateState(WsClientState state) {
    if (_state == state) return;
    _state = state;
    _onStateChangeController.add(state);
  }

  /// Connects to the stream. Resolves immediately if the stream
  /// is already connecting or has connected.
  Future<void> connect(String host, String? token) async {
    if (_channel != null) return;

    final uri = Uri(
      scheme: 'wss',
      host: host,
      path: 'streaming',
      queryParameters: {
        if (token != null) 'i': token,
        '_t': DateTime.now().millisecondsSinceEpoch.toString()
      }
    );

    _closeCode = null;
    final channel = _channel = WebSocketChannel.connect(uri);
    _updateState(WsClientState.connecting);

    try {
      await channel.ready;
    }
    catch (e) {
      _updateState(WsClientState.disconnected);
      rethrow;
    }
    _updateState(WsClientState.connected);

    channel.stream.listen(
      (message) => _streamController.add(ServerStreamMessage(jsonDecode(message as String))),
      onError: _streamController.addError,
      onDone: close
    );
  }

  /// The server message stream.
  late final Stream<ServerStreamMessage> stream;
  final _streamController = StreamController<ServerStreamMessage>.broadcast();

  /// Adds a message to the sink.
  void add(StreamMessage message) =>
      channel.sink.add(jsonEncode(message));

  /// Adds an error to the sink.
  void addError(Object error, [StackTrace? stackTrace]) =>
      channel.sink.addError(error, stackTrace);
  
  /// Consumes the elements of a stream and add them to the sink.
  Future<dynamic> addStream(Stream<StreamMessage> stream) =>
      channel.sink.addStream(stream.map((message) => jsonEncode(message)));
  
  /// Sends a heartbeat to the server.
  void heartbeat() {
    channel.sink.add('h');
  }

  /// Closes the connection (if open) and resets the client's state.
  /// 
  /// [closeCode] is the WebSocket close code.
  /// Default: `1000` (normal closure)
  /// 
  /// [closeReason] is a String describing the close reason. Must be no
  /// longer than 123 bytes (UTF-8).
  /// Default: `null`
  Future<dynamic> close([int? closeCode, String? closeReason]) async {
    final channel = _channel;
    if (channel == null) return;

    dynamic res;
    if (channel.closeCode == null) {
      res = await channel.sink.close(closeCode ?? 1000, closeReason);
    }
    _closeCode = channel.closeCode;
    _channel = null;
    _updateState(WsClientState.disconnected);
    return res;
  }
}

enum WsClientState {
  disconnected,
  connecting,
  connected
}