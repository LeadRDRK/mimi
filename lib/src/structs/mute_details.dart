import '../entities/user.dart';
import '../core/client.dart';

/// The details of a mute.
class MuteDetails {
  MuteDetails(Client client, Map<String, dynamic> map)
  : id = map['id'] as String,
    createdAt = DateTime.parse(map['createdAt'] as String),
    expiresAt = map['expiresAt'] == null ? null : DateTime.parse(map['expiresAt'] as String),
    muteeId = map['muteeId'] as String,
    mutee = User(client, map['mutee']);

  /// The ID of the mute.
  final String id;

  /// The time when the mute was created.
  final DateTime createdAt;

  /// The time when the mute expires, or `null` if never.
  final DateTime? expiresAt;

  /// The ID of the mutee.
  final String muteeId;

  /// The mutee.
  final User mutee;
}