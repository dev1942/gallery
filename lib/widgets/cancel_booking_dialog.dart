import 'package:flutter/material.dart';
import 'package:otobucks/global/constants.dart';

import '../global/app_colors.dart';
import '../global/app_dimens.dart';
import '../global/app_style.dart';
import '../global/enum.dart';
import '../global/global.dart';
import '../widgets/custom_button.dart';
import 'custom_textfield_multiline.dart';

class CancelBookingDialogBox extends StatefulWidget {
  final Function onTap;
  final bool isDecline;

  const CancelBookingDialogBox(
      {Key? key, required this.onTap, this.isDecline = false})
      : super(key: key);

  @override
  _CancelBookingDialogBoxState createState() => _CancelBookingDialogBoxState();
}

class _CancelBookingDialogBoxState extends State<CancelBookingDialogBox> {
  TextEditingController controllerComments = TextEditingController();

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
                bottom: AppDimens.dimens_5,
                right: AppDimens.dimens_15),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    widget.isDecline
                        ? Constants.TXT_DECLINE
                        : Constants.TXT_CANCEL_BOOKING,
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
          Container(
            height: AppDimens.dimens_1,
            margin: const EdgeInsets.only(
                top: AppDimens.dimens_14, bottom: AppDimens.dimens_10),
            color: AppColors.greyOTPBg.withOpacity(0.6),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(
                left: AppDimens.dimens_15,
                bottom: AppDimens.dimens_5,
                right: AppDimens.dimens_15),
            child: Text(
              widget.isDecline
                  ? Constants.TXT_CANCEL_ESTIMATION_REASON
                  : Constants.TXT_CANCEL_BOOKING_REASON,
              style: AppStyle.textViewStyleLarge(
                  context: context,
                  color: AppColors.colorBlack,
                  fontWeightDelta: -3,
                  fontSizeDelta: -1),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: AppDimens.dimens_22,
          ),
          Container(
            margin: const EdgeInsets.only(
                left: AppDimens.dimens_15, right: AppDimens.dimens_15),
            child: CustomTextFieldMultiLine(
              controller: controllerComments,
              keyboardType: TextInputType.text,
              hintText: Constants.TXT_ENTER_REASON,
              inputFormatters: const [],
              obscureText: false,
              onChanged: (String value) {},
              maxLines: 4,
              maxLength: 1000,
              minLines: 3,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            child: CustomButton(
              width: AppDimens.dimens_200,
              height: AppDimens.dimens_40,
              onPressed: () {
                if (isValid()) {
                  String strComments = controllerComments.text.toString();
                  widget.onTap(strComments);
                  Navigator.of(context).pop(true);
                }
              },
              isGradient: true,
              fontColor: AppColors.colorWhite,
              strTitle: Constants.TXT_SUBMIT,
            ),
            padding: const EdgeInsets.only(
                left: AppDimens.dimens_10, right: AppDimens.dimens_10),
          ),
        ],
      ),
    );
  }

  isValid() {
    String strFirstName = controllerComments.text.toString();

    if (!Global.checkNull(strFirstName)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_FN,
          toastType: TOAST_TYPE.toastError);

      return false;
    }
    return true;
  }
}
