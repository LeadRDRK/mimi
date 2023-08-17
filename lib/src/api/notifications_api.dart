import '../core/client.dart';
import '../core/base.dart';
import '../structs/notification.dart';

class NotificationsApi extends Base {
  NotificationsApi(Client client)
  : super(client);

  /// Gets a list of the client user's notifications.
  Future<List<Notification>> list({
    int? limit,
    String? sinceId,
    String? untilId,
    bool? markAsRead,
    List<NotificationType>? includeTypes,
    List<NotificationType>? excludeTypes
  }) async =>
      (await client.api.post<List<dynamic>>('i/notifications', body: {
        if (limit != null) 'limit': limit,
        if (sinceId != null) 'sinceId': sinceId,
        if (untilId != null) 'untilId': untilId,
        if (markAsRead != null) 'markAsRead': markAsRead,
        if (includeTypes != null) 'includeTypes': includeTypes,
        if (excludeTypes != null) 'excludeTypes': excludeTypes,
      }))
      .map((e) => Notification(client, e))
      .toList();
  
  /// Creates an app notification.
  Future<void> create(String body, {
    String? header,
    String? icon
  }) =>
      client.api.post('notifications/create', body: {
        'body': body,
        if (header != null) 'header': header,
        if (icon != null) 'icon': icon
      });
  
  /// Marks all notifications as read.
  Future<void> markAllAsRead() => client.api.post('notifications/mark-all-as-read');
}