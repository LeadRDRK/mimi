import 'dart:async';
import 'dart:io';
import 'dart:collection';
import 'package:mimi/mimi.dart';

/// The maximum number of subscriptions before a previous one is cancelled.
final maxSubscriptions = 20;

void main() async {
  print('Stream API example');

  stdout.write('Enter a host (e.g. misskey.io): ');
  final host = stdin.readLineSync()!;

  final client = Client(host);
  
  print('Connecting to WebSocket...');
  /**
   * initWs() can be called implicitly using login().
   * 
   * In this example, we don't need user credentials,
   * so we must call initWs() directly.
   * 
   * However, some instances have disabled access to the
   * streaming API without proper credentials, so this example
   * might fail with them (notably, all Firefish instances)
   */
  await client.initWs();

  print('Listening to the local timeline\n');
  final subscriptions = Queue<StreamSubscription>();
  await for (final note in client.timelineStreams.local) {
    print('${note.user.displayName} (@${note.user.username})\n${note.text}\n');

    if (subscriptions.length >= maxSubscriptions) {
      subscriptions.removeFirst().cancel();
    }
    
    subscriptions.add(note.onReacted.listen((event) {
      print('onReacted | Reaction: ${event.reaction} - User ID: ${event.userId}\n');
    }));
  }
  
  client.close();
}