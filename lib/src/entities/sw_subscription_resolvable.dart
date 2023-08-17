import '../core/base.dart';
import '../core/client.dart';
import 'sw_subscription.dart';

class SwSubscriptionResolvable extends Base {
  SwSubscriptionResolvable(Client client, this.endpoint)
  : super(client);

  /// The endpoint of the push service.
  final String endpoint;

  /// Fetches the subscription.
  Future<SwSubscription> fetch() async =>
      SwSubscription(client, await client.api.post('sw/show-registration', body: {
        'endpoint': endpoint
      }));

  /// Updates the subscription.
  Future<SwSubscription> update({
    bool? sendReadMessage
  }) async =>
      SwSubscription(client, await client.api.post('sw/update-registration', body: {
        'endpoint': endpoint,
        if (sendReadMessage != null) 'sendReadMessage': sendReadMessage
      }));

  /// Unregisters the push service.
  Future<void> unregister() =>
      client.api.post('sw/unregister', body: {
        'endpoint': endpoint
      });
}