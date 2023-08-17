class EmailAvailableResult {
  EmailAvailableResult(Map<String, dynamic> map)
  : available = map['available'] as bool,
    reason = map['reason'] as String?;

  /// Whether the email address is available for use.
  final bool available;

  /// The reason if the email address isn't available.
  final String? reason;
}