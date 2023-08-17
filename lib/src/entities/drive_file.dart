import '../core/base.dart';
import 'user_lite.dart';
import '../structs/rgb_color.dart';
import 'drive_folder.dart';
import '../core/client.dart';

/// A file in a user's Drive.
class DriveFile extends Base {
  DriveFile(Client client, Map<String, dynamic> map)
  : id = map['id'] as String,
    createdAt = DateTime.parse(map['createdAt'] as String),
    name = map['name'] as String,
    type = map['type'] as String,
    md5 = map['md5'] as String,
    size = map['size'] as int,
    isSensitive = map['isSensitive'] as bool,
    blurhash = map['blurhash'] as String?,
    properties = DriveFileProperties(map['properties']),
    url = map['url'] as String?,
    thumbnailUrl = map['thumbnailUrl'] as String?,
    comment = map['comment'] as String?,
    folderId = map['folderId'] as String?,
    folder = map['folder'] == null ? null : DriveFolder(client, map['folder']),
    userId = map['userId'] as String?,
    user = map['user'] == null ? null : UserLite(client, map['user']),
    super(client);

  /// The ID of the file.
  final String id;

  /// The time when the file was created.
  final DateTime createdAt;

  /// The name of the file.
  final String name;

  /// The MIME type of the file.
  final String type;

  /// The MD5 hash of the file.
  final String md5;

  /// The size of the file in bytes.
  final int size;

  /// Whether the file is marked as sensitive or not.
  final bool isSensitive;

  /// The BlurHash of the file.
  final String? blurhash;

  /// Additional properties of the file.
  final DriveFileProperties properties;

  /// The URL of the file.
  final String? url;

  /// The URL of the thumbnail of the file.
  final String? thumbnailUrl;

  /// The comment associated with the file.
  final String? comment;

  /// The ID of the folder containing the file.
  final String? folderId;

  /// The folder containing the file.
  final DriveFolder? folder;

  /// The ID of the user who owns the file.
  final String? userId;

  /// The user who owns the file.
  final UserLite? user;
}

/// A drive file's properties.
/// 
/// Currently, it contains properties for image files only.
class DriveFileProperties {
  DriveFileProperties(Map<String, dynamic> map)
  : width = map['width'] != null ? map['width'] as int : null,
    height = map['height'] != null ? map['height'] as int : null,
    orientation = map['orientation'] != null ? map['orientation'] as int : null,
    avgColor = map['avgColor'] != null ? RGBColor(map['avgColor']) : null;

  /// The width of the image.
  final int? width;

  /// The height of the image.
  final int? height;

  /// The orientation of the image.
  final int? orientation;

  /// The average color of the image.
  final RGBColor? avgColor;
}