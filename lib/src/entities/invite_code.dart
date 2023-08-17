import 'invite_code_resolvable.dart';
import '../core/client.dart';
import 'user_lite.dart';

class InviteCode extends InviteCodeResolvable {
  InviteCode(Client client, Map<String, dynamic> map)
  : code = map['code'] as String,
    expiresAt = map['expiresAt'] == null ? null : DateTime.parse(map['expiresAt'] as String),
    createdAt = DateTime.parse(map['createdAt'] as String),
    createdBy = map['createdBy'] == null ? null : UserLite(client, map['createdBy']),
    usedBy = map['usedBy'] == null ? null : UserLite(client, map['usedBy']),
    usedAt = map['usedAt'] == null ? null : DateTime.parse(map['usedAt'] as String),
    used = map['used'] as bool,
    super(client, map['id'] as String);

  /// The code.
  final String code;

  /// The time when the code expires.
  final DateTime? expiresAt;

  /// The time when the code was created.
  final DateTime createdAt;

  /// The user who created the invite code.
  final UserLite? createdBy;

  /// The user who used the invite code.
  final UserLite? usedBy;

  /// The time when the invite code was used.
  final DateTime? usedAt;

  /// Whether the invite code has been used.
  final bool used;
}