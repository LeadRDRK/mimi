class RetentionRecord {
  RetentionRecord(Map<String, dynamic> map)
  : createdAt = DateTime.parse(map['createdAt'] as String),
    users = map['users'] as int,
    data = Map<String, int>.from(map['data']);

  /// The time of this record.
  final DateTime createdAt;

  /// The user count of this record.
  final int users;

  /// The data of this record.
  /// 
  /// Contains user count mapped to a date string (e.g. `1970-01-01`).
  final Map<String, int> data;
}