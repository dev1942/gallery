import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_style.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  TextEditingController? controller;
  String hintText;
  bool obscureText;
  bool enabled = true;

  TextInputType keyboardType;
  FocusNode? focusNode;
  List<TextInputFormatter> inputFormatters;
  ValueChanged<String>? onChanged;

  CustomTextField(
      {Key? key,
      required this.controller,
      required this.obscureText,
      required this.keyboardType,
      required this.hintText,
      required this.inputFormatters,
      required this.enabled,
      this.focusNode,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: TextField(
        onChanged: onChanged ?? (String strvalue) {},
        keyboardType: keyboardType,
        focusNode: focusNode,
        inputFormatters: inputFormatters,
        style: AppStyle.textViewStyleNormalBodyText2(
            context: context,
            color: AppColors.colorTextFieldHint,
            fontSizeDelta: 3,
            fontWeightDelta: -1),
        controller: controller,
        obscureText: obscureText,
        textAlign: TextAlign.start,
        enabled: enabled,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 13, left: 3),
          focusedBorder: const UnderlineInputBorder(),
          border: const UnderlineInputBorder(),
          hintText: hintText,
          filled: true,
          fillColor: AppColors.colorWhite,
          hintStyle: AppStyle.textViewStyleNormalBodyText2(
              color: AppColors.colorTextFieldHint.withOpacity(0.6),
              fontSizeDelta: 3,
              fontWeightDelta: -1,
              context: context),
        ),
        // decoration: new InputDecoration.collapsed(
        //   filled: true,
        //   fillColor: AppColors.colorWhite,
        //   hintStyle: AppStyle.textViewStyleNormalBodyText2(
        //       color: AppColors.colorTextFieldHint.withOpacity(0.6),
        //       fontSizeDelta: 1,
        //       fontWeightDelta: -1,
        //       context: context),
        //   hintText: hintText,
        // ),
      ),
    );
  }
}
