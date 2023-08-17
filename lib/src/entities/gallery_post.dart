import '../core/base.dart';
import 'user_lite.dart';
import 'drive_file.dart';
import '../core/client.dart';

class GalleryPost extends Base {
  GalleryPost(Client client, Map<String, dynamic> map)
  : id = map['id'] as String,
    createdAt = DateTime.parse(map['createdAt'] as String),
    updatedAt = DateTime.parse(map['updatedAt'] as String),
    title = map['title'] as String,
    description = map['description'] as String?,
    userId = map['userId'] as String,
    user = UserLite(client, map['user'] as Map<String, dynamic>),
    fileIds = map['fileIds'] == null ? [] : List<String>.from(map['fileIds']),
    files = map['files'] == null ?
        [] :
        (map['files'] as List<dynamic>).map((e) => DriveFile(client, e)).toList(),
    tags = map['tags'] == null ? [] : List<String>.from(map['tags']),
    isSensitive = map['isSensitive'] as bool,
    super(client);

  /// The ID of the post.
  final String id;

  /// The time when this post was created.
  final DateTime createdAt;

  /// The time when this post was updated.
  final DateTime updatedAt;

  /// The title of the post.
  final String title;

  /// The description of the post.
  final String? description;

  /// The ID of the author of the post.
  final String userId;

  /// The author of the post.
  final UserLite user;

  /// The IDs of the files attached to this post.
  final List<String> fileIds;

  /// The files attached to this post.
  final List<DriveFile> files;

  /// The tags of the post.
  final List<String> tags;

  /// Whether the post is marked as sensitive.
  final bool isSensitive;
}