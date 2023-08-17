abstract class PageBlock {
  /// The ID of the block.
  String get id;

  /// The type of the block.
  PageBlockType get type;

  factory PageBlock(Map<String, dynamic> map) {
    final type = map['type'] as String;
    switch (type) {
      case 'text':    return TextBlock(map);
      case 'section': return SectionBlock(map);
      case 'image':   return ImageBlock(map);
      case 'note':    return NoteBlock(map);
      default:        return FallbackBlock(map);
    }
  }
}

enum PageBlockType {
  text,
  section,
  image,
  note,
  fallback
}

class TextBlock implements PageBlock {
  TextBlock(Map<String, dynamic> map)
  : id = map['id'] as String,
    text = map['text'] as String;

  @override
  final String id;

  @override
  PageBlockType get type => PageBlockType.text;

  /// The text of the block.
  final String text;
}

class SectionBlock implements PageBlock {
  SectionBlock(Map<String, dynamic> map)
  : id = map['id'] as String,
    title = map['title'] as String,
    children = (map['children'] as List<dynamic>).map((e) => PageBlock(e)).toList();

  @override
  final String id;

  @override
  PageBlockType get type => PageBlockType.section;

  /// The title of the section.
  final String title;

  /// The child blocks of the section.
  final List<PageBlock> children;
}

class ImageBlock implements PageBlock {
  ImageBlock(Map<String, dynamic> map)
  : id = map['id'] as String,
    fileId = map['fileId'] as String?;

  @override
  final String id;

  @override
  PageBlockType get type => PageBlockType.image;

  /// The file ID of the image for the block.
  final String? fileId;
}

class NoteBlock implements PageBlock {
  NoteBlock(Map<String, dynamic> map)
  : id = map['id'] as String,
    detailed = map['detailed'] as bool,
    note = map['note'] as String?;

  @override
  final String id;

  @override
  PageBlockType get type => PageBlockType.note;

  /// Whether the note should be shown in detail.
  final bool detailed;

  /// The ID of the note for the block.
  final String? note;
}

/// Fallback intended for legacy page blocks. Contains the raw JSON data.
class FallbackBlock implements PageBlock {
  FallbackBlock(this.json)
  : id = json['id'] as String;

  @override
  final String id;

  @override
  PageBlockType get type => PageBlockType.fallback;

  /// The raw JSON data of this block.
  final Map<String, dynamic> json;
}