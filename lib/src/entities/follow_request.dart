import '../core/base.dart';
import '../core/client.dart';
import 'user_lite.dart';

class FollowRequest extends Base {
  FollowRequest(Client client, Map<String, dynamic> map)
  : id = map['id'] as String,
    follower = UserLite(client, map['follower']),
    followee = UserLite(client, map['followee']),
    super(client);
  
  /// The ID of this follow request.
  final String id;

  /// The follower of this follow request.
  final UserLite follower;

  /// The followee of this follow request.
  final UserLite followee;

  /// Accept the follower's follow request.
  Future<void> accept() => follower.acceptFollowRequest();

  /// Reject the follower's follow request.
  Future<void> reject() => follower.rejectFollowRequest();
}