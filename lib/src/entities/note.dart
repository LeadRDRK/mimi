import 'note_resolvable.dart';
import 'user_lite.dart';
import 'drive_file.dart';
import 'channel_lite.dart';
import 'poll.dart';
import '../core/client.dart';
import '../structs/reaction_acceptance.dart';

class Note extends NoteResolvable {
  Note(Client client, Map<String, dynamic> map)
  : createdAt = DateTime.parse(map['createdAt'] as String),
    deletedAt = map['deletedAt'] == null ? null : DateTime.parse(map['deletedAt'] as String),
    text = map['text'] as String?,
    cw = map['cw'] as String?,
    userId = map['userId'] as String,
    user = UserLite(client, map['user']),
    replyId = map['replyId'] as String?,
    renoteId = map['renoteId'] as String?,
    reply = map['reply'] == null ? null : Note(client, map['reply']),
    renote = map['renote'] == null ? null : Note(client, map['renote']),
    isHidden = (map['isHidden'] ?? false) as bool,
    visibility = map['visibility'] as String,
    mentions = map['mentions'] == null ? [] : List<String>.from(map['mentions']),
    visibleUserIds = map['visibleUserIds'] == null ? [] : List<String>.from(map['visibleUserIds']),
    fileIds = map['fileIds'] == null ? [] : List<String>.from(map['fileIds']),
    files = map['files'] == null ?
        [] :
        (map['files'] as List<dynamic>).map((e) => DriveFile(client, e)).toList(),
    tags = map['tags'] == null ? [] : List<String>.from(map['tags']),
    channelId = map['channelId'] as String?,
    channel = map['channel'] == null ? null : ChannelLite(client, map['channel']),
    localOnly = (map['localOnly'] ?? false) as bool,
    reactionAcceptance = map['reactionAcceptance'] != null ?
        ReactionAcceptance.values.firstWhere((e) => e.name == map['reactionAcceptance']) :
        ReactionAcceptance.all,
    reactions = Map<String, int>.from(map['reactions']),
    renoteCount = map['renoteCount'] as int,
    repliesCount = map['repliesCount'] as int,
    uri = map['uri'] as String?,
    url = map['url'] as String?,
    myReaction = map['myReaction'] as String?,
    super(client, map['id'] as String)
  {
    poll = map['poll'] == null ? null : Poll(client, this, map['poll']);
  }

  /// The time when this note was created.
  final DateTime createdAt;

  /// The time when this note was deleted, or `null` if not deleted.
  final DateTime? deletedAt;

  /// The text of the note.
  final String? text;

  /// The content warning of the note.
  final String? cw;

  /// The ID of the user who created this note.
  final String userId;

  /// The user who created this note.
  final UserLite user;

  /// The ID of the replied note, or `null` if not a reply.
  final String? replyId;

  /// The ID of the renoted note, or `null` if not a renote.
  final String? renoteId;

  /// The replied note, or `null` if not a reply.
  final Note? reply;

  /// The renoted note, or `null` if not a renote.
  final Note? renote;

  /// Whether this note is hidden.
  final bool isHidden;

  /// The visibility of the note.
  final String visibility;

  /// The IDs of the users mentioned in this note.
  final List<String> mentions;

  /// The IDs of the users who can see this note.
  final List<String> visibleUserIds;

  /// The IDs of the files attached to this note.
  final List<String> fileIds;

  /// The files attached to this note.
  final List<DriveFile> files;

  /// The tags in this note.
  final List<String> tags;

  /// The poll attached to this note, or `null` if no poll attached.
  late final Poll? poll;

  /// The ID of the channel that this note belongs to, or `null` if not in a channel.
  final String? channelId;

  /// The channel that this note belongs to, or `null` if not in a channel.
  final ChannelLite? channel;

  /// Whether the note is local only.
  final bool localOnly;

  /// The reaction acceptance setting of the note.
  final ReactionAcceptance reactionAcceptance;

  /// The reactions of the note.
  /// 
  /// Contains reaction counts mapped to the emoji names.
  final Map<String, int> reactions;

  /// The renote count of the note.
  final int renoteCount;

  /// The replies count of the note.
  final int repliesCount;

  /// The URI of the note.
  final String? uri;

  /// The URL of the note.
  final String? url;

  /// The client user's reaction to the note, or `null` if no reaction.
  final String? myReaction;
}