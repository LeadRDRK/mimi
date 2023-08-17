import '../core/client.dart';
import '../core/base.dart';
import '../entities/note.dart';
import '../structs/note_payload.dart';

class NotesApi extends Base {
  NotesApi(Client client)
  : super(client);

  /// Gets a list of notes. The length is determined by [limit].
  /// 
  /// [limit] must be a number between 1 and 100 (inclusive). Default: `10`
  Future<List<Note>> list({
    int? limit,
    String? sinceId,
    String? untilId,
    bool? local,
    bool? reply,
    bool? renote,
    bool? withFiles,
    bool? poll
  }) async =>
      (await client.api.post<List<dynamic>>('notes', body: {
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId,
        if (local != null) 'local': local,
        if (reply != null) 'reply': reply,
        if (renote != null) 'renote': renote,
        if (withFiles != null) 'withFiles': withFiles,
        if (poll != null) 'poll': poll
      }))
      .map((e) => Note(client, e))
      .toList();
  
  /// Gets a list of featured notes.
  Future<List<Note>> listFeatured({
    int? limit,
    int? offset,
    String? channelId
  }) async =>
      (await client.api.post<List<dynamic>>('notes/featured', body: {
        if (limit != null) 'limit': limit,
        if (offset != null) 'offset': offset,
        if (channelId != null) 'channelId': channelId
      }))
      .map((e) => Note(client, e))
      .toList();

  /// Gets a list of notes on the timeline.
  Future<List<Note>> listTimeline({
    int? limit,
    String? sinceId,
    String? untilId,
    DateTime? sinceDate,
    DateTime? untilDate,
    bool? withFiles,
    bool? withReplies,
    bool? includeMyRenotes,
    bool? includeRenotedMyNotes,
    bool? includeLocalRenotes
  }) async =>
      (await client.api.post<List<dynamic>>('notes/timeline', body: {
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId,
        if (sinceDate != null) 'sinceDate': sinceDate.millisecondsSinceEpoch,
        if (untilDate != null) 'untilDate': untilDate.millisecondsSinceEpoch,
        if (withFiles != null) 'withFiles': withFiles,
        if (withReplies != null) 'withReplies': withReplies,
        if (includeMyRenotes != null) 'includeMyRenotes': includeMyRenotes,
        if (includeRenotedMyNotes != null) 'includeRenotedMyNotes': includeRenotedMyNotes,
        if (includeLocalRenotes != null) 'includeLocalRenotes': includeLocalRenotes
      }))
      .map((e) => Note(client, e))
      .toList();
  
  /// Gets a list of notes on the global timeline.
  Future<List<Note>> listGlobalTimeline({
    int? limit,
    String? sinceId,
    String? untilId,
    DateTime? sinceDate,
    DateTime? untilDate,
    bool? withFiles,
    bool? withReplies
  }) async =>
      (await client.api.post<List<dynamic>>('notes/global-timeline', body: {
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId,
        if (sinceDate != null) 'sinceDate': sinceDate.millisecondsSinceEpoch,
        if (untilDate != null) 'untilDate': untilDate.millisecondsSinceEpoch,
        if (withFiles != null) 'withFiles': withFiles,
        if (withReplies != null) 'withReplies': withReplies
      }))
      .map((e) => Note(client, e))
      .toList();
  
  /// Gets a list of notes on the hybrid timeline.
  Future<List<Note>> listHybridTimeline({
    int? limit,
    String? sinceId,
    String? untilId,
    DateTime? sinceDate,
    DateTime? untilDate,
    bool? withFiles,
    bool? withReplies,
    bool? includeMyRenotes,
    bool? includeRenotedMyNotes,
    bool? includeLocalRenotes
  }) async =>
      (await client.api.post<List<dynamic>>('notes/hybrid-timeline', body: {
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId,
        if (sinceDate != null) 'sinceDate': sinceDate.millisecondsSinceEpoch,
        if (untilDate != null) 'untilDate': untilDate.millisecondsSinceEpoch,
        if (withFiles != null) 'withFiles': withFiles,
        if (withReplies != null) 'withReplies': withReplies,
        if (includeMyRenotes != null) 'includeMyRenotes': includeMyRenotes,
        if (includeRenotedMyNotes != null) 'includeRenotedMyNotes': includeRenotedMyNotes,
        if (includeLocalRenotes != null) 'includeLocalRenotes': includeLocalRenotes
      }))
      .map((e) => Note(client, e))
      .toList();
  
