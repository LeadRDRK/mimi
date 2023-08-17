import 'poll_payload.dart';

class NotePayload {
  String? visibility;
  List<String>? visibleUserIds;
  String? cw;
  bool? localOnly;
  String? reactionAcceptance;
  bool? noExtractMentions;
  bool? noExtractHashtags;
  bool? noExtractEmojis;
  String? replyId;
  String? renoteId;
  String? channelId;
  String? text;
  List<String>? fileIds;
  List<String>? mediaIds;
  PollPayload? poll;

  NotePayload({
    this.visibility,
    this.visibleUserIds,
    this.cw,
    this.localOnly,
    this.reactionAcceptance,
    this.noExtractMentions,
    this.noExtractHashtags,
    this.noExtractEmojis,
    this.replyId,
    this.renoteId,
    this.channelId,
    this.text,
    this.fileIds,
    this.mediaIds,
    this.poll
  });

  /// Whether this payload has one of the required properties
  /// to be a valid payload.
  bool get isValid =>
      text != null || renoteId != null || fileIds != null ||
      mediaIds != null || poll != null;

  Map<String, dynamic> toJson() => {
      if (visibility != null) 'visibility': visibility,
      if (visibleUserIds != null) 'visibleUserIds': visibleUserIds,
      if (cw != null) 'cw': cw,
      if (localOnly != null) 'localOnly': localOnly,
      if (reactionAcceptance != null) 'reactionAcceptance': reactionAcceptance,
      if (noExtractMentions != null) 'noExtractMentions': noExtractMentions,
      if (noExtractHashtags != null) 'noExtractHashtags': noExtractHashtags,
      if (noExtractEmojis != null) 'noExtractEmojis': noExtractEmojis,
      if (replyId != null) 'replyId': replyId,
      if (renoteId != null) 'renoteId': renoteId,
      if (channelId != null) 'channelId': channelId,
      if (text != null) 'text': text,
      if (fileIds != null) 'fileIds': fileIds,
      if (mediaIds != null) 'mediaIds': mediaIds,
      if (poll != null) 'poll': poll
    };
  
  NotePayload copyWith({
    String? visibility,
    List<String>? visibleUserIds,
    String? cw,
    bool? localOnly,
    String? reactionAcceptance,
    bool? noExtractMentions,
    bool? noExtractHashtags,
    bool? noExtractEmojis,
    String? replyId,
    String? renoteId,
    String? channelId,
    String? text,
    List<String>? fileIds,
    List<String>? mediaIds,
    PollPayload? poll
  }) => NotePayload(
      visibility: visibility ?? this.visibility,
      visibleUserIds: visibleUserIds ?? this.visibleUserIds,
      cw: cw ?? this.cw,
      localOnly: localOnly ?? this.localOnly,
      reactionAcceptance: reactionAcceptance ?? this.reactionAcceptance,
      noExtractMentions: noExtractMentions ?? this.noExtractMentions,
      noExtractHashtags: noExtractHashtags ?? this.noExtractHashtags,
      noExtractEmojis: noExtractEmojis ?? this.noExtractEmojis,
      replyId: replyId ?? this.replyId,
      renoteId: renoteId ?? this.renoteId,
      channelId: channelId ?? this.channelId,
      text: text ?? this.text,
      fileIds: fileIds ?? this.fileIds,
      mediaIds: mediaIds ?? this.mediaIds,
      poll: poll ?? this.poll
    );
  
  factory NotePayload.text(String text, NotePayload? options) =>
      options != null ? options.copyWith(text: text) : NotePayload(text: text);
  
  factory NotePayload.renote(String renoteId, NotePayload? options) =>
      options != null ? options.copyWith(renoteId: renoteId) : NotePayload(renoteId: renoteId);
  
  factory NotePayload.files(List<String> fileIds, NotePayload? options) =>
      options != null ? options.copyWith(fileIds: fileIds) : NotePayload(fileIds: fileIds);
  
  factory NotePayload.medias(List<String> mediaIds, NotePayload? options) =>
      options != null ? options.copyWith(mediaIds: mediaIds) : NotePayload(mediaIds: mediaIds);
  
  factory NotePayload.poll(PollPayload poll, NotePayload? options) =>
      options != null ? options.copyWith(poll: poll) : NotePayload(poll: poll);
  
  factory NotePayload.reply(String replyId, NotePayload options) =>
      options.copyWith(replyId: replyId);
}