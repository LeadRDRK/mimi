class ServerInfo {
  ServerInfo(Map<String, dynamic> map)
  : machine = map['machine'] as String,
    cpuModel = map['cpuModel'] as String,
    cpuCores = map['cpuCores'] as int,
    memTotal = map['memTotal'] as int,
    fsTotal = map['fsTotal'] as int,
    fsUsed = map['fsUsed'] as int;

  /// The machine's name.
  final String machine;

  /// The CPU model.
  final String cpuModel;

  /// The CPU cores count.
  final int cpuCores;

  /// The total amount of memory in bytes.
  final int memTotal;

  /// The total amount of disk space in bytes.
  final int fsTotal;

  /// The used amount of disk space in bytes.
  final int fsUsed;
}