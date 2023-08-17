import '../core/client.dart';
import '../core/base.dart';
import '../entities/announcement.dart';
import '../structs/endpoint_param.dart';
import '../entities/invite_code.dart';
import '../structs/meta.dart';
import '../structs/server_info.dart';
import '../structs/stats.dart';

class MetaApi extends Base {
  MetaApi(Client client)
  : super(client);

  /// Fetches the instance meta information.
  Future<Meta> fetch() async =>
      Meta(await client.api.post('meta', withToken: false));

  /// Pings the server.
  /// 
  /// Returns the time when the server received the request.
  Future<DateTime> ping() async =>
      DateTime.fromMillisecondsSinceEpoch(
        (await client.api.post<Map<String, dynamic>>('ping', withToken: false))
        ['pong'] as int
      );

  /// Gets the online users count.
  Future<int> onlineUsersCount() async =>
      (await client.api.post<Map<String, dynamic>>('get-online-users-count', withToken: false))
      ['count'] as int;
  
  /// Gets a list of the instance's announcements.
  Future<List<Announcement>> listAnnouncements({
    int? limit,
    String? sinceId,
    String? untilId,
    bool? withUnreads
  }) async =>
      (await client.api.post<List<dynamic>>('announcements', body: {
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId,
        if (withUnreads != null) 'withUnreads': withUnreads
      }))
      .map((e) => Announcement(client, e))
      .toList();
  
  /// Gets an API endpoint's details. Returns `null` if endpoint doesn't exist.
  Future<List<EndpointParam>?> fetchEndpoint(String endpoint) async {
    final map = await client.api.post('endpoint', body: {
      'endpoint': endpoint
    }, withToken: false);
    if (map is! Map<String, dynamic>) return null;

    return (map['params'] as List<dynamic>)
        .map((e) => EndpointParam(e))
        .toList();
  }

  /// Checks if an API endpoint exists.
  Future<bool> endpointExists(String endpoint) async =>
      (await client.api.post('endpoint', body: {
        'endpoint': endpoint
      }, withToken: false)) != null;

  /// Gets a list of all API endpoints.
  Future<List<String>> listEndpoints() async =>
      (await client.api.post<List<dynamic>>('endpoints', withToken: false)).cast();
  
  /// Creates an invite code.
  /// 
  /// Available in v13.14.0 or later. Check if the `invite/create`
  /// endpoint exists before using.
  /// 
  /// See also: [createInviteLegacy]
  Future<InviteCode> createInvite() async =>
      InviteCode(client, await client.api.post('invite/create'));
  
  /// Creates an invite code (legacy).
  ///
  /// Available since v13.0.0 until v13.14.0. Check if the `invite`
  /// endpoint exists before using.
  /// 
  /// See also: [createInvite]
  Future<String> createInviteLegacy() async =>
      (await client.api.post<Map<String, dynamic>>('invite'))
      ['code'] as String;
  
  /// Gets a list of the client user's invite codes.
  /// 
  /// Available in v13.14.0 or later. Check if the `invite/list`
  /// endpoint exists before using.
  Future<List<InviteCode>> listInvite({
    int? limit,
    String? sinceId,
    String? untilId
  }) async =>
      (await client.api.post<List<dynamic>>('invite/list', body: {
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId
      }))
      .map((e) => InviteCode(client, e))
      .toList();
  
  /// Gets the remaining invites count, or `null` if the instance
  /// doesn't have an invite limit.
  ///
  /// Available in v13.14.0 or later. Check if the `invite/limit`
  /// endpoint exists before using.
  Future<int?> remainingInvitesCount() async =>
      (await client.api.post<Map<String, dynamic>>('invite/limit'))
      ['remaining'] as int?;
  
  /// Gets the server info which includes system specifications.
  /// 
  /// Some instances might have this feature disabled, which would
  /// fill the response with placeholder values.
  Future<ServerInfo> fetchServerInfo() async =>
      ServerInfo(await client.api.post('server-info'));
  
  /// Gets the instance's stats.
  Future<Stats> fetchStats() async =>
      Stats(await client.api.post('stats'));
  
  /// Fetches a RSS feed as JSON.
  Future<Map<String, dynamic>> fetchRss(String url) =>
      client.api.post('fetch-rss', body: {
        'url': url
      });
}