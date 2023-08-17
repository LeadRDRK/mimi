import '../core/base.dart';
import '../core/client.dart';
import '../core/resolvable_id.dart';

/// Data that can be resolved to a Channel.
class ChannelResolvable extends Base implements ResolvableId {
  ChannelResolvable(Client client, this.id)
  : super(client);

  /// The ID of the channel.
  @override
  final String id;

  // TODO: listFeatured()
}