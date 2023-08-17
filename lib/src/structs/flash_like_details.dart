import '../entities/flash.dart';
import '../core/client.dart';

class FlashLikeDetails {
  FlashLikeDetails(Client client, Map<String, dynamic> map)
  : id = map['id'] as String,
    flash = Flash(client, map['flash']);

  /// The ID of the like.
  final String id;

  /// The flash.
  final Flash flash;
}