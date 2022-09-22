import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../colors/primary_color_swatch.dart';
import '../global.dart';

class BoosterThemeData {
  BuildContext? _context;

  BoosterThemeData(BuildContext context) {
    _context = context;
  }

  static BoosterThemeData of(BuildContext context) {
    return BoosterThemeData(context);
  }

  ThemeData get theme => Theme.of(_context!);

  TextTheme get textTheme => theme.textTheme;

  late ColorScheme colorScheme;

  ThemeData get dark => getThemeForBrightness(Brightness.dark);

  ThemeData get light => getThemeForBrightness(Brightness.light);

  getThemeForBrightness(Brightness brightness) {
    bool isDark = brightness == Brightness.dark;
    colorScheme = getColorScheme(isDark);
    return ThemeData(
      brightness: brightness,
      canvasColor: Colors.white,
      fontFamily: Global.poppins,
      primaryColor: AppColors.colorPrimary,
      primarySwatch: createMaterialColor(),
      colorScheme: getColorScheme(isDark),
      unselectedWidgetColor: colorScheme.primary,
      textTheme: textTheme
          .apply(
            bodyColor: colorScheme.onSurface,
            displayColor: colorScheme.onSurface,
            fontFamily: Global.poppins,
          )
          .copyWith(
            subtitle2: textTheme.subtitle2?.apply(
              color: colorScheme.onSurface,
              fontWeightDelta: -1,
              fontFamily: Global.poppins,
            ),
            overline: textTheme.overline?.apply(
              color: colorScheme.onSurface,
              letterSpacingDelta: -1.5,
              fontFamily: Global.poppins,
            ),
            caption: textTheme.caption?.apply(
              color: colorScheme.onSurface,
              fontSizeDelta: 1.0,
              fontFamily: Global.poppins,
            ),
            headline6: textTheme.headline6?.apply(
              color: colorScheme.onSurface,
              fontWeightDelta: -1,
              fontFamily: Global.poppins,
            ),
          ),
    );
  }

  ColorScheme getColorScheme(bool isDark) {
    return isDark
        ? ColorScheme.dark(
            primary: AppColors.colorPrimary,
            secondary: AppColors.colorPrimary,
            onSecondary: Colors.white,
            onPrimary: Colors.white,
            surface: Colors.grey.shade800,
            background: Colors.grey.shade700,
          )
        : ColorScheme.light(
            primary: AppColors.colorPrimary,
            secondary: AppColors.colorPrimary,
            background: AppColors.silver2,
            onSecondary: Colors.white,
            onPrimary: Colors.white,
            onSurface: AppColors.colorBlack,
            onBackground: AppColors.colorWhite,
          );
  }
}
