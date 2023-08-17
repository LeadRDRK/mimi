class NoteTranslation {
  NoteTranslation(Map<String, dynamic> map)
  : sourceLang = map['sourceLang'] as String,
    text = map['text'] as String;

  /// The source language.
  final String sourceLang;

  /// The translated text.
  final String text;
}