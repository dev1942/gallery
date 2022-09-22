import 'package:flutter/material.dart';

import 'global.dart';

class AppStyle {
  // NAME         SIZE  WEIGHT  SPACING
// headline1    96.0  light   -1.5
// headline2    60.0  light   -0.5
// headline3    48.0  regular  0.0
// headline4    34.0  regular  0.25
// headline5    24.0  regular  0.0
// headline6    20.0  medium   0.15
// subtitle1    16.0  regular  0.15
// subtitle2    14.0  medium   0.1
// body1        16.0  regular  0.5   (bodyText1)
// body2        14.0  regular  0.25  (bodyText2)
// button       14.0  medium   1.25
// caption      12.0  regular  0.4
// overline     10.0  regular  1.5

  // 10
  static TextStyle textViewStyleXSmall(
      {required BuildContext context,
      required Color color,
      int? fontWeightDelta,
      TextDecoration? mDecoration,
      double? fontSizeDelta}) {
    return Theme.of(context).textTheme.overline!.apply(
        color: color,
        fontSizeFactor: 1,
        fontWeightDelta: fontWeightDelta ?? 0,
        fontSizeDelta: fontSizeDelta ?? 0,
        decoration: mDecoration ?? TextDecoration.none,
        fontFamily: Global.poppins,
        letterSpacingDelta: 0);
  }

  // 12
  static TextStyle textViewStyleSmall(
      {required BuildContext context,
      required Color color,
      int? fontWeightDelta,
      TextDecoration? mDecoration,
      double? fontSizeDelta}) {
    return Theme.of(context).textTheme.caption!.apply(
        color: color,
        fontSizeFactor: 1,
        fontWeightDelta: fontWeightDelta ?? 0,
        fontSizeDelta: fontSizeDelta ?? 0,
        decoration: mDecoration ?? TextDecoration.none,
        //   fontFamily: Global.poppins,
        letterSpacingDelta: 0);
  }

  //14
  static TextStyle textViewStyleNormalButton(
      {required BuildContext context,
      required Color color,
      int? fontWeightDelta,
      TextDecoration? mDecoration,
      double? fontSizeDelta}) {
    return Theme.of(context).textTheme.button!.apply(
        color: color,
        fontFamily: Global.poppins,
        fontSizeFactor: 1,
        fontWeightDelta: fontWeightDelta ?? 0,
        fontSizeDelta: fontSizeDelta ?? 0,
        decoration: mDecoration ?? TextDecoration.none,
        letterSpacingDelta: 0);
  }

  //14
  static textViewStyleNormalSubtitle2(
      {required BuildContext context,
      required Color color,
      int? fontWeightDelta,
      TextDecoration? mDecoration,
      double? fontSizeDelta}) {
    return Theme.of(context).textTheme.subtitle2?.apply(
        color: color,
        fontSizeFactor: 1,
        fontWeightDelta: fontWeightDelta ?? 0,
        fontSizeDelta: fontSizeDelta ?? 0,
        decoration: mDecoration ?? TextDecoration.none,
        letterSpacingDelta: 0);
  }

//14
  static textViewStyleNormalBodyText2(
      {required BuildContext context,
      required Color color,
      int? fontWeightDelta,
      TextDecoration? mDecoration,
      double? fontSizeDelta}) {
    return Theme.of(context).textTheme.bodyText2?.apply(
        color: color,
        fontSizeFactor: 1,
        fontWeightDelta: fontWeightDelta ?? 0,
        fontSizeDelta: fontSizeDelta ?? 0,
        decoration: mDecoration ?? TextDecoration.none,
        fontFamily: Global.poppins,
        letterSpacingDelta: 0);
  }

//16
  static textViewStyleLarge(
      {required BuildContext context,
      required Color color,
      int? fontWeightDelta,
      TextDecoration? mDecoration,
      double? fontSizeDelta}) {
    return Theme.of(context).textTheme.bodyText1?.apply(
        color: color,
        fontSizeFactor: 1,
        fontWeightDelta: fontWeightDelta ?? 0,
        fontSizeDelta: fontSizeDelta ?? 0,
        decoration: mDecoration ?? TextDecoration.none,
        fontFamily: Global.poppins,
        letterSpacingDelta: 0);
  }

//16
  static textViewStyleLargeSubtitle1(
      {required BuildContext context,
      required Color color,
      int? fontWeightDelta,
      TextDecoration? mDecoration,
      double? fontSizeDelta}) {
    return Theme.of(context).textTheme.subtitle1?.apply(
        color: color,
        fontSizeFactor: 1,
        fontWeightDelta: fontWeightDelta ?? 0,
        fontSizeDelta: fontSizeDelta ?? 0,
        decoration: mDecoration ?? TextDecoration.none,
        fontFamily: Global.poppins,
        letterSpacingDelta: 0);
  }

//16
  static TextStyle textViewStyleXLarge(
      {required BuildContext context,
      required Color color,
      int? fontWeightDelta,
      TextDecoration? mDecoration,
      double? fontSizeDelta}) {
    return Theme.of(context).textTheme.headline6!.apply(
        color: color,
        fontSizeFactor: 1,
        fontWeightDelta: fontWeightDelta ?? 0,
        fontSizeDelta: fontSizeDelta ?? 0,
        fontFamily: Global.poppins,
        decoration: mDecoration ?? TextDecoration.none,
        letterSpacingDelta: 0);
  }

  static textViewStyleXXXLarge(
      {required BuildContext context,
      required Color color,
      int? fontWeightDelta,
      TextDecoration? mDecoration,
      double? fontSizeDelta}) {
    return Theme.of(context).textTheme.headline4?.apply(
        color: color,
        fontSizeFactor: 1,
        fontWeightDelta: fontWeightDelta ?? 0,
        fontSizeDelta: fontSizeDelta ?? 0,
        fontFamily: Global.poppins,
        decoration: mDecoration ?? TextDecoration.none,
        letterSpacingDelta: 0);
  }

  static textViewStyleXXXXLarge(
      {required BuildContext context,
      required Color color,
      int? fontWeightDelta,
      TextDecoration? mDecoration,
      double? fontSizeDelta}) {
    return Theme.of(context).textTheme.headline3?.apply(
        color: color,
        fontSizeFactor: 1,
        fontWeightDelta: fontWeightDelta ?? 0,
        fontSizeDelta: fontSizeDelta ?? 0,
        fontFamily: Global.poppins,
        decoration: mDecoration ?? TextDecoration.none,
        letterSpacingDelta: 0);
  }

  static textViewStyleXXXXXLarge(
      {required BuildContext context,
      required Color color,
      int? fontWeightDelta,
      TextDecoration? mDecoration,
      double? fontSizeDelta}) {
    return Theme.of(context).textTheme.headline2?.apply(
        color: color,
        fontSizeFactor: 1,
        fontWeightDelta: fontWeightDelta ?? 0,
        fontSizeDelta: fontSizeDelta ?? 0,
        decoration: mDecoration ?? TextDecoration.none,
        fontFamily: Global.poppins,
        letterSpacingDelta: 0);
  }

  static textViewStyleXXXXXXLarge(
      {required BuildContext context,
      required Color color,
      int? fontWeightDelta,
      TextDecoration? mDecoration,
      double? fontSizeDelta}) {
    return Theme.of(context).textTheme.headline1?.apply(
        color: color,
        fontSizeFactor: 1,
        fontWeightDelta: fontWeightDelta ?? 0,
        fontSizeDelta: fontSizeDelta ?? 0,
        fontFamily: Global.poppins,
        decoration: mDecoration ?? TextDecoration.none,
        letterSpacingDelta: 0);
  }
}
