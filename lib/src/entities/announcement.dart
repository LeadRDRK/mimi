import 'announcement_resolvable.dart';
import '../core/client.dart';

class Announcement extends AnnouncementResolvable {
  Announcement(Client client, Map<String, dynamic> map)
  : createdAt = DateTime.parse(map['createdAt'] as String),
    updatedAt = map['updatedAt'] == null ? null : DateTime.parse(map['updatedAt'] as String),
    text = map['text'] as String,
    title = map['title'] as String,
    imageUrl = map['imageUrl'] as String?,
    isRead = (map['isRead'] ?? false) as bool,
    super(client, map['id'] as String);

  /// The time when this announcement was created.
  final DateTime createdAt;

  /// The time when this announcement was updated.
  final DateTime? updatedAt;

  /// The text content of the announcement.
  final String text;

  /// The title of the announcement.
  final String title;

  /// The URL of the image for the announcement.
  final String? imageUrl;

  /// Whether the announcement has been read by the client user.
  final bool isRead;
}