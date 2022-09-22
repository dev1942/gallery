import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_style.dart';

// ignore: must_be_immutable
class CustomTextFieldMultiLine extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  bool obscureText;
  TextInputType keyboardType;
  List<TextInputFormatter> inputFormatters;
  int minLines;
  int maxLength;
  int maxLines;
  Function onChanged;

  CustomTextFieldMultiLine(
      {Key? key,
      required this.controller,
      required this.obscureText,
      required this.keyboardType,
      required this.hintText,
      required this.inputFormatters,
      required this.minLines,
      required this.maxLength,
      required this.maxLines,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
        borderRadius:
            const BorderRadius.all(Radius.circular(AppDimens.dimens_5)),
        borderSide: BorderSide(color: AppColors.greyOTPBg));
    return TextField(
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      minLines: minLines,
      maxLength: maxLength,
      maxLines: maxLines,
      autofocus: false,
      onChanged: (String value) {
        onChanged(value);
      },
      buildCounter: (context,
              {required currentLength, required isFocused, maxLength}) =>
          null,
      textCapitalization: TextCapitalization.sentences,
      style: AppStyle.textViewStyleNormalBodyText2(
          context: context,
          color: AppColors.colorTextFieldHint,
          fontSizeDelta: 1,
          fontWeightDelta: -1),
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.colorWhite,
        hintStyle: AppStyle.textViewStyleNormalBodyText2(
            context: context,
            color: AppColors.colorTextFieldHint.withOpacity(0.6),
            fontSizeDelta: 1,
            fontWeightDelta: -1),
        focusedBorder: border,
        border: border,
        contentPadding: const EdgeInsets.only(
            top: AppDimens.dimens_13, left: AppDimens.dimens_10),
        disabledBorder: border,
        enabledBorder: border,
        focusedErrorBorder: border,
        errorBorder: border,
        hintText: hintText,
      ),
    );
  }
}
