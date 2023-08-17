import 'package:uuid/uuid.dart';
import '../core/client.dart';
import '../entities/client_user.dart';
import '../core/base.dart';

final uuid = Uuid();

class MiAuth extends Base {
  MiAuth(Client client, {
    this.appName = '',
    this.appIcon = '',
    this.callback = '',
    this.permissions = const [],
    this.allPermissions = false
  })
  : sessionId = uuid.v4(),
    super(client);

  MiAuth.newSession(MiAuth old)
  : sessionId = uuid.v4(),
    appName = old.appName,
    appIcon = old.appIcon,
    callback = old.callback,
    permissions = old.permissions,
    allPermissions = old.allPermissions,
    super(old.client);

  /// The session ID.
  final String sessionId;

  /// The app name.
  final String appName;

  /// The app icon.
  final String appIcon;

  /// The URL to be redirected to after authentication.
  final String callback;

  /// The permissions required by this application.
  final List<MiAuthPermission> permissions;

  /// Whether to enable all permissions. This will override [permissions] if set.
  final bool allPermissions;  
  
  /// The authentication URL.
  Uri get url =>
      Uri(
        scheme: client.api.scheme,
        host: client.host,
        path: 'miauth/$sessionId',
        queryParameters: {
          'name': appName,
          'icon': appIcon,
          'callback': callback,
          'permission':
              (allPermissions ? MiAuthPermission.values : permissions)
              .map((e) => e.value).join(',')
        }
      );
  
  /// The authentication results.
  /// 
  /// Will be defined once [check] succeeds.
  AuthResult? result;
  
  /// Check if the authentication session has been completed.
  /// 
  /// If the check is successful, returns the auth results
  /// containing the token and user details.
  /// [result] will be defined once the check succeeds, and subsequent
  /// calls to this function will return the value immediately.
  Future<AuthResult?> check() async {
    if (result != null) return result;

    final res = await client.api.post('miauth/$sessionId/check');
    if (res['ok'] == true) {
      return AuthResult(client, res);
    }

    return null;
  }
}

class AuthResult extends Base {
  AuthResult(Client client, Map<String, dynamic> map)
  : token = map['token'] as String,
    user = ClientUser(client, map['user']),
    super(client);

  String token;
  ClientUser user;
}

enum MiAuthPermission {
  readAccount('read:account'),
	writeAccount('write:account'),
	readBlocks('read:blocks'),
  writeBlocks('write:blocks'),
  readDrive('read:drive'),
  writeDrive('write:drive'),
  readFavorites('read:favorites'),
  writeFavorites('write:favorites'),
  readFollowing('read:following'),
  writeFollowing('write:following'),
  readMessaging('read:messaging'),
  writeMessaging('write:messaging'),
  readMutes('read:mutes'),
  writeMutes('write:mutes'),
  writeNotes('write:notes'),
  readNotifications('read:notifications'),
  writeNotifications('write:notifications'),
  readReactions('read:reactions'),
  writeReactions('write:reactions'),
  writeVotes('write:votes'),
  readPages('read:pages'),
  writePages('write:pages'),
  writePageLikes('write:page-likes'),
  readPageLikes('read:page-likes'),
  readUserGroups('read:user-groups'),
  writeUserGroups('write:user-groups'),
  readChannels('read:channels'),
  writeChannels('write:channels'),
  readGallery('read:gallery'),
  writeGallery('write:gallery'),
  readGalleryLikes('read:gallery-likes'),
  writeGalleryLikes('write:gallery-likes'),
  writeFlash('write:flash'),
  writeFlashLikes('write:flash-likes');

  const MiAuthPermission(this.value);
  final String value;
}