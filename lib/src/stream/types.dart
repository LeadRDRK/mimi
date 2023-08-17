class PollVotedEvent {
  PollVotedEvent(Map<String, dynamic> map)
  : choice = map['choice'] as int,
    userId = map['userId'] as String;

  /// The choice that was voted.
  final int choice;

  /// The ID of the user who voted for the choice.
  final String userId;
}

class ReactedEvent {
  ReactedEvent(Map<String, dynamic> map)
  : reaction = map['reaction'] as String,
    emoji = map['emoji'] == null ? null : ReactedEmoji(map['emoji']),
    userId = map['userId'] as String;
  
  /// The name of the reaction.
  final String reaction;

  /// The reaction emoji.
  final ReactedEmoji? emoji;

  /// The ID of the user who reacted.
  final String userId;
}

class ReactedEmoji {
  ReactedEmoji(Map<String, dynamic> map)
  : name = map['name'] as String,
    url = map['url'] as String;

  /// The name of the emoji.
  final String name;

  /// The URL of the emoji.
  final String url;
}

class UnreactedEvent {
  UnreactedEvent(Map<String, dynamic> map)
  : reaction = map['reaction'] as String,
    userId = map['userId'] as String;
  
  /// The name of the reaction.
  final String reaction;

  /// The ID of the user who unreacted.
  final String userId;
}