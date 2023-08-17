class NoteState {
  NoteState(Map<String, dynamic> map)
  : isFavorited = map['isFavorited'] as bool,
    isMutedThread = map['isMutedThread'] as bool;

  /// Whether the note is favorited.
  final bool isFavorited;

  /// Whether the thread of this note is muted.
  final bool isMutedThread;
}