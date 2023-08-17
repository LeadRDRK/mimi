import '../core/base.dart';
import '../core/client.dart';

class UserList extends Base {
  UserList(Client client, Map<String, dynamic> map)
  : id = map['id'] as String,
    createdAt = DateTime.parse(map['createdAt'] as String),
    name = map['name'] as String,
    userIds = map['userIds'] == null ? [] : List<String>.from(map['userIds']),
    isPublic = map['isPublic'] as bool,
    super(client);

  /// The ID of the user list.
  final String id;

  /// The time when the user list was created.
  final DateTime createdAt;

  /// The name of the user list.
  final String name;

  /// The IDs of the users in this list.
  final List<String> userIds;

  /// Whether this list is public.
  final bool isPublic;
}