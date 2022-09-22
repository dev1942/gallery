import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';

import '../../custom_ui/otp/src/otp_pin_field_input_type.dart';
import '../../custom_ui/otp/src/otp_pin_field_style.dart';
import '../../custom_ui/otp/src/otp_pin_field_widget.dart';
import '../../global/app_colors.dart';
import '../../global/app_dimens.dart';
import '../../global/app_style.dart';
import '../../global/global.dart';
import '../custom_button.dart';

class WithdrawMoneyDialogBox extends StatefulWidget {
  final String title;
  final Function onTap;

  const WithdrawMoneyDialogBox(
      {Key? key, required this.onTap, required this.title})
      : super(key: key);

  @override
  _WithdrawMoneyDialogBoxState createState() => _WithdrawMoneyDialogBoxState();
}

class _WithdrawMoneyDialogBoxState extends State<WithdrawMoneyDialogBox> {
  bool is2ndPage = false;

  TextEditingController mControllerOTP = TextEditingController();

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
    var size = MediaQuery.of(context).size;
    double otpwidth = size.width / 11;
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
                    widget.title,
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
            margin: const EdgeInsets.all(AppDimens.dimens_10),
            child: Column(
              children: [
                Visibility(
                    visible: !is2ndPage,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(Constants.TXT_VERIFY,
                              style: AppStyle.textViewStyleSmall(
                                  context: context,
                                  fontSizeDelta: 1,
                                  fontWeightDelta: 1,
                                  color: AppColors.colorBlack)),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(Constants.TXT_VERIFY_MSG,
                              style: AppStyle.textViewStyleSmall(
                                  context: context,
                                  fontSizeDelta: -1,
                                  fontWeightDelta: 0,
                                  color: AppColors.colorBlack)),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin:
                              const EdgeInsets.only(top: AppDimens.dimens_15),
                          child: Text(
                              Constants.TXT_VERIFY_MSG_3 + "+917 124567890",
                              textAlign: TextAlign.center,
                              style: AppStyle.textViewStyleSmall(
                                  context: context,
                                  fontSizeDelta: -3,
                                  fontWeightDelta: 0,
                                  color: AppColors.colorTextFieldHint)),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: AppDimens.dimens_13,
                              bottom: AppDimens.dimens_10),
                          child: OtpPinField(
                            otpPinFieldInputType: OtpPinFieldInputType.none,
                            // OtpPinFieldInputType.none || OtpPinFieldInputType.password || OtpPinFieldInputType.custom
                            // otpPinInputCustom: "\$",  // A String which you want to show when you use 'inputType: OtpPinFieldInputType.custom, '
                            onSubmit: (text) {
                              mControllerOTP.text = text;
                              log('Entered pin is $text'); // return the entered pin
                            },

                            // to decorate your Otp_Pin_Field
                            otpPinFieldStyle: OtpPinFieldStyle(
                              defaultFieldBorderColor: AppColors.greyOTPBg,
                              // border color for inactive/unfocused Otp_Pin_Field
                              activeFieldBorderColor: AppColors.lightGrey,
                              // border color for active/focused Otp_Pin_Field
                              defaultFieldBackgroundColor: AppColors.greyOTPBg,
                              // Background Color for inactive/unfocused Otp_Pin_Field
                              activeFieldBackgroundColor: AppColors
                                  .lightGrey, // Background Color for active/focused Otp_Pin_Field
                            ),
                            maxLength: 6,
                            // no of pin field
                            highlightBorder: false,
                            // want to highlight focused/active Otp_Pin_Field
                            fieldWidth: otpwidth,
                            //to give width to your Otp_Pin_Field
                            fieldHeight: otpwidth,
                            //to give height to your Otp_Pin_Field
                            keyboardType: TextInputType.number,
                            // type of keyboard you want
                            autoFocus: false,
                            //want to open keyboard or not

                            // predefine decorate of pinField use  OtpPinFieldDecoration.defaultPinBoxDecoration||OtpPinFieldDecoration.underlinedPinBoxDecoration||OtpPinFieldDecoration.roundedPinBoxDecoration
                            //use OtpPinFieldDecoration.custom  (by using this you can make Otp_Pin_Field according to yourself like you can give fieldBorderRadius,fieldBorderWidth and etc things)
                            otpPinFieldDecoration:
                                OtpPinFieldDecoration.defaultPinBoxDecoration,
                          ),
                        ),
                      ],
                    )),
                Visibility(
                    visible: is2ndPage,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(Constants.TXT_WITHDRAW_MONEY,
                              style: AppStyle.textViewStyleSmall(
                                  context: context,
                                  fontSizeDelta: 1,
                                  fontWeightDelta: 1,
                                  color: AppColors.colorBlack)),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(Constants.TXT_VERIFY_DETAILS,
                              style: AppStyle.textViewStyleSmall(
                                  context: context,
                                  fontSizeDelta: -1,
                                  fontWeightDelta: 0,
                                  color: AppColors.colorBlack)),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin:
                              const EdgeInsets.only(top: AppDimens.dimens_20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(Constants.TXT_TRANSFER_TO,
                                  textAlign: TextAlign.center,
                                  style: AppStyle.textViewStyleSmall(
                                      context: context,
                                      fontSizeDelta: 1,
                                      fontWeightDelta: 1,
                                      color: AppColors.colorBlack)),
                              Text("•••• •••• •••• 3282",
                                  textAlign: TextAlign.center,
                                  style: AppStyle.textViewStyleSmall(
                                      context: context,
                                      fontSizeDelta: 1,
                                      fontWeightDelta: 1,
                                      color: AppColors.colorTextFieldHint))
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(
                              top: AppDimens.dimens_10,
                              bottom: AppDimens.dimens_15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(Constants.TXT_AMOUNT,
                                  textAlign: TextAlign.center,
                                  style: AppStyle.textViewStyleSmall(
                                      context: context,
                                      fontSizeDelta: 1,
                                      fontWeightDelta: 1,
                                      color: AppColors.colorBlack)),
                              Text(Global.replaceCurrencySign("USD") + "100",
                                  textAlign: TextAlign.center,
                                  style: AppStyle.textViewStyleSmall(
                                      context: context,
                                      fontSizeDelta: 1,
                                      fontWeightDelta: 1,
                                      color: AppColors.colorTextFieldHint))
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          Container(
            child: CustomButton(
              width: AppDimens.dimens_170,
              height: AppDimens.dimens_30,
              onPressed: () {
                if (!is2ndPage) {
                  is2ndPage = true;
                }
                setState(() {});
                // if (isValid()) {
                //  // Navigator.of(context).pop(true);
                // }
              },
              isGradient: true,
              fontSize: -1,
              fontColor: AppColors.colorWhite,
              strTitle: !is2ndPage
                  ? Constants.TXT_SUBMIT
                  : Constants.TXT_CONFIRM_WITHDRAW,
            ),
            padding: const EdgeInsets.only(
                left: AppDimens.dimens_10, right: AppDimens.dimens_10),
          ),
        ],
      ),
    );
  }

  isValid() {
    return true;
  }
}
