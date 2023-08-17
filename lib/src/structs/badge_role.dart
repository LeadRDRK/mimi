class BadgeRole {
  BadgeRole(Map<String, dynamic> map)
  : name = map['name'] as String,
    iconUrl = map['iconUrl'] as String,
    // 13.10.0
    displayOrder = (map['displayOrder'] ?? 0) as int;

  /// The name of the badge role.
  final String name;

  /// The icon URL of the badge role.
  final String iconUrl;

  /// The display order of the badge role.
  final int displayOrder;
}