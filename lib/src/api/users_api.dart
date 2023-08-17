import '../core/client.dart';
import '../core/base.dart';
import '../entities/user.dart';
import '../structs/users_enums.dart';
import '../structs/email_available_result.dart';
import '../structs/retention_record.dart';
import '../structs/user_relation.dart';
import '../entities/user_resolvable.dart';
import '../entities/user_lite.dart';

class UsersApi extends Base {
  UsersApi(Client client)
  : super(client);

  /// Gets a list of users. The length is determined by [limit].
  /// 
  /// [limit] must be a number between 1 and 100 (inclusive). Default: `10`
  Future<List<User>> list({
    int? limit,
    int? offset,
    UsersListSort? sort,
    UsersListState? state,
    UsersListOrigin? origin,
    String? hostname,
  }) async =>
      (await client.api.post<List<dynamic>>('users', body: {
        if (limit != null) 'limit': limit,
        if (offset != null) 'offset': offset,
        if (sort != null) 'sort': sort,
        if (state != null) 'state': state,
        if (origin != null) 'origin': origin,
        if (hostname != null) 'hostname': hostname
      }))
      .map((e) => User(client, e))
      .toList();

  /// Fetch a user by their ID.
  Future<User> fetch(String userId) async =>
      User(client, await client.api.post('users/show', body: {
        'userId': userId
      }));

  /// Fetch a user by their username.
  Future<User> fetchByUsername(String username, {String? host}) async =>
      User(client, await client.api.post('users/show', body: {
        'username': username,
        if (host != null) 'host': host
      }));

  /// Fetch users by their IDs.
  Future<List<User>> fetchMany(List<String> userIds) async =>
      (await client.api.post('users/show', body: {
        'userIds': userIds
      }) as List<dynamic>)
      .map((e) => User(client, e))
      .toList();
  
  /// Gets pinned users.
  Future<List<User>> listPinnedUsers() async =>
      (await client.api.post('pinned-users') as List<dynamic>)
      .map((e) => User(client, e))
      .toList();
  
  /// Checks if a username is available.
  Future<bool> isUsernameAvailable(String username) async =>
      (await client.api.post<Map<String, dynamic>>('username/available', body: {
        'username': username
      }, withToken: false))
      ['available'] as bool;
  
  /// Checks if an email address is available.
  Future<EmailAvailableResult> isEmailAvailable(String emailAddress) async =>
      EmailAvailableResult(await client.api.post('email-address/available', body: {
        'emailAddress': emailAddress
      }, withToken: false));
  
  /// Gets a list of users that the client user might be interested to follow.
  Future<List<User>> listRecommendation({
    int? limit,
    int? offset
  }) async =>
      (await client.api.post('users/recommendation', body: {
        if (limit != null) 'limit': limit,
        if (offset != null) 'offset': offset
      }) as List<dynamic>)
      .map((e) => User(client, e))
      .toList();
  
  /// Gets user retention data.
  Future<List<RetentionRecord>> fetchRetention() async =>
      (await client.api.post('retention', withToken: false) as List<dynamic>)
      .map((e) => RetentionRecord(e))
      .toList();
  
  /// Gets the relations between the client user and a list of users.
  /// 
  /// See also: `UserResolvable.relation`
  Future<List<UserRelation>> fetchRelations(List<UserResolvable> users) async =>
      (await client.api.post('users/relation', body: {
        'userId': users.map((e) => e.id).toList()
      }) as List<dynamic>)
      .map((e) => UserRelation(client, e))
      .toList();
  
  Future<List<T>> _searchApi<T>(
    String query,
    T Function(dynamic) mapFn,
    int? limit,
    int? offset,
    UsersListOrigin? origin,
    bool? detail
  ) async =>
      (await client.api.post('users/search', body: {
        'query': query,
        if (limit != null) 'limit': limit,
        if (offset != null) 'offset': offset,
        if (origin != null) 'origin': origin,
        if (detail != null) 'detail': detail
      }) as List<dynamic>)
      .map(mapFn)
      .toList();

  /// Search for users.
  Future<List<UserLite>> search(String query, {
    int? limit,
    int? offset,
    UsersListOrigin? origin
  }) =>
      _searchApi(query, (e) => UserLite(client, e), limit, offset, origin, false);
  
  /// Search for users (detailed).
  Future<List<User>> searchDetailed(String query, {
    int? limit,
    int? offset,
    UsersListOrigin? origin
  }) =>
      _searchApi(query, (e) => User(client, e), limit, offset, origin, true);
  
  Future<List<T>> _searchByUsernameAndHostApi<T>(
    T Function(dynamic) mapFn,
    int? limit,
    bool? detail,
    {
      String? username,
      String? host
    }
  ) async =>
      (await client.api.post('users/search-by-username-and-host', body: {
        if (limit != null) 'limit': limit,
        if (detail != null) 'detail': detail,
        if (username != null) 'username': username,
        if (host != null) 'host': host
      }) as List<dynamic>)
      .map(mapFn)
      .toList();
  
  /// Search for users by username.
  Future<List<UserLite>> searchByUsername(String username, {int? limit}) =>
      _searchByUsernameAndHostApi((e) => UserLite(client, e), limit, false, username: username);

  /// Search for users by username (detailed).
  Future<List<User>> searchByUsernameDetailed(String username, {int? limit}) =>
      _searchByUsernameAndHostApi((e) => User(client, e), limit, true, username: username);
  
  /// Search for users by host.
  Future<List<UserLite>> searchByHost(String host, {int? limit}) =>
      _searchByUsernameAndHostApi((e) => UserLite(client, e), limit, false, host: host);
  
  /// Search for users by host (detailed).
  Future<List<User>> searchByHostDetailed(String host, {int? limit}) =>
      _searchByUsernameAndHostApi((e) => User(client, e), limit, true, host: host);
  
  /// Search for users by username and host.
  Future<List<UserLite>> searchByUsernameAndHost(String username, String host, {int? limit}) =>
      _searchByUsernameAndHostApi((e) => UserLite(client, e), limit, false, username: username, host: host);

  /// Search for users by username and host (detailed).
  Future<List<User>> searchByUsernameAndHostDetailed(String username, String host, {int? limit}) =>
      _searchByUsernameAndHostApi((e) => User(client, e), limit, true, username: username, host: host);
}