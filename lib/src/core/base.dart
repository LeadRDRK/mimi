import 'client.dart';

abstract class Base {
  Base(this.client);

  /// Reference to the Client.
  final Client client;
}