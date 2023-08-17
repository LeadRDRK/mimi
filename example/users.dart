import 'dart:io';
import 'package:mimi/mimi.dart';

void main() async {
  print('Users API example');

  stdout.write('Enter a host (e.g. misskey.io): ');
  final host = stdin.readLineSync()!;
  stdout.write('Enter a username: ');
  final username = stdin.readLineSync()!;

  final client = Client(host);
  final user = await client.users.fetchByUsername(username);

  print('''

User: ${user.displayName} (@${user.username})
Description: ${user.description}''');
  
  client.close();
}