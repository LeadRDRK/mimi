import '../entities/user.dart';
import '../core/client.dart';

/// The details of a block.
class BlockDetails {
  BlockDetails(Client client, Map<String, dynamic> map)
  : id = map['id'] as String,
    createdAt = DateTime.parse(map['createdAt'] as String),
    blockeeId = map['blockeeId'] as String,
    blockee = User(client, map['blockee']);

  /// The ID of the block.
  final String id;

  /// The time when the block was created.
  final DateTime createdAt;

  /// The ID of the blockee.
  final String blockeeId;

  /// The blockee.
  final User blockee;
}