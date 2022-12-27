// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class AppColors {
  // Color Start
  static String strColorPrimary = "#185DA3";
  static String color_blue_start = "#136FCB";
  static String color_blue_end = "#185DA3";

  static String text_color_app = "#1C2D41";

  //  <!--text color-->
  static String color_white = "#FFFFFF";
  static String cool_grey = "#929497";
  static String text_color_about_value = "#3A3A3A";

//  <!-- for button selector color-->
  static String color_transparent = "#00000000";
  static Color colorText = HexColor(text_color_app);
  static Color selectButton = HexColor('#170E4A86');
  static Color colorPrimary = HexColor("#185DA3");
  static Color colorYellowShade = Colors.yellow.shade700;
  static Color colorAccent = HexColor("#185DA3");
  static Color colorBlack = HexColor("#000000");
  static Color colorBlack2 = HexColor("#151515");
  static Color colorBlack3 = HexColor("#F3F3F3");
  static Color colorBlack4 = HexColor("#303030");
  static Color colorBorder = HexColor("#F2F2F2");
  static Color colorBorder2 = HexColor("#DADADA");
  static Color colorBorder3 = HexColor("#A6A6A6");
  static Color colorRating = HexColor("#E5DF2C");
  static Color colorRating2 = HexColor("#FF9700");
  static Color colorIconGray = HexColor("#B0B0B0");
  static Color colorGray = HexColor("#6A6A6A");
  static Color colorGray2 = HexColor("#F8F8F8");
  static Color colorGray3 = HexColor("#77838F");
  static Color colorGray4 = HexColor("#AAAAAA");
  static Color colorGray5 = HexColor("#9C9B9B");
  static Color colorGray6 = HexColor("#EAEAEA");
  static Color colorWhite = HexColor(color_white);
  static Color colorBlueStart = HexColor(color_blue_start);
  static Color colorBlueEnd = HexColor(color_blue_end);
  static Color colorTextBlue = HexColor("#104D88");
  static Color colorTextBlue2 = HexColor("#6688FF");
  static Color colorBlue2 = HexColor("#0E4A86");
  static Color shadowColor = HexColor("#616161");
  static Color grayStart = HexColor("#CECECE");
  static Color grayEnd = HexColor("#303030");
  static Color colorUnselectedIND = HexColor("#D8D8D8");
  static Color colorSelectedIND = HexColor("#989898");
  static Color colorChatBgRight = HexColor("#A4A4A4");
  static Color colorChatBgLeft = HexColor("#F7F7F7");
  static Color colorChatTimeLeft = HexColor("#A1A1BC");
  static Color colorChatMsg = HexColor("#1B1A57");

  // Toast Color

  static Color colorLogoGreenLight = HexColor("#6aba6f");
  static Color colorLogoGreenDark = HexColor("#0d8f15");
  static Color orange = HexColor("#FF7A00");

  static Color colorBtnFillColor = colorWhite;

  static Color colorSemiTrans = const Color(0x0d000000);

  static Color colorTextFieldHint = HexColor("#6B6B6B");
  static Color curiousBlue = HexColor("#337AB7");
  static Color colorTextFildBorderColor = HexColor("#331F2326");
  static Color colorDividerDrawer = HexColor("#1F2326");

  static Color darkRed = const Color(0xffFF3A3A);

  static Color lightGrey = const Color(0xffa6a8ab);
  static Color silver2 = HexColor("#e6e7e8");
  static Color greyDateBG = HexColor("#EDEDED");
  static Color greyOTPBg = HexColor("#E0E0E0");
  static Color grayDashboardItem = HexColor("#F4F4F4");
  static Color grayDashboardTabIcon = HexColor("#7F7F7F");
  static Color grayDashboardText = HexColor("#B1B1B1");
  static Color colorGreen = HexColor("#009E52");
  static Color dartGrey = Colors.grey.shade500;
  //..................Offers status colors.........................
  //.pending
  static Color colorPendingText=HexColor("#d4b106");
  static Color colorPendingBackground=HexColor("#feffe6");
  static Color colorPendingBorder=HexColor("#fffb8f");
  // accepted
  static Color colorSuccessText=HexColor("#389e0d");
  static Color colorSuccessBackground=HexColor("#f6ffed");
  static Color colorSuccessBorder=HexColor("#b7eb8f");
// Cancel
  static Color colorCancelledText=HexColor("#cf1322");
  static Color colorCancelledBackground=HexColor("#fff1f0");
  static Color colorCancelledBorder=HexColor("#ffa39e");

  static Color colorOrange = HexColor("#FF9700");
  static Color colorRED = HexColor("#E20001");

  static Color getMainBgColor() {
    // return AppColors.colorAccent.withOpacity(0.05);
    return AppColors.colorWhite;
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }

    final hexNum = int.parse(hexColor, radix: 16);

    if (hexNum == 0) {
      return 0xff000000;
    }

    return hexNum;
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class ColorToHex extends Color {
  ///convert material colors to hexcolor
  static int _convertColorTHex(Color color) {
    var hex = '${color.value}';
    return int.parse(
      hex,
    );
  }

  ColorToHex(final Color color) : super(_convertColorTHex(color));
}
