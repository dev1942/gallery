import 'package:flutter/material.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';

import '../../../global/app_colors.dart';
import '../../../widgets/custom_button.dart';



class OnWithdrawDialogBox extends StatefulWidget {
  final Function onAddAccount;
  final Function onWithdraw;

  const OnWithdrawDialogBox(
      {Key? key, required this.onWithdraw, required this.onAddAccount})
      : super(key: key);

  @override
  _OnWithdrawDialogBoxState createState() => _OnWithdrawDialogBoxState();
}

class _OnWithdrawDialogBoxState extends State<OnWithdrawDialogBox> {
  @override
  void initState() {
    super.initState();
  }

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
      padding: const EdgeInsets.only(
          top: AppDimens.dimens_20, bottom: AppDimens.dimens_20),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimens.dimens_5),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0, 3),
                blurRadius: 5),
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
                left: AppDimens.dimens_15,
                bottom: AppDimens.dimens_10,
                right: AppDimens.dimens_15),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    Constants.TXT_ALERT,
                    style: AppStyle.textViewStyleLarge(
                        context: context,
                        color: AppColors.colorBlack,
                        fontWeightDelta: 1,
                        fontSizeDelta: 3),
                  ),
                )),
                InkWell(
                  child: const Icon(
                    Icons.clear,
                    size: AppDimens.dimens_20,
                  ),
                  onTap: () {
                    Navigator.of(context).pop(true);
                  },
                )
              ],
            ),
          ),
          AppViews.addDivider(),
          Container(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                  left: AppDimens.dimens_30, right: AppDimens.dimens_30),
              child: Text(
                Constants.TXT_WITHDRAW_MONEY_OPTION,
                textAlign: TextAlign.start,
                style: AppStyle.textViewStyleLarge(
                    context: context,
                    color: AppColors.colorBlack,
                    fontWeightDelta: 1,
                    fontSizeDelta: 0),
              ),
            ),
            margin: const EdgeInsets.symmetric(vertical: 20),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: CustomButton(
                    height: AppDimens.dimens_40,
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      widget.onWithdraw();
                    },
                    isGradient: true,
                    fontSize: -2,
                    fontColor: AppColors.colorWhite,
                    strTitle: Constants.TXT_WITHDRAW_OPTION_TEXT,
                  ),
                  padding: const EdgeInsets.only(
                      left: AppDimens.dimens_10, right: AppDimens.dimens_10),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Container(
                  child: CustomButton(
                    height: AppDimens.dimens_40,
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      widget.onAddAccount();
                    },
                    fontSize: -2,
                    isGradient: true,
                    fontColor: AppColors.colorWhite,
                    strTitle: Constants.TXT_ADD_ACC_OPTION_TEXT,
                  ),
                  padding: const EdgeInsets.only(
                      left: AppDimens.dimens_10, right: AppDimens.dimens_10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
