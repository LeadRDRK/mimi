import '../structs/rgb_color.dart';
import '../core/client.dart';
import 'channel_resolvable.dart';

/// Partial details for a channel.
class ChannelLite extends ChannelResolvable {
  ChannelLite(Client client, Map<String, dynamic> map)
  : name = map['name'] as String,
    color = RGBColor(map['color'] as String),
    super(client, map['id'] as String);

  /// The name of the channel.
  final String name;

  /// The color of the channel.
  final RGBColor color;
}