  /// Gets a list of notes on the local timeline.
  Future<List<Note>> listLocalTimeline({
    int? limit,
    String? sinceId,
    String? untilId,
    DateTime? sinceDate,
    DateTime? untilDate,
    bool? withFiles,
    bool? withReplies,
    List<String>? fileType,
    bool? excludeNsfw
  }) async =>
      (await client.api.post<List<dynamic>>('notes/local-timeline', body: {
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId,
        if (sinceDate != null) 'sinceDate': sinceDate.millisecondsSinceEpoch,
        if (untilDate != null) 'untilDate': untilDate.millisecondsSinceEpoch,
        if (withFiles != null) 'withFiles': withFiles,
        if (withReplies != null) 'withReplies': withReplies,
        if (fileType != null) 'fileType': fileType,
        if (excludeNsfw != null) 'excludeNsfw': excludeNsfw
      }))
      .map((e) => Note(client, e))
      .toList();
  
  /// Gets a list of notes that mention the client user.
  Future<List<Note>> listMentions({
    int? limit,
    String? sinceId,
    String? untilId,
    bool? following,
    String? visibility
  }) async =>
      (await client.api.post<List<dynamic>>('notes/mentions', body: {
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId,
        if (following != null) 'following': following,
        if (visibility != null) 'visibility': visibility
      }))
      .map((e) => Note(client, e))
      .toList();
  
  /// Gets a list of recommended notes with polls. 
  Future<List<Note>> listPollRecommendation({
    int? limit,
    int? offset
  }) async =>
      (await client.api.post<List<dynamic>>('notes/polls/recommendation', body: {
        if (limit != null) 'limit': limit,
        if (offset != null) 'offset': offset,
      }))
      .map((e) => Note(client, e))
      .toList();

  /// Creates a note.
  Future<Note> create(NotePayload payload) async =>
      Note(client, await client.api.post('notes/create', body: payload));
  
  /// Searches for notes.
  Future<List<Note>> search(String query, {
    int? limit,
    int? offset,
    String? sinceId,
    String? untilId,
    String? host,
    String? userId,
    String? channelId
  }) async =>
      (await client.api.post<List<dynamic>>('notes', body: {
        'query': query,
        if (limit != null) 'limit': limit,
        if (offset != null) 'offset': offset,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId,
        if (host != null) 'host': host,
        if (userId != null) 'userId': userId,
        if (channelId != null) 'channelId': channelId
      }))
      .map((e) => Note(client, e))
      .toList();
  
  /// Searches for notes by tag.
  Future<List<Note>> searchByTag(String tag, {
    int? limit,
    String? sinceId,
    String? untilId,
    bool? reply,
    bool? renote,
    bool? withFiles,
    bool? poll
  }) async =>
      (await client.api.post<List<dynamic>>('notes', body: {
        'tag': tag,
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId,
        if (reply != null) 'reply': reply,
        if (renote != null) 'renote': renote,
        if (withFiles != null) 'withFiles': withFiles,
        if (poll != null) 'poll': poll
      }))
      .map((e) => Note(client, e))
      .toList();
  
  /// Searches for notes by tag query.
  /// 
  /// The query tags array is converted to SQL statements
  /// in the `WHERE` clause by the server.
  /// 
  /// The outer arrays are chained with OR,
  /// and the inner arrays are chained with AND.
  /// 
  /// Example: `[['foo', 'bar'], ['baz']]`
  ///  -> `(foo AND bar) OR baz`
  Future<List<Note>> searchByTagQuery(List<List<String>> query, {
    int? limit,
    String? sinceId,
    String? untilId,
    bool? reply,
    bool? renote,
    bool? withFiles,
    bool? poll
  }) async =>
      (await client.api.post<List<dynamic>>('notes', body: {
        'query': query,
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId,
        if (reply != null) 'reply': reply,
        if (renote != null) 'renote': renote,
        if (withFiles != null) 'withFiles': withFiles,
        if (poll != null) 'poll': poll
      }))
      .map((e) => Note(client, e))
      .toList();
}