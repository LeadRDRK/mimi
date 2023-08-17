import '../core/client.dart';
import '../core/base.dart';

import '../structs/mute_details.dart';
import '../structs/block_details.dart';
import '../structs/favorite_details.dart';
import '../structs/page_like_details.dart';
import '../structs/flash_like_details.dart';
import '../structs/account_update_payload.dart';

import '../entities/client_user.dart';
import '../entities/page.dart';
import '../entities/note.dart';
import '../entities/flash.dart';
import '../entities/sw_subscription_result.dart';

class AccountApi extends Base {
  AccountApi(Client client)
  : super(client);

  /// The client user.
  ClientUser get user => _user;

  /// Internal.
  late ClientUser _user;

  /// Fetches the client user.
  /// 
  /// This will also update the [user] property.
  Future<ClientUser> fetchUser() async =>
      _user = ClientUser(client, await client.api.post('i'));

  /// Internal.
  Future<List<MuteDetails>> _muteListApi(
    String path,
    int? limit,
    String? sinceId,
    String? untilId
  ) async =>
      (await client.api.post<List<dynamic>>(path, body: {
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId
      }))
      .map((e) => MuteDetails(client, e))
      .toList();

  /// Lists the client user's mutes.
  Future<List<MuteDetails>> listMutes({
    int? limit,
    String? sinceId,
    String? untilId
  }) =>
      _muteListApi('mute/list', limit, sinceId, untilId);

  /// Lists the client user's renote mutes.
  Future<List<MuteDetails>> listRenoteMutes({
    int? limit,
    String? sinceId,
    String? untilId
  }) =>
      _muteListApi('renote-mute/list', limit, sinceId, untilId);
  
  /// Gets the number of notes muted by word.
  Future<int> wordMutedNotesCount() async =>
      (await client.api.post<Map<String, dynamic>>('i/get-word-muted-notes-count'))
      ['count'] as int;

  /// Lists the client user's blocks.
  Future<List<BlockDetails>> listBlocks({
    int? limit,
    String? sinceId,
    String? untilId
  }) async =>
      (await client.api.post<List<dynamic>>('blocking/list', body: {
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId
      }))
      .map((e) => BlockDetails(client, e))
      .toList();
  
  /// Lists the client user's favorites.
  Future<List<FavoriteDetails>> listFavorites({
    int? limit,
    String? sinceId,
    String? untilId
  }) async =>
      (await client.api.post<List<dynamic>>('i/favorites', body: {
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId
      }))
      .map((e) => FavoriteDetails(client, e))
      .toList();

  /// Lists the client user's page likes.
  Future<List<PageLikeDetails>> listPageLikes({
    int? limit,
    String? sinceId,
    String? untilId
  }) async =>
      (await client.api.post<List<dynamic>>('i/page-likes', body: {
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId
      }))
      .map((e) => PageLikeDetails(client, e))
      .toList();
  
  /// Lists the client user's pages.
  Future<List<Page>> listPages({
    int? limit,
    String? sinceId,
    String? untilId
  }) async =>
      (await client.api.post<List<dynamic>>('i/pages', body: {
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId
      }))
      .map((e) => Page(client, e))
      .toList();

  /// Pins a note.
  Future<Note> pin(String noteId) async =>
      Note(client, await client.api.post('i/pin', body: {
        'noteId': noteId
      }));
  
  /// Unpins a note.
  Future<Note> unpin(String noteId) async =>
      Note(client, await client.api.post('i/unpin', body: {
        'noteId': noteId
      }));
  
  /// Marks all unread notes as read.
  Future<void> readAllUnreadNotes() =>
      client.api.post('i/read-all-unread-notes');

  /// Marks an announcement as read.
  Future<void> readAnnouncement(String announcementId) =>
      client.api.post('i/read-announcement', body: {
        'announcementId': announcementId
      });
  
  /// Lists the client user's flashes (aka plays).
  Future<List<Flash>> listFlashes({
    int? limit,
    String? sinceId,
    String? untilId
  }) async =>
      (await client.api.post<List<dynamic>>('flash/my', body: {
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId
      }))
      .map((e) => Flash(client, e))
      .toList();
  
  /// Lists the client user's flash likes.
  Future<List<FlashLikeDetails>> listFlashLikes({
    int? limit,
    String? sinceId,
    String? untilId
  }) async =>
      (await client.api.post<List<dynamic>>('flash/my-likes', body: {
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId
      }))
      .map((e) => FlashLikeDetails(client, e))
      .toList();
  
  /// Updates the user's account details.
  /// 
  /// This will also update the [user] property.
  Future<ClientUser> update(AccountUpdatePayload payload) async =>
      _user = ClientUser(client, await client.api.post('i/update', body: payload));
  
  /// Register to receive push notifications.
  Future<SwSubscriptionResult> swRegister(
    String endpoint,
    String auth,
    String publickey,
    {bool? sendReadMessage}
  ) async =>
      SwSubscriptionResult(client, await client.api.post('sw/register', body: {
        'endpoint': endpoint,
        'auth': auth,
        'publickey': publickey,
        if (sendReadMessage != null) 'sendReadMessage': sendReadMessage
      }));
}

/// Used internally by the Client.
class AccountApiEx extends AccountApi {
  AccountApiEx(Client client)
  : super(client);

  set user(ClientUser user) => _user = user;
}