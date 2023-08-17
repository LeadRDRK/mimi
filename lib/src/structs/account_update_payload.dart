import 'user_field.dart';
import 'notification.dart';

/// Payload for the account update API.
class AccountUpdatePayload {
  String? name;
  String? description;
  String? location;
  String? birthday;
  String? lang;
  String? avatarId;
  String? bannerId;
  List<BaseUserField>? fields;
  bool? isLocked;
  bool? isExplorable;
  bool? hideOnlineStatus;
  bool? publicReactions;
  bool? carefulBot;
  bool? autoAcceptFollowed;
  bool? noCrawle;
  bool? preventAiLearning;
  bool? isBot;
  bool? isCat;
  bool? injectFeaturedNote;
  bool? receiveAnnouncementEmail;
  bool? alwaysMarkNsfw;
  bool? autoSensitive;
  FollowVisibility? ffVisibility;
  String? pinnedPageId;
  List<String>? mutedWords;
  List<String>? mutedInstances;
  List<NotificationType>? mutingNotificationTypes;
  List<String>? emailNotificationTypes;
  List<String>? alsoKnownAs;

  AccountUpdatePayload({
    this.name,
    this.description,
    this.location,
    this.birthday,
    this.lang,
    this.avatarId,
    this.bannerId,
    this.fields,
    this.isLocked,
    this.isExplorable,
    this.hideOnlineStatus,
    this.publicReactions,
    this.carefulBot,
    this.autoAcceptFollowed,
    this.noCrawle,
    this.preventAiLearning,
    this.isBot,
    this.isCat,
    this.injectFeaturedNote,
    this.receiveAnnouncementEmail,
    this.alwaysMarkNsfw,
    this.autoSensitive,
    this.ffVisibility,
    this.pinnedPageId,
    this.mutedWords,
    this.mutedInstances,
    this.mutingNotificationTypes,
    this.emailNotificationTypes,
    this.alsoKnownAs
  });

  Map<String, dynamic> toJson() => {
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (location != null) 'location': location,
      if (birthday != null) 'birthday': birthday,
      if (lang != null) 'lang': lang,
      if (avatarId != null) 'avatarId': avatarId,
      if (bannerId != null) 'bannerId': bannerId,
      if (fields != null) 'fields': fields,
      if (isLocked != null) 'isLocked': isLocked,
      if (isExplorable != null) 'isExplorable': isExplorable,
      if (hideOnlineStatus != null) 'hideOnlineStatus': hideOnlineStatus,
      if (publicReactions != null) 'publicReactions': publicReactions,
      if (carefulBot != null) 'carefulBot': carefulBot,
      if (autoAcceptFollowed != null) 'autoAcceptFollowed': autoAcceptFollowed,
      if (noCrawle != null) 'noCrawle': noCrawle,
      if (preventAiLearning != null) 'preventAiLearning': preventAiLearning,
      if (isBot != null) 'isBot': isBot,
      if (isCat != null) 'isCat': isCat,
      if (injectFeaturedNote != null) 'injectFeaturedNote': injectFeaturedNote,
      if (receiveAnnouncementEmail != null)
        'receiveAnnouncementEmail': receiveAnnouncementEmail,
      if (alwaysMarkNsfw != null) 'alwaysMarkNsfw': alwaysMarkNsfw,
      if (autoSensitive != null) 'autoSensitive': autoSensitive,
      if (ffVisibility != null) 'ffVisibility': ffVisibility,
      if (pinnedPageId != null) 'pinnedPageId': pinnedPageId,
      if (mutedWords != null) 'mutedWords': mutedWords,
      if (mutedInstances != null) 'mutedInstances': mutedInstances,
      if (mutingNotificationTypes != null)
        'mutingNotificationTypes': mutingNotificationTypes,
      if (emailNotificationTypes != null)
        'emailNotificationTypes': emailNotificationTypes,
      if (alsoKnownAs != null) 'alsoKnownAs': alsoKnownAs
    };
}

enum FollowVisibility {
  public,
  followers,
  private;

  String toJson() => name;
}