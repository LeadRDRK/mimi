import '../entities/user_lite.dart';
import '../core/client.dart';

class Reaction {
  Reaction(Client client, Map<String, dynamic> map)
  : id = map['id'] as String,
    createdAt = DateTime.parse(map['createdAt'] as String),
    type = map['type'] as String,
    user = UserLite(client, map['user']);

  /// The ID of the reaction.
  final String id;

  /// The time when this reaction was made.
  final DateTime createdAt;

  /// The type (emoji) of the reaction.
  final String type;

  /// The user that made this reaction.
  final UserLite user;
}