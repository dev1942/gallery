import 'package:flutter/material.dart';

import '../../global/app_colors.dart';
import '../../global/app_dimens.dart';
import '../../global/app_style.dart';
import '../custom_button.dart';
class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, btnText;
  final VoidCallback onTap;

  const CustomDialogBox(
      {Key? key,
      required this.title,
      required this.descriptions,
      required this.btnText,
      required this.onTap})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.dimens_5),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.dimens_20),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimens.dimens_10),
          boxShadow: const [
            BoxShadow(
                color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            widget.title,
            style: AppStyle.textViewStyleXLarge(
                context: context,
                color: AppColors.colorBlack,
                fontWeightDelta: -1,
                fontSizeDelta: -4),
          ),
          const SizedBox(
            height: AppDimens.dimens_15,
          ),
          Container(
            child: Text(
              widget.descriptions,
              style: AppStyle.textViewStyleLarge(
                  context: context,
                  color: AppColors.colorBlack,
                  fontWeightDelta: -2,
                  fontSizeDelta: -1),
              textAlign: TextAlign.center,
            ),
            padding: const EdgeInsets.only(
                left: AppDimens.dimens_10, right: AppDimens.dimens_10),
          ),
          const SizedBox(
            height: AppDimens.dimens_22,
          ),
          Container(
            child: CustomButton(
              onPressed: widget.onTap,
              color: AppColors.colorAccent,
              strTitle: widget.btnText,
            ),
            padding: const EdgeInsets.only(
                left: AppDimens.dimens_10, right: AppDimens.dimens_10),
          ),
        ],
      ),
    );
  }
}
