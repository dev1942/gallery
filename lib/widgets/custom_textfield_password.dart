import 'package:flutter/material.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_style.dart';

import '../global/app_dimens.dart';
import '../global/app_views.dart';

// ignore: must_be_immutable
class CustomTextFieldPassword extends StatelessWidget {
  TextEditingController? controller;
  String hintText;
  bool obscureText = false;
  bool enabled = true;
  ValueChanged<bool>? onChanged;
  FocusNode? focusNode;

  TextInputAction? textInputAction;

  CustomTextFieldPassword(
      {Key? key,
      required this.controller,
      required this.obscureText,
      required this.hintText,
      required this.enabled,
      this.focusNode,
      this.textInputAction,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        keyboardType: TextInputType.text,
        inputFormatters: const [],
        textInputAction: textInputAction ?? TextInputAction.done,
        focusNode: focusNode,
        style: AppStyle.textViewStyleNormalBodyText2(
            color: AppColors.colorBlack,
            fontSizeDelta: 0,
            fontWeightDelta: 0,
            context: context),
        controller: controller,
        obscureText: obscureText,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          contentPadding: const EdgeInsetsDirectional.only(top: 7, start: 15),
          prefixIconConstraints: const BoxConstraints(minWidth: 33),
          suffixIconConstraints:
              const BoxConstraints(minWidth: 23, maxHeight: 30),
          suffixIcon: InkWell(
            child: Container(
              margin: const EdgeInsetsDirectional.only(end: 12),
              alignment: Alignment.center,
              child: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: AppColors.colorIconGray,
                size: AppDimens.dimens_22,
                semanticLabel: obscureText ? 'show password' : 'hide password',
              ),
              height: 27,
              width: 23,
            ),
            onTap: () {
              onChanged!(!obscureText);
            },
          ),
          focusedBorder: AppViews.textFieldRoundBorder(),
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
