import 'user_resolvable.dart';
import '../structs/badge_role.dart';
import '../structs/instance.dart';
import '../core/client.dart';

enum UserStatus {
  unknown,
  online,
  active,
  offline
}

/// Partial details for a user.
class UserLite extends UserResolvable {
  UserLite(Client client, Map<String, dynamic> map)
  : name = map['name'] as String?,
    username = map['username'] as String,
    _host = map['host'] as String?,
    avatarUrl = map['avatarUrl'] as String?,
    avatarBlurhash = map['avatarBlurhash'] as String?,
    isAdmin = (map['isAdmin'] ?? false) as bool,
    isModerator = (map['isModerator'] ?? false) as bool,
    isBot = (map['isBot'] ?? false) as bool,
    isCat = (map['isCat'] ?? false) as bool,
    onlineStatus = map['onlineStatus'] == null ?
        UserStatus.unknown :
        UserStatus.values.firstWhere((e) => e.name == map['onlineStatus']),
    instance = map['instance'] == null ? null : Instance(map['instance']),
    // 13.4.0
    badgeRoles = map['badgeRoles'] == null ?
        [] :
        (map['badgeRoles'] as List<dynamic>).map((e) => BadgeRole(e)).toList(),
    super(client, map['id'] as String)
  {
    final emojis = map['emojis'];

    if (emojis is Map) {
      // Misskey 13.2.4
      this.emojis = Map.from(map['emojis']);
    }
    else if (emojis is List) {
      // FoundKey
      this.emojis = {};
      for (final emoji in emojis) {
        emoji as Map<String, dynamic>;
        this.emojis[emoji['name'] as String] = emoji['url'] as String;
      }
    }
    else {
      this.emojis = {};
    }
  }

  /// The user's name, or `null` if they don't have one.
  /// 
  /// See also: [displayName]
  final String? name;

  /// The username of the user.
  /// 
  /// See also: [displayName]
  final String username;

  /// The name of this user, or their username if they don't have one.
  String get displayName => name ?? username;

  /// Internal.
  final String? _host;

  /// The host that this user belongs to.
  String get host => _host ?? client.host;

  /// Whether this user belongs to the local host.
  bool get isLocal => _host == null;

  /// The URL of the user's avatar.
  final String? avatarUrl;

  /// The BlurHash of the user's avatar
  final String? avatarBlurhash;

  /// Whether this user is an admin.
  final bool isAdmin;

  /// Whether this user is a moderator.
  final bool isModerator;

  /// Whether this user is a bot.
  final bool isBot;

  /// :3
  final bool isCat;

  /// The current status of this user.
  final UserStatus onlineStatus;

  /// The remote instance of this user, or `null` if local.
  final Instance? instance;

  /// The emojis that are used on the profile of this user.
  /// 
  /// Contains icon URLs mapped to the emoji names.
  /// Used for emojis that came from a remote instance.
  late final Map<String, String> emojis;

  /// The badge roles of this user.
  final List<BadgeRole> badgeRoles;
}