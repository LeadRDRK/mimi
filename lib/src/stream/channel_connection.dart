import 'dart:async';
import 'channel_connection_manager.dart';
import 'stream_message.dart';
import 'channel_message_payload.dart';

class ChannelConnection implements StreamSink<ChannelMessagePayload> {
  ChannelConnection(this.manager, this.channel, this.id, this.params)
  : stream = manager.wsClient.stream.where((message) =>
        message.type == 'channel' && message.body.id == id
    );

  /// The manager.
  final ChannelConnectionManager manager;

  /// The channel name.
  final String channel;

  /// The ID of the connection.
  final String id;

  /// The parameters that were used when connecting to this channel.
  final Map<String, dynamic>? params;

  /// The stream.
  final Stream<ServerStreamMessage> stream;

  final _completer = Completer<void>();

  StreamMessagePayload _makeMessage(ChannelMessagePayload body) =>
      StreamMessagePayload('ch', body.toJson(id));

  @override
  void add(ChannelMessagePayload body) =>
      manager.wsClient.add(_makeMessage(body));

  /// Alias of `manager.wsClient.addError`
  @override
  void addError(Object error, [StackTrace? stackTrace]) =>
      manager.wsClient.addError(error, stackTrace);
  
  @override
  Future<dynamic> addStream(Stream<ChannelMessagePayload> stream) =>
      manager.wsClient.addStream(stream.map((body) => _makeMessage(body)));
  
  @override
  Future<void> close() {
    if (_completer.isCompleted) return done;
    manager.wsClient.add(StreamMessagePayload('disconnect', { 'id': id }));
    _completer.complete();
    manager.connections.remove(id);
    return done;
  }

  @override
  Future<void> get done => _completer.future;
}