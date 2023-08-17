import 'channel_lite.dart';
import 'note.dart';
import '../core/client.dart';

class Channel extends ChannelLite {
  Channel(Client client, Map<String, dynamic> map)
  : createdAt = DateTime.parse(map['createdAt'] as String),
    lastNotedAt = map['lastNotedAt'] == null ? null : DateTime.parse(map['lastNotedAt'] as String),
    description = map['description'] as String?,
    bannerUrl = map['bannerUrl'] as String?,
    isArchived = map['isArchived'] as bool,
    notesCount = map['notesCount'] as int,
    usersCount = map['usersCount'] as int,
    isFollowing = map['isFollowing'] as bool,
    isFavorited = map['isFavorited'] as bool,
    userId = map['userId'] as String?,
    pinnedNoteIds = List<String>.from(map['pinnedNoteIds']),
    pinnedNotes = (map['pinnedNotes'] as List<dynamic>).map((e) => Note(client, e)).toList(),
    hasUnreadNote = map['hasUnreadNote'] as bool,
    super(client, map);

  /// The time when this channel was created.
  final DateTime createdAt;

  /// The time when the last note in this channel was posted.
  final DateTime? lastNotedAt;

  /// The description of the channel.
  final String? description;

  /// The URL of the banner for this channel.
  final String? bannerUrl;

  /// Whether the channel is archived.
  final bool isArchived;

  /// The notes count for this channel.
  final int notesCount;

  /// The users count for this channel.
  final int usersCount;

  /// Whether the client user is following this channel.
  final bool isFollowing;

  /// Whether this channel is favorited by the client user.
  final bool isFavorited;

  /// The ID of the owner of the channel.
  final String? userId;

  /// The channel's pinned note IDs.
  final List<String> pinnedNoteIds;

  /// The channel's pinned notes.
  final List<Note> pinnedNotes;

  /// Whether the client user has an unread note in this channel.
  final bool hasUnreadNote;
}