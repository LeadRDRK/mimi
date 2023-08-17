import 'user_lite.dart';
import 'note.dart';
import 'page.dart';
import '../core/client.dart';
import '../structs/user_relation.dart';
import '../structs/user_field.dart';

/// A user.
class User extends UserLite implements UserRelation {
  User(Client client, Map<String, dynamic> map)
  : url = map['url'] as String?,
    uri = map['uri'] as String?,
    movedToUri = map['movedToUri'] as String?,
    alsoKnownAs = map['alsoKnownAs'] == null ? [] : List<String>.from(map['alsoKnownAs']),
    createdAt = DateTime.parse(map['createdAt']),
    updatedAt = map['updatedAt'] == null ? null : DateTime.parse(map['updatedAt']),
    lastFetchedAt = map['lastFetchedAt'] == null ? null : DateTime.parse(map['lastFetchedAt']),
    bannerUrl = map['bannerUrl'] as String?,
    bannerBlurhash = map['bannerBlurhash'] as String?,
    isLocked = map['isLocked'] as bool,
    isSilenced = map['isSilenced'] as bool,
    isSuspended = map['isSuspended'] as bool,
    description = map['description'] as String?,
    location = map['location'] as String?,
    birthday = map['birthday'] as String?,
    lang = map['lang'] as String?,
    fields = (map['fields'] as List<dynamic>).map((e) => UserField(e)).toList(),
    followersCount = map['followersCount'] as int,
    followingCount = map['followingCount'] as int,
    notesCount = map['notesCount'] as int,
    pinnedNoteIds = List<String>.from(map['pinnedNoteIds']),
    pinnedNotes = (map['pinnedNotes'] as List<dynamic>).map((e) => Note(client, e)).toList(),
    pinnedPageId = map['pinnedPageId'] as String?,
    pinnedPage = map['pinnedPage'] != null ? Page(client, map['pinnedPage']) : null,
    publicReactions = map['publicReactions'] as bool,
    twoFactorEnabled = map['twoFactorEnabled'] as bool,
    usePasswordLessLogin = map['usePasswordLessLogin'] as bool,
    securityKeys = map['securityKeys'] as bool,
    isFollowing = (map['isFollowing'] ?? false) as bool,
    isFollowed = (map['isFollowed'] ?? false) as bool,
    hasPendingFollowRequestFromYou = (map['hasPendingFollowRequestFromYou'] ?? false) as bool,
    hasPendingFollowRequestToYou = (map['hasPendingFollowRequestToYou'] ?? false) as bool,
    isBlocking = (map['isBlocking'] ?? false) as bool,
    isBlocked = (map['isBlocked'] ?? false) as bool,
    isMuted = (map['isMuted'] ?? false) as bool,
    isRenoteMuted = (map['isRenoteMuted'] ?? false) as bool,
    memo = map['memo'] as String?,
    super(client, map);

  /// The URL to the user's profile on the remote instance, or `null` if user is local.
  /// 
  /// The URL is the usual profile link, e.g. https://example.com/@username
  final String? url;

  /// The URI to the user's profile on the remote instance, or `null` if user is local.
  /// 
  /// The URI uses the user's id instead of their username, e.g. https://example.com/users/{user_id_here}
  /// See also: [url]
  final String? uri;

  /// The URI of the account that the user moved to.
  final String? movedToUri;

  /// List of URIs to the user's other accounts.
  final List<String> alsoKnownAs;

  /// The time when this account was created.
  final DateTime createdAt;

  /// The time when this account was last updated, or `null` if never.
  final DateTime? updatedAt;

  /// The time when this account was last fetched from the remote instance, or `null` if user is local.
  final DateTime? lastFetchedAt;

  /// The URL of the user's banner.
  final String? bannerUrl;

  /// The BlurHash of the user's banner.
  final String? bannerBlurhash;

  /// Whether this user is locked.
  final bool isLocked;

  /// Whether this user is silenced.
  final bool isSilenced;

  /// Whether this user is suspended.
  final bool isSuspended;

  /// The user's description.
  final String? description;

  /// The user's location.
  final String? location;

  /// The user's birthday.
  final String? birthday;

  /// The user's language.
  final String? lang;

  /// The user's additional information fields.
  final List<UserField> fields;

  /// The followers count of this user.
  final int followersCount;

  /// The following count of this user.
  final int followingCount;

  /// The notes count of this user.
  final int notesCount;

  /// The user's pinned note IDs.
  final List<String> pinnedNoteIds;

  /// The user's pinned notes.
  final List<Note> pinnedNotes;

  /// The user's pinned page ID.
  final String? pinnedPageId;

  /// The user's pinned page.
  final Page? pinnedPage;

  /// Whether this user's reactions are public.
  final bool publicReactions;

  /// Whether this user has 2FA enabled.
  final bool twoFactorEnabled;

  /// Whether this user uses password-less login.
  final bool usePasswordLessLogin;
  
  /// Whether this user uses security keys.
  final bool securityKeys;
  
  @override
  final bool isFollowing;
  
  @override
  final bool isFollowed;
  
  @override
  final bool hasPendingFollowRequestFromYou;
  
  @override
  final bool hasPendingFollowRequestToYou;
  
  @override
  final bool isBlocking;
  
  @override
  final bool isBlocked;
  
  @override
  final bool isMuted;
  
  @override
  final bool isRenoteMuted;
  
  /// The client user’s personal memo for this user.
  final String? memo;
}