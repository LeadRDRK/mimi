import 'sw_subscription.dart';
import '../core/client.dart';

class SwSubscriptionResult extends SwSubscription {
  SwSubscriptionResult(Client client, Map<String, dynamic> map)
  : state = SwSubscriptionState.values.firstWhere((e) => e.value == map['state'] as String),
    key = map['key'] as String?,
    super(client, map);

  /// The state of this subscription.
  final SwSubscriptionState state;

  /// The key.
  final String? key;
}

enum SwSubscriptionState {
  alreadySubscribed('already-subscribed'),
  subscribed('subscribed');

  const SwSubscriptionState(this.value);
  final String value;
}