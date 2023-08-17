import '../entities/gallery_post.dart';
import '../core/client.dart';

class GalleryLikeDetails {
  GalleryLikeDetails(Client client, Map<String, dynamic> map)
  : id = map['id'] as String,
    post = GalleryPost(client, map['post']);

  /// The ID of the like.
  final String id;

  /// The gallery post.
  final GalleryPost post;
}