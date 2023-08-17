import 'note_subscription_manager.dart';
import 'stream_message.dart';

class NoteSubscription {
  NoteSubscription(this.manager, this.id)
  : stream = manager.wsClient.stream.where((message) =>
        message.type == 'noteUpdated' && message.body.id == id
    );

  /// The manager.
  final NoteSubscriptionManager manager;

  /// The ID of the note.
  final String id;

  /// The stream.
  final Stream<ServerStreamMessage> stream;

  /// Unsubscribes from the note.
  void unsubscribe() {
    manager.wsClient.add(StreamMessagePayload('un', { 'id': id }));
  }
}