import 'package:meta/meta.dart';
import '../entities/note.dart';
import '../core/client.dart';
import '../entities/user_lite.dart';

abstract class Notification {
  @protected
  Notification.$(Map<String, dynamic> map)
  : id = map['id'] as String,
    createdAt = DateTime.parse(map['createdAt'] as String);

  /// The ID of the notification.
  final String id;

  /// The time when the notification was created.
  final DateTime createdAt;

  /// The notification type.
  NotificationType get type;

  factory Notification(Client client, Map<String, dynamic> map) {
    final type = map['type'] as String;
    switch (type) {
      case 'follow': return FollowNotification(client, map);
      case 'mention': return MentionNotification(client, map);
      case 'reply': return ReplyNotification(client, map);
      case 'renote': return RenoteNotification(client, map);
      case 'quote': return QuoteNotification(client, map);
      case 'reaction': return ReactionNotification(client, map);
      case 'pollEnded': return PollEndedNotification(client, map);
      case 'receiveFollowRequest': return ReceiveFollowRequestNotification(client, map);
      case 'followRequestAccepted': return FollowRequestAcceptedNotification(client, map);
      case 'achievementEarned': return AchievementEarnedNotification(map);
      case 'app': return AppNotification(map);
      case 'pollVote': return PollVoteNotification(client, map);
      case 'groupInvited': return GroupInvitedNotification(client, map);
      default: throw Exception('Invalid notification type');
    }
  }
}

enum NotificationType {
  follow,
  mention,
  reply,
  renote,
  quote,
  reaction,
  pollEnded,
  receiveFollowRequest,
  followRequestAccepted,
  achievementEarned,
  app,

  // Obsolete types
  pollVote,
  groupInvited;

  String toJson() => name;
}

abstract class NotificationWithUser extends Notification {
  NotificationWithUser(Client client, Map<String, dynamic> map)
  : user = UserLite(client, map['user']),
    userId = map['userId'] as String,
    super.$(map);

  /// The user related to this notification.
	final UserLite user;

  /// The ID of the user related to this notification.
	final String userId;
}

abstract class NotificationWithNote extends Notification {
  NotificationWithNote(Client client, Map<String, dynamic> map)
  : note = Note(client, map['note']),
    super.$(map);

  /// The note related to this notification.
	final Note note;
}

abstract class NotificationWithUserAndNote extends NotificationWithUser implements NotificationWithNote {
  NotificationWithUserAndNote(Client client, Map<String, dynamic> map)
  : note = Note(client, map['note']),
    super(client, map);

  /// The note related to this notification.
  @override
	final Note note;
}

class FollowNotification extends NotificationWithUser {
  FollowNotification(Client client, Map<String, dynamic> map)
  : super(client, map);

  @override
  NotificationType get type => NotificationType.follow;
}

class MentionNotification extends NotificationWithUserAndNote {
  MentionNotification(Client client, Map<String, dynamic> map)
  : super(client, map);

  @override
  NotificationType get type => NotificationType.mention;
}

class ReplyNotification extends NotificationWithUserAndNote {
  ReplyNotification(Client client, Map<String, dynamic> map)
  : super(client, map);

  @override
  NotificationType get type => NotificationType.reply;
}

class RenoteNotification extends NotificationWithUserAndNote {
  RenoteNotification(Client client, Map<String, dynamic> map)
  : super(client, map);

  @override
  NotificationType get type => NotificationType.renote;
}

class QuoteNotification extends NotificationWithUserAndNote {
  QuoteNotification(Client client, Map<String, dynamic> map)
  : super(client, map);

  @override
  NotificationType get type => NotificationType.quote;
}

class ReactionNotification extends NotificationWithUserAndNote {
  ReactionNotification(Client client, Map<String, dynamic> map)
  : reaction = map['reaction'] as String,
    super(client, map);

  @override
  NotificationType get type => NotificationType.reaction;

  /// The reaction name.
  final String reaction;
}

class PollEndedNotification extends NotificationWithNote {
  PollEndedNotification(Client client, Map<String, dynamic> map)
  : super(client, map);

  @override
  NotificationType get type => NotificationType.pollEnded;
}

class ReceiveFollowRequestNotification extends NotificationWithUser {
  ReceiveFollowRequestNotification(Client client, Map<String, dynamic> map)
  : super(client, map);

  @override
  NotificationType get type => NotificationType.receiveFollowRequest;
}

class FollowRequestAcceptedNotification extends NotificationWithUser {
  FollowRequestAcceptedNotification(Client client, Map<String, dynamic> map)
  : super(client, map);

  @override
  NotificationType get type => NotificationType.followRequestAccepted;
}

class AchievementEarnedNotification extends Notification {
  AchievementEarnedNotification(Map<String, dynamic> map)
  : achievement = map['achievement'] as String,
    super.$(map);
  
  @override
  NotificationType get type => NotificationType.achievementEarned;

  /// The achievement that the client user earned.
  final String achievement;
}

class AppNotification extends Notification {
  AppNotification(Map<String, dynamic> map)
  : header = map['header'] as String?,
    body = map['body'] as String,
    icon = map['icon'] as String?,
    super.$(map);
  
  @override
  NotificationType get type => NotificationType.app;

  /// The header of the notification.
  final String? header;

  /// The body of the notification.
  final String body;

  /// The icon of the notification.
  final String? icon;
}

/// Obsolete.
class PollVoteNotification extends NotificationWithUserAndNote {
  PollVoteNotification(Client client, Map<String, dynamic> map)
  : super(client, map);

  @override
  NotificationType get type => NotificationType.pollVote;
}

/// Obsolete.
class GroupInvitedNotification extends NotificationWithUser {
  GroupInvitedNotification(Client client, Map<String, dynamic> map)
  : invitation = map['invitation'] as Map<String, dynamic>,
    super(client, map);

  @override
  NotificationType get type => NotificationType.groupInvited;

  /// The user group of the invitation.
  /// 
  /// This property belongs to an obsolete notification type
  /// and is not implemented properly.
  final Map<String, dynamic> invitation;
}