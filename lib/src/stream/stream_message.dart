abstract class StreamMessage {
  /// The type of the message.
  String get type;

  /// The content of the message.
  dynamic get body;

  Map<String, dynamic> toJson() => {
      'type': type,
      'body': body
    };
}

class ServerStreamMessage extends StreamMessage {
  ServerStreamMessage(Map<String, dynamic> map)
  : type = map['type'] as String,
    body = ServerStreamMessageContent(map['body']);

  @override
  final String type;

  @override
  final ServerStreamMessageContent body;
}

class ServerStreamMessageContent {
  ServerStreamMessageContent(Map<String, dynamic> map)
  : id = map['id'] as String,
    type = map['type'] as String,
    body = map['body'];

  /// The ID of the channel.
  final String id;

  /// The type of the content.
  final String type;

  /// The content body.
  final dynamic body;
}

class StreamMessagePayload extends StreamMessage {
  StreamMessagePayload(this.type, this.body);

  @override
  String type;

  @override
  dynamic body;
}