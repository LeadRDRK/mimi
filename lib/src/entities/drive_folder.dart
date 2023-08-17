import '../core/base.dart';
import '../core/client.dart';

/// A folder in a user's Drive.
class DriveFolder extends Base {
  DriveFolder(Client client, Map<String, dynamic> map)
  : id = map['id'] as String,
    createdAt = DateTime.parse(map['createdAt'] as String),
    name = map['name'] as String,
    foldersCount = map['foldersCount'] as int?,
    filesCount = map['filesCount'] as int?,
    parentId = map['parentId'] as String?,
    parent = map['parent'] == null ? null : DriveFolder(client, map['parent']),
    super(client);

  /// The ID of the folder.
  final String id;

  /// The time when the folder was created.
  final DateTime createdAt;

  /// The name of the folder.
  final String name;

  /// The number of folders in this folder.
  final int? foldersCount;

  /// The number of files in this folder.
  final int? filesCount;

  /// The ID of the parent folder.
  final String? parentId;

  /// The parent of the folder.
  final DriveFolder? parent;
}