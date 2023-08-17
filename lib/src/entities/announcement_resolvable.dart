import '../core/base.dart';
import '../core/client.dart';
import '../core/resolvable_id.dart';

/// Data that can be resolved to an Announcement.
class AnnouncementResolvable extends Base implements ResolvableId {
  AnnouncementResolvable(Client client, this.id)
  : super(client);

  /// The announcement's ID.
  @override
  final String id;

  /// Marks the announcement as read.
  /// 
  /// Alias for `account.readAnnouncement(id)`
  Future<void> read() => client.account.readAnnouncement(id);
}