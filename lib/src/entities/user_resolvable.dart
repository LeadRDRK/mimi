import '../core/base.dart';
import '../structs/frequently_replied_user_info.dart';
import '../structs/follow_details.dart';
import '../structs/achievement.dart';
import '../structs/reaction.dart';
import '../structs/user_relation.dart';
import '../core/client.dart';
import '../core/resolvable_id.dart';

import 'user.dart';
import 'gallery_post.dart';
import 'clip.dart';
import 'note.dart';
import 'page.dart';
import 'user_lite.dart';

/*
 * TODO:
 * - send message
 * - add to list
 * - add to antenna
 */

/// Data that can be resolved to a User.
class UserResolvable extends Base implements ResolvableId {
  UserResolvable(Client client, this.id)
  : super(client);

  /// The user's ID.
  @override
  final String id;

  /// Fetches this user.
  Future<User> fetch() => client.users.fetch(id);

  /// Gets the user's achievements.
  Future<List<Achievement>> fetchAchievements() async =>
      (await client.api.post<List<dynamic>>('users/achievements', body: {
        'userId': id
      }))
      .map((e) => Achievement(e))
      .toList();
  
  /// Gets the user's clips.
  Future<List<Clip>> listClips({
    int? limit,
    String? sinceId,
    String? untilId
  }) async =>
      (await client.api.post<List<dynamic>>('users/clips', body: {
        'userId': id,
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId
      }))
      .map((e) => Clip(client, e))
      .toList();
  
  /// Internal.
  Future<List<FollowDetails>> _followListApi(
    String path,
    int? limit,
    String? sinceId,
    String? untilId
  ) async =>
      (await client.api.post<List<dynamic>>(path, body: {
        'userId': id,
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId
      }))
      .map((e) => FollowDetails(client, e))
      .toList();
  
  /// Gets the user's followers.
  Future<List<FollowDetails>> listFollowers({
    int? limit,
    String? sinceId,
    String? untilId
  }) =>
      _followListApi('users/followers', limit, sinceId, untilId);
  
  /// Gets a list of users that the user is following.
  Future<List<FollowDetails>> listFollowing({
    int? limit,
    String? sinceId,
    String? untilId
  }) =>
      _followListApi('users/following', limit, sinceId, untilId);
  
  /// Gets the user's gallery posts.
  Future<List<GalleryPost>> listGalleryPosts({
    int? limit,
    String? sinceId,
    String? untilId
  }) async =>
      (await client.api.post<List<dynamic>>('users/gallery/posts', body: {
        'userId': id,
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId
      }))
      .map((e) => GalleryPost(client, e))
      .toList();
  
  /// Gets a list of users that frequently reply to this user.
  Future<List<FrequentlyRepliedUserInfo>> listFrequentlyRepliedUsers({
    int? limit
  }) async =>
      (await client.api.post<List<dynamic>>('users/get-frequently-replied-users', body: {
        'userId': id,
        if (limit != null) 'limit': limit
      }))
      .map((e) => FrequentlyRepliedUserInfo(client, e))
      .toList();
  
  /// Gets this user's notes.
  Future<List<Note>> listNotes({
    bool? includeReplies,
    int? limit,
    String? sinceId,
    String? untilId,
    DateTime? sinceDate,
    DateTime? untilDate,
    bool? includeMyRenotes,
    bool? withFiles,
    List<String>? fileType,
    bool? excludeNsfw
  }) async =>
      (await client.api.post<List<dynamic>>('users/notes', body: {
        'userId': id,
        if (includeReplies != null) 'includeReplies': includeReplies,
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId,
        if (sinceDate != null) 'sinceDate': sinceDate.millisecondsSinceEpoch,
        if (untilDate != null) 'untilDate': untilDate.millisecondsSinceEpoch,
        if (includeMyRenotes != null) 'includeMyRenotes': includeMyRenotes,
        if (withFiles != null) 'withFiles': withFiles,
        if (fileType != null) 'fileType': fileType,
        if (excludeNsfw != null) 'excludeNsfw': excludeNsfw
      }))
      .map((e) => Note(client, e))
      .toList();
  
  /// Gets the user's pages.
  Future<List<Page>> listPages({
    int? limit,
    String? sinceId,
    String? untilId
  }) async =>
      (await client.api.post<List<dynamic>>('users/pages', body: {
        'userId': id,
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId
      }))
      .map((e) => Page(client, e))
      .toList();
  
  /// Gets the user's reactions,
  Future<List<Reaction>> listReactions({
    int? limit,
    String? sinceId,
    String? untilId,
    DateTime? sinceDate,
    DateTime? untilDate
  }) async =>
      (await client.api.post<List<dynamic>>('users/reactions', body: {
        'userId': id,
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId,
        if (sinceDate != null) 'sinceDate': sinceDate.millisecondsSinceEpoch,
        if (untilDate != null) 'untilDate': untilDate.millisecondsSinceEpoch,
      }))
      .map((e) => Reaction(client, e))
      .toList();

  /// File a report.
  Future<void> reportAbuse(String comment) =>
      client.api.post('users/report-abuse', body: {
        'comment': comment
      });
  
  /// Gets the relation between the client user and this user.
  Future<UserRelation> fetchRelation() async =>
      UserRelation(client, await client.api.post('users/relation', body: {
        'userId': id
      }));
  
  /// Follows this user.
  Future<UserLite> follow() async =>
      UserLite(client, await client.api.post('following/create', body: {
        'userId': id
      }));

  /// Unfollows this user.
  Future<UserLite> unfollow() async =>
      UserLite(client, await client.api.post('following/delete', body: {
        'userId': id
      }));
  
  /// Invalidates the follow for this user.
  Future<UserLite> invalidateFollow() async =>
      UserLite(client, await client.api.post('following/invalidate', body: {
        'userId': id
      }));
  
  /// Accepts this user's follow request.
  Future<void> acceptFollowRequest() =>
      client.api.post('following/requests/accept', body: {
        'userId': id
      });
  
  /// Rejects this user's follow request.
  Future<void> rejectFollowRequest() =>
      client.api.post('following/requests/reject', body: {
        'userId': id
      });
  
  /// Cancels an outgoing follow request to this user.
  Future<UserLite> cancelFollowRequest() async =>
      UserLite(client, await client.api.post('following/requests/cancel', body: {
        'userId': id
      }));
  
  /// Blocks this user.
  Future<User> block() async =>
      User(client, await client.api.post('blocking/create', body: {
        'userId': id
      }));
  
  /// Unblocks this user.
  Future<User> unblock() async =>
      User(client, await client.api.post('blocking/delete', body: {
        'userId': id
      }));
  
  /// Mutes this user.
  Future<void> mute([DateTime? expiresAt]) =>
      client.api.post('mute/create', body: {
        'userId': id,
        if (expiresAt != null) 'expiresAt': expiresAt.millisecondsSinceEpoch
      });
  
  /// Unmutes this user.
  Future<void> unmute() =>
      client.api.post('mute/delete', body: {
        'userId': id
      });
  
  /// Mutes this user's renotes.
  Future<void> muteRenotes() =>
      client.api.post('renote-mute/create', body: {
        'userId': id
      });

  /// Unmutes this user's renotes.
  Future<void> unmuteRenotes() =>
      client.api.post('renote-mute/delete', body: {
        'userId': id
      });
  
  /// Updates the client user's personal memo for this user.
  /// 
  /// If `null` or empty, delete the memo.
  Future<void> updateMemo(String? memo) =>
      client.api.post('users/update-memo', body: {
        'userId': id,
        'memo': memo
      });
}