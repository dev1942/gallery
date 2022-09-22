import 'dart:io';

import 'package:flutter/material.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/widgets/fade_in_image.dart';

class ImageView extends StatelessWidget {
  final String strImage;
  final double? height;
  final double? width;

  const ImageView({
    Key? key,
    required this.strImage,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width_ = width != null ? width! : AppDimens.dimens_100;

    double height_ = height != null ? height! : AppDimens.dimens_100;

    return ClipRRect(
        borderRadius: BorderRadius.circular(AppDimens.dimens_5),
        child: Container(
          color: AppColors.colorGray2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppDimens.dimens_10),
            child: !strImage.startsWith("http")
                ? Image.file(File(strImage),
                    height: height_, width: width_, fit: BoxFit.cover)
                : NetworkImageCustom(
                    height: height_, width: width_, image: strImage),
          ),
          width: width_,
          height: height_,
        ));
  }
}
