import 'package:flutter/material.dart';

import '../app_colors.dart';

class PrimaryColorSwatch {
  static createSwatch(String hexValue) {
    return Colors.transparent;
  }

  static Map<String, int>? hexStringToRGBMap(String hexValue) {
    var hex = hexValue.replaceFirst("#", "");
    if (hex.length != 6) return null;

    Map<String, int> mapOfRGB = {};
    mapOfRGB["r"] = int.parse(hex.substring(0, 2), radix: 16);
    mapOfRGB["g"] = int.parse(hex.substring(2, 4), radix: 16);
    mapOfRGB["b"] = int.parse(hex.substring(4, hex.length), radix: 16);
    return mapOfRGB;
  }

  static int fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return int.parse(buffer.toString(), radix: 16);
  }
}

MaterialColor get primaryColor {
  final intValue = PrimaryColorSwatch.fromHex(AppColors.strColorPrimary);
  final swatch = PrimaryColorSwatch.createSwatch(AppColors.strColorPrimary);
  return MaterialColor(intValue, swatch);
}

MaterialColor createMaterialColor() {
  Color colorPrimary = AppColors.colorPrimary;
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = colorPrimary.red, g = colorPrimary.green, b = colorPrimary.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(colorPrimary.value, swatch);
}
