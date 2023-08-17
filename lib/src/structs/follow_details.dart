import '../core/client.dart';
import '../entities/user.dart';

/// The details of a follow.
class FollowDetails {
  FollowDetails(Client client, Map<String, dynamic> map)
  : id = map['id'] as String,
    createdAt = DateTime.parse(map['createdAt'] as String),
    followeeId = map['followeeId'] as String,
    followee = User(client, map['followee']),
    followerId = map['followerId'] as String,
    follower = User(client, map['follower']);

  /// The ID of the follow.
  final String id;

  /// When this follow was created.
  final DateTime createdAt;

  /// The ID of the followee.
  final String followeeId;

  /// The followee of this follow, or `null` if the user is not visible.
  final User? followee;

  /// The ID of the follower.
  final String followerId;

  /// The follower of this follow, or `null` if the user is not visible.
  final User? follower;
}