import '../core/base.dart';
import '../core/client.dart';

class Antenna extends Base {
  Antenna(Client client, Map<String, dynamic> map)
  : id = map['id'] as String,
    createdAt = DateTime.parse(map['createdAt'] as String),
    name = map['name'] as String,
    keywords = List<String>.from(map['keywords']),
    excludeKeywords = List<String>.from(map['excludeKeywords']),
    src = map['src'] as String,
    userListId = map['userListId'] as String?,
    users = List<String>.from(map['users']),
    caseSensitive = map['caseSensitive'] as bool,
    notify = map['notify'] as bool,
    withReplies = map['withReplies'] as bool,
    withFile = map['withFile'] as bool,
    isActive = map['isActive'] as bool,
    hasUnreadNote = map['hasUnreadNote'] as bool,
    super(client);

  /// The ID of the antenna.
  final String id;

  /// The time when the antenna was created.
  final DateTime createdAt;

  /// The name of the antenna.
  final String name;

  /// The keywords to include in the antenna.
  final List<String> keywords;

  /// The keywords to exclude from the antenna.
  final List<String> excludeKeywords;

  /// The source of the antenna.
  final String src;

  /// The ID of the user list associated with the antenna.
  final String? userListId;

  /// The users associated with the antenna.
  final List<String> users;

  /// Whether or not the antenna is case sensitive.
  final bool caseSensitive;

  /// Whether or not to notify for the antenna.
  final bool notify;

  /// Whether or not to include replies for the antenna.
  final bool withReplies;

  /// Whether or not to include files for the antenna.
  final bool withFile;

  /// Whether or not the antenna is active.
  final bool isActive;

  /// Whether or not the antenna has unread notes.
  final bool hasUnreadNote;
}