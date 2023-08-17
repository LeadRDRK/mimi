import 'dart:async';
import '../core/base.dart';
import '../core/client.dart';
import 'note.dart';
import '../structs/reaction.dart';
import '../structs/note_state.dart';
import '../structs/note_translation.dart';
import '../structs/note_payload.dart';
import '../core/resolvable_id.dart';
import '../stream/note_subscription.dart';
import '../stream/types.dart';
import '../utils/multi_stream_controller_depend.dart';

/// Data that can be resolved to a Note.
class NoteResolvable extends Base implements ResolvableId {
  NoteResolvable(Client client, this.id)
  : super(client)
  {
    onPollVoted = _onPollVotedController.stream;
    onDeleted = _onDeletedController.stream;
    onReacted = _onReactedController.stream;
    onUnreacted = _onUnreactedController.stream;

    MultiStreamControllerDepend<NoteSubscription>(
      [
        _onPollVotedController, _onDeletedController,
        _onReactedController, _onUnreactedController
      ],
      _subscribe,
      _unsubscribe
    );
  }

  /// The note's ID.
  @override
  final String id;

  /// Fetches the note.
  Future<Note> fetch() async =>
      Note(client, await client.api.post('notes/show', body: {
        'noteId': id
      }));
  
  /// Gets a list of the note's children.
  /// 
  /// Contains both replies and (quote) renotes.
  Future<List<Note>> listChildren({
    int? limit,
    String? sinceId,
    String? untilId
  }) async =>
      (await client.api.post<List<dynamic>>('notes/children', body: {
        'noteId': id,
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId
      }))
      .map((e) => Note(client, e))
      .toList();
  
  /// Gets a list of notes in the conversation.
  /// 
  /// Returns a list of notes that would appear before the `reply`
  /// of this note, in reverse order.
  /// 
  /// To demonstrate, here is the order of a thread with 5
  /// notes (3 of which are in the conversation list):
  /// `conv[2], conv[1], conv[0], reply, note`
  Future<List<Note>> listConversation({
    int? limit,
    String? sinceId,
    String? untilId
  }) async =>
      (await client.api.post<List<dynamic>>('notes/conversation', body: {
        'noteId': id,
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId
      }))
      .map((e) => Note(client, e))
      .toList();
  
  /// Gets a list of the note's reactions.
  Future<List<Reaction>> listReactions({
    int? limit,
    int? offset,
    String? sinceId,
    String? untilId,
    String? type
  }) async =>
      (await client.api.post<List<dynamic>>('notes/reactions', body: {
        'noteId': id,
        if (limit != null) 'limit': limit,
        if (offset != null) 'offset': offset,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId,
        if (type != null) 'type': type
      }, withToken: false))
      .map((e) => Reaction(client, e))
      .toList();
  
  /// Gets a list of renotes of this note.
  Future<List<Note>> listRenotes({
    int? limit,
    String? sinceId,
    String? untilId
  }) async =>
      (await client.api.post<List<dynamic>>('notes/renotes', body: {
        'noteId': id,
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId
      }))
      .map((e) => Note(client, e))
      .toList();
  
  /// Gets a list of replies to this note.
  Future<List<Note>> listReplies({
    int? limit,
    String? sinceId,
    String? untilId
  }) async =>
      (await client.api.post<List<dynamic>>('notes/replies', body: {
        'noteId': id,
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId
      }))
      .map((e) => Note(client, e))
      .toList();
  
  /// Deletes the note.
  Future<void> delete() =>
      client.api.post('notes/delete', body: {
        'noteId': id
      });
  
  /// Adds the note to favorites.
  Future<void> addToFavorites() =>
      client.api.post('notes/favorites/create', body: {
        'noteId': id
      });
  
  /// Removes the note from favorites.
  Future<void> removeFromFavorites() =>
      client.api.post('notes/favorites/delete', body: {
        'noteId': id
      });
  
  /// Pins the note to the client user's profile.
  /// 
  /// Alias for `account.pin(id)`
  Future<Note> pin() => client.account.pin(id);

  /// Unpins the note from the client user's profile.
  /// 
  /// Alias for `account.unpin(id)`
  Future<Note> unpin() => client.account.unpin(id);

  /// Gets the state of this note for the client user.
  Future<NoteState> fetchState() async =>
      NoteState(await client.api.post('notes/state', body: {
        'noteId': id
      }));
  
  /// Mutes the thread of this note.
  Future<void> muteThread() =>
      client.api.post('notes/thread-muting/create', body: {
        'noteId': id
      });
  
  /// Unmutes the thread of this note.
  Future<void> unmuteThread() =>
      client.api.post('notes/thread-muting/delete', body: {
        'noteId': id
      });
  
  /// Translates this note.
  Future<NoteTranslation> translate(String targetLang) async =>
      NoteTranslation(await client.api.post('notes/translate', body: {
        'noteId': id,
        'targetLang': targetLang
      }));
  
  /// Unrenotes this note.
  Future<void> unrenote() =>
      client.api.post('notes/unrenote', body: {
        'noteId': id
      });
  
  /// Marks a promo as read.
  Future<void> readPromo() =>
      client.api.post('promo/read', body: {
        'noteId': id
      });
  
  /// React to this note.
  Future<void> react(String reaction) =>
      client.api.post('notes/reactions/create', body: {
        'noteId': id,
        'reaction': reaction
      });
  
  /// Removes the reaction to this note.
  Future<void> unreact() =>
      client.api.post('notes/reactions/delete', body: {
        'noteId': id
      });
  
  /// Creates a reply to this note.
  Future<Note> createReply(NotePayload options) async =>
      client.notes.create(NotePayload.reply(id, options));
  
  /// Creates a renote of this note.
  Future<Note> createRenote(NotePayload? options) async =>
      client.notes.create(NotePayload.renote(id, options));

  /// Emitted when a user votes for a choice on a poll.
  late final Stream<PollVotedEvent> onPollVoted;
  final _onPollVotedController = StreamController<PollVotedEvent>.broadcast();

  /// Emitted when the note is deleted.
  late final Stream<DateTime> onDeleted;
  final _onDeletedController = StreamController<DateTime>.broadcast();

  /// Emitted when a user reacts to the note.
  late final Stream<ReactedEvent> onReacted;
  final _onReactedController = StreamController<ReactedEvent>.broadcast();

  /// Emitted when a user removes a reaction.
  late final Stream<UnreactedEvent> onUnreacted;
  final _onUnreactedController = StreamController<UnreactedEvent>.broadcast();

  NoteSubscription _subscribe() {
    final subscription = client.noteSubscriptionManager.subscribe(id);
    subscription.stream.listen((message) {
      final body = message.body;
      final content = body.body;

      switch (body.type) {
        case 'pollVoted':
          _onPollVotedController.add(PollVotedEvent(content));
          break;

        case 'deleted':
          content as Map<String, dynamic>;
          _onDeletedController.add(DateTime.parse(content['deletedAt']));
          break;
        
        case 'reacted':
          _onReactedController.add(ReactedEvent(content));
          break;
        
        case 'unreacted':
          _onUnreactedController.add(UnreactedEvent(content));
          break;
      }
    });
    return subscription;
  }

  void _unsubscribe(NoteSubscription subscription) {
    subscription.unsubscribe();
  }
}