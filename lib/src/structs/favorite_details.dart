import '../entities/note.dart';
import '../core/client.dart';

class FavoriteDetails {
  FavoriteDetails(Client client, Map<String, dynamic> map)
  : id = map['id'] as String,
    createdAt = DateTime.parse(map['createdAt'] as String),
    note = Note(client, map['note']),
    noteId = map['noteId'] as String;

  /// The ID of the favorite.
  final String id;

  /// The time when the note was favorited.
  final DateTime createdAt;

  /// The note.
  final Note note;

  /// The ID of the note.
  final String noteId;
}