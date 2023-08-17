import '../core/base.dart';
import '../core/client.dart';
import '../core/resolvable_id.dart';

/// Data that can be resolved to an InviteCode.
class InviteCodeResolvable extends Base implements ResolvableId {
  InviteCodeResolvable(Client client, this.id)
  : super(client);

  /// The invite code's ID.
  @override
  final String id;

  /// Deletes the invite code.
  Future<void> delete() =>
      client.api.post('invite/delete', body: {
        'inviteId': id
      });
}