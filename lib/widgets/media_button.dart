import 'package:flutter/material.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';

class MediaButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String strImage;
  final double? height;
  final double? width;

  const MediaButton({
    Key? key,
    required this.strImage,
    required this.onPressed,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimens.dimens_5),
          child: Container(
            color: AppColors.colorGray2,
            child: Image.asset(
              strImage,
            ),
            padding: const EdgeInsets.all(AppDimens.dimens_35),
            width: width ?? AppDimens.dimens_100,
            height: height ?? AppDimens.dimens_100,
          )),
      onTap: () {
        onPressed();
      },
    );
  }
}
