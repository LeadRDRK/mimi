import '../entities/user_resolvable.dart';
import '../core/client.dart';

/// Relations 
class UserRelation extends UserResolvable {
  UserRelation(Client client, Map<String, dynamic> map)
  : isFollowing = map['isFollowing'] as bool,
    isFollowed = map['isFollowed'] as bool,
    hasPendingFollowRequestFromYou = map['hasPendingFollowRequestFromYou'] as bool,
    hasPendingFollowRequestToYou = map['hasPendingFollowRequestToYou'] as bool,
    isBlocking = map['isBlocking'] as bool,
    isBlocked = map['isBlocked'] as bool,
    isMuted = map['isMuted'] as bool,
    isRenoteMuted = map['isRenoteMuted'] as bool,
    super(client, map['id'] as String);

  /// Whether the client user is following this user.
  final bool isFollowing;
  
  /// Whether the client user is being followed by this user.
  final bool isFollowed;
  
  /// Whether this user has a pending follow request from the client user.
  final bool hasPendingFollowRequestFromYou;
  
  /// Whether this user has a pending follow request to the client user.
  final bool hasPendingFollowRequestToYou;
  
  /// Whether this user is blocking the client user.
  final bool isBlocking;
  
  /// Whether this user is blocked by the client user.
  final bool isBlocked;
  
  /// Whether this user is muted by the client user.
  final bool isMuted;
  
  /// Whether this user’s renotes are muted by the client user.
  final bool isRenoteMuted;
}