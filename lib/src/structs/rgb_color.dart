final _rgbSplitRegex = RegExp(r' *, *');

class RGBColor {
  RGBColor(this.cssValue) {
    final v = cssValue;
    try {
      if (v[0] == '#') {
        value = int.parse(
          v.length == 4 ?
            '${v[1] * 2}${v[2] * 2}${v[3] * 2}' :
            v.substring(1, 7), 
          radix: 16
        );
      }
      else if (v.startsWith('rgb(')) {
        final str = v.substring(4, v.length - 1);
        final vs = str.split(_rgbSplitRegex).map((e) => int.parse(e)).toList();
        value = (vs[0] << 16) | (vs[1] << 8) | vs[2];
      }
      else {
        value = 0;
      }
    }
    catch (e) {
      value = 0;
    }
  }

  /// The original CSS hex color value.
  /// 
  /// Possible formats: `#fff`, `#eeddff`, `rgb(12, 34, 56)`
  final String cssValue;
  /// The RGB value.
  /// 
  /// The color might fail to be parsed; in which case the value will
  /// be set to 0.
  late final int value;

  /// The RGB value in ARGB format with alpha set to 255.
  /// 
  /// Useful for constructing a Flutter color value. e.g. `Color(argbValue)`
  int get argbValue => 0xff000000 | value;

  /// The red channel of this color.
  int get red => (0xff0000 & value) >> 16;

  /// The green channel of this color.
  int get green => (0x00ff00 & value) >> 8;

  /// The blue channel of this color.
  int get blue => (0x0000ff & value);
}