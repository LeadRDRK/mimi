import 'note_subscription.dart';
import 'web_socket_client.dart';
import 'stream_message.dart';

/// Manages note subscriptions and automatically resubscribe them
/// whenever a new WebSocket connection is made.
class NoteSubscriptionManager {
  NoteSubscriptionManager(this.wsClient) {
    wsClient.onStateChange.listen((state) {
      if (state != WsClientState.connected) return;

      for (final subscription in subscriptions.values) {
        _sendSubscribePayload(subscription.id);
      }
    });
  }

  /// The WebSocket client.
  final WebSocketClient wsClient;

  /// The subscriptions mapped to their IDs.
  final Map<String, NoteSubscription> subscriptions = {};

  void _sendSubscribePayload(String id) {
    wsClient.add(StreamMessagePayload('s', { 'id': id }));
  }

  /// Subscribes to a note.
  NoteSubscription subscribe(String id) {
    _sendSubscribePayload(id);
    return NoteSubscription(this, id);
  }

  /// Unsubscribes from all currently subscribed notes.
  void unsubscribeAll() {
    for (final subscription in subscriptions.values) {
      subscription.unsubscribe();
    }
  }
}