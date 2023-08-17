import 'user_lite.dart';
import '../core/base.dart';
import '../core/client.dart';

class Clip extends Base {
  Clip(Client client, Map<String, dynamic> map)
  : id = map['id'] as String,
    createdAt = DateTime.parse(map['createdAt'] as String),
    lastClippedAt = map['lastClippedAt'] == null ? null : DateTime.parse(map['lastClippedAt'] as String),
    userId = map['userId'] as String,
    user = UserLite(client, map['user'] as Map<String, dynamic>),
    name = map['name'] as String,
    description = map['description'] as String?,
    isPublic = map['isPublic'] as bool,
    isFavorited = (map['isFavorited'] ?? false) as bool,
    favoritedCount = map['favoritedCount'] as int,
    super(client);

  /// The ID of the clip.
  final String id;

  /// The time when the clip was created.
  final DateTime createdAt;

  /// The time when the clip was last modified, or `null` if never.
  final DateTime? lastClippedAt;

  /// The ID of the user who owns this clip.
  final String userId;

  /// The user who owns this clip.
  final UserLite user;

  /// The name of the clip.
  final String name;

  /// The description of the clip.
  final String? description;

  /// Whether the clip is public or not.
  final bool isPublic;

  /// Whether the clip is favorited by the client user.
  final bool isFavorited;

  /// The favorited count of the clip.
  final int favoritedCount;

  /// TODO
  // Future<List<Note>> fetchNotes();
}