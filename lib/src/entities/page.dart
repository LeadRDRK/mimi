import 'user_lite.dart';
import 'drive_file.dart';
import '../core/base.dart';
import '../core/client.dart';
import '../structs/page_block.dart';

class Page extends Base {
  Page(Client client, Map<String, dynamic> map)
  : id = map['id'] as String,
    createdAt = DateTime.parse(map['createdAt'] as String),
    updatedAt = DateTime.parse(map['updatedAt'] as String),
    userId = map['userId'] as String,
    user = UserLite(client, map['user'] as Map<String, dynamic>),
    content = (map['content'] as List).map((e) => PageBlock(e)).toList(),
    title = map['title'] as String,
    name = map['name'] as String,
    summary = map['summary'] as String?,
    hideTitleWhenPinned = map['hideTitleWhenPinned'] as bool,
    alignCenter = map['alignCenter'] as bool,
    font = PageFont.values.firstWhere((e) => map['font'] as String == e.value),
    eyeCatchingImageId = map['eyeCatchingImageId'] as String?,
    eyeCatchingImage = map['eyeCatchingImage'] == null ? null : DriveFile(client, map['eyeCatchingImage']),
    attachedFiles = (map['attachedFiles'] as List).map((e) => DriveFile(client, e)).toList(),
    likedCount = map['likedCount'] as int,
    isLiked = (map['isLiked'] ?? false) as bool,
    super(client);

  /// The ID of the page.
  final String id;

  /// The created date of the page.
  final DateTime createdAt;

  /// The updated date of the page.
  final DateTime updatedAt;

  /// The title of the page.
  final String title;

  /// The name of the page.
  final String name;

  /// A brief summary of the page.
  final String? summary;

  /// Whether or not to align the content to the center.
  final bool alignCenter;

  /// Whether or not to hide the title when pinned.
  final bool hideTitleWhenPinned;

  /// The type of the font used for the text on the page.
  final PageFont font;

  /// The ID of the author of the page.
  final String userId;

  /// The author of the page.
  final UserLite user;

  /// The ID of the eye-catching image for the page.
  final String? eyeCatchingImageId;

  /// The eye-catching image for the page.
  final DriveFile? eyeCatchingImage;

  /// The content of the page.
  final List<PageBlock> content;

  final List<DriveFile> attachedFiles;

  /// The number of likes this page has received.
  final int likedCount;

  /// Whether this page is liked by the client user.
  final bool isLiked;
}

enum PageFont {
  serif('serif'),
  sansSerif('sans-serif');

  const PageFont(this.value);
  final String value;
}