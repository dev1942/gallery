import 'package:flutter/material.dart';
import 'package:otobucks/global/app_colors.dart';

TextStyle headingText(double size) {
  return TextStyle(
      color: Colors.black, fontSize: size, fontWeight: FontWeight.bold);
}

TextStyle subHeadingText(double size) {
  return TextStyle(
      color: Colors.black, fontSize: size, fontWeight: FontWeight.w600);
}

TextStyle headingColoredText(double size) {
  return TextStyle(
      // fontFamily: "Roboto",
      color: AppColors.colorBlueStart,
      fontSize: size,
      fontWeight: FontWeight.bold);
}

TextStyle regularText(double size) {
  return TextStyle(
    // fontFamily: "Roboto",
    color: Colors.black,
    fontSize: size,
    fontWeight: FontWeight.normal,
  );
}

TextStyle regularText600(double size) {
  return TextStyle(
    // fontFamily: "Roboto",
    color: Colors.black,
    fontSize: size,
    fontWeight: FontWeight.w600,
  );
}

TextStyle underLineText(double size) {
  return TextStyle(
      // fontFamily: "Roboto",
      color: Colors.black,
      fontSize: size,
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.underline);
}

TextStyle lightText(double size) {
  return TextStyle(
    height: 1.2,
    // fontFamily: "Roboto",
    color: AppColors.colorGray3,
    fontSize: size,
    fontWeight: FontWeight.normal,
  );
}
