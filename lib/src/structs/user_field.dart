abstract class BaseUserField {
  /// The name of the field.
  String get name;

  /// The value of the field.
  String get value;

  Map<String, dynamic> toJson() => {
      'name': name,
      'value': value
    };
}

/// An additional information field for a user.
class UserField extends BaseUserField {
  UserField(Map<String, dynamic> map)
  : name = map['name'] as String,
    value = map['value'] as String;

  @override
  final String name;

  @override
  final String value;
}

/// A payload for an additional information field for a user.
/// 
/// Similar to [UserField], but with modifiable properties
/// and a normal constructor.
class UserFieldPayload extends BaseUserField {
  UserFieldPayload(this.name, this.value);

  @override
  String name;

  @override
  String value;
}