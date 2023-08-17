import 'sw_subscription_resolvable.dart';
import '../core/client.dart';

class SwSubscription extends SwSubscriptionResolvable {
  SwSubscription(Client client, Map<String, dynamic> map)
  : userId = map['userId'] as String,
    sendReadMessage = map['sendReadMessage'] as bool,
    super(client, map['endpoint'] as String);

  /// The ID of the user for this subscription.
  final String userId;

  final bool sendReadMessage;
}