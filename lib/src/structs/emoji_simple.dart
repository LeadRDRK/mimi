class EmojiSimple {
  EmojiSimple(Map<String, dynamic> map)
  : aliases = List<String>.from(map['aliases']),
    name = map['name'] as String,
    category = map['category'] as String?,
    url = map['url'] as String,
    isSensitive = (map['isSensitive'] ?? false) as bool,
    reactionRoleIds =
      map['roleIdsThatCanBeUsedThisEmojiAsReaction'] == null ?
      [] :
      List<String>.from(map['roleIdsThatCanBeUsedThisEmojiAsReaction']);

  /// The aliases of the emoji.
  final List<String> aliases;

  /// The name of the emoji.
  final String name;

  /// The category of the emoji.
  final String? category;

  /// The URL of the emoji.
  final String url;

  /// Whether this emoji is sensitive.
  final bool isSensitive;

  /// List of role IDs that are allowed to use this emoji as a reaction.
  /// If empty, anyone can use it.
  /// 
  /// Adapted from `roleIdsThatCanBeUsedThisEmojiAsReaction` (name was
  /// too long and confusing)
  final List<String> reactionRoleIds;
}