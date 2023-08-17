class PollPayload {
  List<String> choices;
  bool? multiple;
  int? expiresAt;
  int? expiredAfter;

  PollPayload(this.choices, {
    this.multiple,
    this.expiresAt,
    this.expiredAfter
  });

  Map<String, dynamic> toJson() => {
      'choices': choices,
      if (multiple != null) 'multiple': multiple,
      if (expiresAt != null) 'expiresAt': expiresAt,
      if (expiredAfter != null) 'expiredAfter': expiredAfter
    };
}