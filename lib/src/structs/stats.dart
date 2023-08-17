class Stats {
  Stats(Map<String, dynamic> map)
  : notesCount = map['notesCount'] as int,
    originalNotesCount = map['originalNotesCount'] as int,
    usersCount = map['usersCount'] as int,
    originalUsersCount = map['originalUsersCount'] as int,
    instances = map['instances'] as int,
    driveUsageLocal = map['driveUsageLocal'] as int,
    driveUsageRemote = map['driveUsageRemote'] as int;

  /// The notes count (including remote notes).
  final int notesCount;

  /// The local notes count.
  final int originalNotesCount;

  /// The users count (including remote users).
  final int usersCount;

  /// The local users count.
  final int originalUsersCount;

  /// The federated instances count.
  final int instances;

  /// The local drive usage in bytes.
  final int driveUsageLocal;

  /// The remote drive usage in bytes.
  final int driveUsageRemote;
}