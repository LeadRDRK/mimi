import '../core/base.dart';
import 'user_lite.dart';
import '../core/client.dart';

class Flash extends Base {
  Flash(Client client, Map<String, dynamic> map)
  : id = map['id'] as String,
    createdAt = DateTime.parse(map['createdAt'] as String),
    updatedAt = DateTime.parse(map['updatedAt'] as String),
    title = map['title'] as String,
    summary = map['summary'] as String,
    script = map['script'] as String,
    userId = map['userId'] as String,
    user = UserLite(client, map['user'] as Map<String, dynamic>),
    likedCount = map['likedCount'] as int,
    isLiked = (map['isLiked'] ?? false) as bool,
    super(client);

  /// The ID of the flash.
  final String id;

  /// The time when this flash was created.
  final DateTime createdAt;

  /// The time when this flash was updated.
  final DateTime updatedAt;

  /// The title of the flash.
  final String title;

  /// The summary of the flash.
  final String summary;

  /// The script of the flash.
  final String script;

  /// The ID of the author of the flash.
  final String userId;

  /// The author of the flash.
  final UserLite user;

  /// The liked count of the flash.
  final int likedCount;

  /// Whether this flash is liked by the client user.
  final bool isLiked;
}