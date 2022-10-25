// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';

import '../global/app_dimens.dart';

class CustomTextFieldWithIcon extends StatelessWidget {
  TextEditingController? controller;
  String hintText;
  bool obscureText = false;
  bool enabled = true;
  double? height;

  TextInputType keyboardType;
  FocusNode? focusNode;
  List<TextInputFormatter> inputFormatters;
  ValueChanged<String>? onChanged;
  ValueChanged<String>? onSubmit;
  dynamic onTap;
  Widget? suffixIcon;
  Widget? prefixIcon;
  TextInputAction? textInputAction;

  //autofillHints?
  VoidCallback? onEditingComplete;
  Iterable<String>? autofillHints;

  CustomTextFieldWithIcon(
      {Key? key,
      required this.controller,
      required this.obscureText,
      required this.keyboardType,
      required this.hintText,
      required this.inputFormatters,
      required this.enabled,
      this.focusNode,
      this.textInputAction,
      this.suffixIcon,
      this.height,
      this.prefixIcon,
      this.onEditingComplete,
      this.autofillHints,
      this.onSubmit,
      this.onTap,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      child: TextField(
        onTap: onTap,
        onChanged: onChanged ?? (String strvalue) {},
        onSubmitted: (String? value) {
          if (onSubmit != null) onSubmit!(value!);
        },
        textInputAction: textInputAction ?? TextInputAction.done,
        keyboardType: keyboardType,
        focusNode: focusNode,
        inputFormatters: inputFormatters,
        style: AppStyle.textViewStyleNormalBodyText2(
            color: AppColors.colorBlack,
            fontSizeDelta: 0,
            fontWeightDelta: 0,
            context: context),
        controller: controller,
        obscureText: obscureText,
        textAlign: TextAlign.start,
        enabled: enabled,
        onEditingComplete: onEditingComplete,
        autofillHints: autofillHints,
        decoration: InputDecoration(
          prefixIconConstraints:
              const BoxConstraints(minWidth: AppDimens.dimens_33),
          suffixIconConstraints:
              const BoxConstraints(minWidth: AppDimens.dimens_33),
          suffixIcon: suffixIcon != null
              ? Container(
                  margin: const EdgeInsets.only(
                      right: AppDimens.dimens_12, left: 12),
                  alignment: Alignment.center,
                  child: suffixIcon,
                  width: AppDimens.dimens_23,
                )
              : null,
          prefixIcon: prefixIcon != null
              ? Container(
                  margin: const EdgeInsets.only(
                      left: AppDimens.dimens_12, right: AppDimens.dimens_12),
                  alignment: Alignment.center,
                  child: prefixIcon,
                  width: AppDimens.dimens_30,
                )
              : null,
          contentPadding: const EdgeInsets.only(
              top: AppDimens.dimens_7,
              left: AppDimens.dimens_15,
              right: AppDimens.dimens_15),
          focusedBorder: AppViews.textFieldRoundBorder(),
          enabledBorder: OutlineInputBorder(),
          border: AppViews.textFieldRoundBorder(),
          disabledBorder: AppViews.textFieldRoundBorder(),
          focusedErrorBorder: AppViews.textFieldRoundBorder(),
          hintText: hintText,
          filled: true,
          fillColor: AppColors.colorWhite,
          hintStyle: AppStyle.textViewStyleNormalBodyText2(
              color: AppColors.colorTextFieldHint,
              fontSizeDelta: 0,
              fontWeightDelta: 0,
              context: context),
        ),
      ),
    );
  }
}
