// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_style.dart';
import '../global/app_views.dart';
import '../global/global.dart';

class CustomButton extends StatelessWidget {
  VoidCallback onPressed;
  String strTitle;
  Color? color;
  Color? fontColor;
  double? fontSize;
  int? fontWeight;
  TextStyle? textStyle;
  double? width;
  double? height;
  bool? isRoundBorder;
  bool? isGradient;
  String? strImage;

  CustomButton(
      {Key? key,
      required this.strTitle,
      required this.onPressed,
      this.color,
      this.fontColor,
      this.fontSize,
      this.fontWeight,
      this.height,
      this.width,
      this.textStyle,
      this.isRoundBorder,
      this.isGradient,
      this.strImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? buttonColor = color ?? AppColors.colorBtnFillColor;

    double borderRadius = AppDimens.dimens_5;
    if (isRoundBorder != null && !isRoundBorder!) {
      borderRadius = 0;
    }

    if (isGradient != null && isGradient!) {
      return SizedBox(
        width: width ?? double.maxFinite,
        height: height ?? 50,
        child: Container(
          alignment: Alignment.center,
          decoration:
              AppViews.getGradientBoxDecoration(mBorderRadius: borderRadius),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),

              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              // elevation: MaterialStateProperty.all(3),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: onPressed,
            child: Container(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Global.checkNull(strImage.toString())
                      ? Container(
                          margin:
                              const EdgeInsets.only(right: AppDimens.dimens_10),
                          child: Image.asset(
                            strImage!,
                            width: AppDimens.dimens_20,
                          ),
                        )
                      : const SizedBox(
                          height: 0,
                          width: 0,
                        ),
                  Expanded(
                    child: Text(strTitle,
                        textAlign: TextAlign.center,
                        style: textStyle ??
                            AppStyle.textViewStyleNormalButton(
                                context: context,
                                color: fontColor != null
                                    ? fontColor!
                                    : AppColors.colorTextBlue,
                                fontSizeDelta: fontSize != null ? fontSize! : 1,
                                fontWeightDelta:
                                    fontWeight != null ? fontWeight! : 2)),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        width: width ?? double.maxFinite,
        height: height ?? 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            // primary: buttonColor,
            //   onSurface: buttonColor,
              foregroundColor: buttonColor,
              backgroundColor: buttonColor,
              disabledForegroundColor: buttonColor.withOpacity(0.38),
              disabledBackgroundColor: buttonColor.withOpacity(0.12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius))),
          onPressed: onPressed,
          child: Container(
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Global.checkNull(strImage.toString())
                    ? Container(
                        margin:
                            const EdgeInsets.only(right: AppDimens.dimens_10),
                        child: Image.asset(
                          strImage!,
                          width: AppDimens.dimens_20,
                        ),
                      )
                    : const SizedBox(
                        height: 0,
                        width: 0,
                      ),
                Text(strTitle,
                    style: textStyle ??
                        AppStyle.textViewStyleNormalButton(
                            context: context,
                            color: fontColor != null
                                ? fontColor!
                                : AppColors.colorTextBlue,
                            fontSizeDelta: fontSize != null ? fontSize! : 1,
                            fontWeightDelta:
                                fontWeight != null ? fontWeight! : 2))
              ],
            ),
          ),
        ),
      );
    }
  }
}
