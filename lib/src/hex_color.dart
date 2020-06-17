import 'dart:ui';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Converts an rgba value (0-255) into a 2-digit Hex code.
  String _hexValue(int rgbaVal) {
    assert(rgbaVal == rgbaVal & 0xFF);
    return rgbaVal.toRadixString(16).padLeft(2, '0').toUpperCase();
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${_hexValue(alpha)}${_hexValue(red)}${_hexValue(green)}${_hexValue(blue)}';
}
