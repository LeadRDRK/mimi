class Achievement {
  Achievement(Map<String, dynamic> map)
  : name = map['name'] as String,
    unlockedAt = DateTime.fromMillisecondsSinceEpoch(map['unlockedAt'] as int);

  /// The name of the achievement.
  final String name;

  /// The time when this achievement was unlocked.
  final DateTime unlockedAt;
}