import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/global.dart';

// ignore: must_be_immutable
class ImageSelection extends StatefulWidget {
  double mRatioX;
  double mRatioY;
  int mMaxHeight;
  int mMaxWidth;
  Function mImagePath;
  bool isCropImage;

  ImageSelection(
      {Key? key,
      required this.mRatioX,
      required this.mRatioY,
      required this.mMaxHeight,
      required this.mMaxWidth,
      required this.mImagePath,
      required this.isCropImage})
      : super(key: key);

  @override
  ImageSelectionState createState() => ImageSelectionState();
}

class ImageSelectionState extends State<ImageSelection> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: AppDimens.dimens_5, color: Colors.grey)
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppDimens.dimens_5),
              topRight: Radius.circular(AppDimens.dimens_5))),
      child: ListView(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(
              AppDimens.dimens_10,
            ),
            height: AppDimens.dimens_60,
            alignment: Alignment.center,
            child: Text(
              Constants.STRING_ADD_PHOTO,
              style: AppStyle.textViewStyleLarge(
                  context: context,
                  color: AppColors.colorBlack,
                  fontSizeDelta: 3,
                  fontWeightDelta: -1),
            ),
          ),
          Container(
            child: AppViews.addDividerDrawer(),
          ),
          InkWell(
            child: Container(
              alignment: Alignment.centerLeft,
              height: AppDimens.dimens_36,
              padding: const EdgeInsets.only(left: AppDimens.dimens_20),
              margin: const EdgeInsets.all(
                AppDimens.dimens_10,
              ),
              child: Text(
                Constants.STRING_CHOOSE_FROM_LIB,
                style: AppStyle.textViewStyleLarge(
                    context: context,
                    color: AppColors.colorBlack,
                    fontSizeDelta: 1,
                    fontWeightDelta: -1),
              ),
            ),
            onTap: () {
              getImage(ImageSource.gallery);
            },
          ),
          Container(
            child: AppViews.addDividerDrawer(),
          ),
          InkWell(
            child: Container(
              alignment: Alignment.centerLeft,
              height: AppDimens.dimens_36,
              padding: const EdgeInsets.only(left: AppDimens.dimens_20),
              margin: const EdgeInsets.all(
                AppDimens.dimens_10,
              ),
              child: Text(
                Constants.STRING_CAPTURE_PHOTO,
                style: AppStyle.textViewStyleLarge(
                    context: context,
                    color: AppColors.colorBlack,
                    fontSizeDelta: 1,
                    fontWeightDelta: -1),
              ),
            ),
            onTap: () {
              getImage(ImageSource.camera);
            },
          ),
          Container(
            child: AppViews.addDividerDrawer(),
          ),
          InkWell(
            child: Container(
              alignment: Alignment.centerLeft,
              height: AppDimens.dimens_36,
              padding: const EdgeInsets.only(left: AppDimens.dimens_20),
              margin: const EdgeInsets.all(
                AppDimens.dimens_10,
              ),
              child: Text(
                Constants.STRING_CANCEL,
                style: AppStyle.textViewStyleLarge(
                    context: context,
                    color: AppColors.colorBlack,
                    fontSizeDelta: 1,
                    fontWeightDelta: -1),
              ),
            ),
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ],
      ),
    );
  }

  Future getImage(ImageSource imageSource) async {
    // ignore: invalid_use_of_visible_for_testing_member
    var image = await ImagePicker.platform.pickImage(source: imageSource);
    String strImagePath = "";

    if (widget.isCropImage) {
      File croppedFile = await Global.getCropFile(
          imagePath: image != null ? image.path : "",
          mRatioX: widget.mRatioX,
          mRatioY: widget.mRatioY,
          mMaxHeight: widget.mMaxHeight,
          mMaxWidth: widget.mMaxWidth);

      if (!mounted) return;

      strImagePath = croppedFile.path;
    } else {
      strImagePath = image != null ? image.path : "";
    }
    widget.mImagePath(strImagePath);
    Navigator.of(context, rootNavigator: true).pop();
  }
}
