import '../entities/page.dart';
import '../core/client.dart';

class PageLikeDetails {
  PageLikeDetails(Client client, Map<String, dynamic> map)
  : id = map['id'] as String,
    page = Page(client, map['page']);

  /// The ID of the like.
  final String id;

  /// The page.
  final Page page;
}