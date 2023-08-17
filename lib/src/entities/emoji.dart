import 'emoji_resolvable.dart';
import '../structs/emoji_simple.dart';
import '../core/client.dart';

class Emoji extends EmojiResolvable implements EmojiSimple {
  Emoji(Client client, Map<String, dynamic> map)
  : aliases = List<String>.from(map['aliases']),
    name = map['name'] as String,
    category = map['category'] as String?,
    _host = map['host'] as String?,
    url = map['url'] as String,
    license = map['license'] as String?,
    isSensitive = map['isSensitive'] as bool,
    localOnly = map['localOnly'] as bool,
    reactionRoleIds =
      List<String>.from(map['roleIdsThatCanBeUsedThisEmojiAsReaction']),
    super(client, map['id'] as String);

  @override
  /// The aliases of the emoji.
  final List<String> aliases;

  @override
  /// The name of the emoji.
  final String name;

  @override
  /// The category of the emoji.
  final String? category;

  /// Internal.
  final String? _host;

  /// The host that this emoji belongs to.
  String get host => _host ?? client.host;

  /// Whether this emoji belongs to the local host.
  bool get isLocal => _host == null;

  @override
  /// The URL of the emoji.
  final String url;

  /// The license of the emoji.
  final String? license;

  @override
  /// Whether this emoji is sensitive.
  final bool isSensitive;

  final bool localOnly;

  @override
  /// List of role IDs that are allowed to use this emoji as a reaction.
  /// If empty, anyone can use it.
  /// 
  /// Adapted from `roleIdsThatCanBeUsedThisEmojiAsReaction` (name was
  /// too long and confusing)
  final List<String> reactionRoleIds;
}