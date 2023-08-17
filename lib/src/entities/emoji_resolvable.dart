import '../core/resolvable_id.dart';
import '../core/base.dart';
import '../core/client.dart';

class EmojiResolvable extends Base implements ResolvableId {
  EmojiResolvable(Client client, this.id)
  : super(client);

  @override
  final String id;

  // TODO: admin (remove, edit, etc.)
}