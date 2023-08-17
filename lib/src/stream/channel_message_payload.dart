class ChannelMessagePayload {
  ChannelMessagePayload(this.type, this.body);

  /// The type of the message.
  final String type;

  /// The body of the message.
  final dynamic body;

  Map<String, dynamic> toJson([String? id]) => {
      if (id != null) 'id': id,
      'type': type,
      'body': body
    };
}