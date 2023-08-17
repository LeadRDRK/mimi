import 'dart:io';
import 'package:mimi/mimi.dart';

void main() async {
  /*
   * First, create an ApiClient.
   * You can also create a Client instead and use its ApiClient
   * as seen here.
   * The Client can later be used once a token has been acquired.
   */
  final client = Client('misskey.io');
  // Create the MiAuth session
  final auth = MiAuth(client,
    appName: 'Mimi - MiAuth example',
    permissions: [
      MiAuthPermission.readAccount
    ],
    allPermissions: true
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
       * client.login(result.token, result.user, fetchUser: true);
       * 
       * [user] and [fetchUser] are optional. If user is specified and
       * fetchUser is true, the client won't have to fetch the user again.
       */

      break;
    }

    print('Not authorized.');
  }

  // It is recommended to explicitly close the client when you're done.
  client.close();
}