import 'dart:io';
import 'package:mimi/mimi.dart';

void main() async {
  print('MiAuth example');

  stdout.write('Enter a host (e.g. misskey.io): ');
  final host = stdin.readLineSync()!;

  final client = Client(host);
  // Create the MiAuth session
  final auth = MiAuth(client,
    appName: 'Mimi - MiAuth example',
    permissions: [
      MiAuthPermission.readAccount
    ],
    // Or you can use allPermissions
    // allPermissions: true
  );

  print('Open this link in your browser: ${auth.url}');
  print('Hit Enter when you have authorized the app.');
  while (true) {
    stdin.readLineSync();

    print('Checking...');
    final result = await auth.check();
    if (result != null) {
      print('Application authorized.');
      print('User: ${result.user.displayName} (@${result.user.username})');
      print('Token: ${result.token}');

      /*
       * At this point, you can login with the client.
       * client.login(result.token, user: result.user, fetchUser: true);
       * 
       * [user] and [fetchUser] are optional. If user is specified and
       * fetchUser is true, the client won't have to fetch the user again.
       */

      break;
    }

    print('Not authorized.');
  }

  // You must explicitly close the client when you're done.
  client.close();
}