import 'rgb_color.dart';

class Instance {
  Instance(Map<String, dynamic> map)
  : name = map['name'] as String?,
    softwareName = map['softwareName'] as String?,
    softwareVersion = map['softwareVersion'] as String?,
    iconUrl = map['iconUrl'] as String?,
    faviconUrl = map['faviconUrl'] as String?,
    themeColor = map['themeColor'] == null ? null : RGBColor(map['themeColor'] as String);

  /// The name of the instance.
  final String? name;

  /// The name of the software this instance uses.
  final String? softwareName;

  /// The version of the software this instance uses.
  final String? softwareVersion;

  /// The icon URL of the instance.
  final String? iconUrl;

  /// The favicon URL of the instance.
  final String? faviconUrl;

  /// The theme color of the instance.
  final RGBColor? themeColor;
}