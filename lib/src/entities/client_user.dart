import 'user.dart';
import '../core/client.dart';

/// A client user.
/// TODO
class ClientUser extends User {
  ClientUser(Client client, Map<String, dynamic> map)
  : super(client, map);
}