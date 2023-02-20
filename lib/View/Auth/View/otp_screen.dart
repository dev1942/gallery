import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/Auth/controllers/otp_controller.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_images.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/View/Auth/Models/model_otp.dart';
import 'package:otobucks/widgets/custom_button.dart';

import '../../../widgets/custom_ui/otp/src/otp_pin_field_input_type.dart';
import '../../../widgets/custom_ui/otp/src/otp_pin_field_style.dart';
import '../../../widgets/custom_ui/otp/src/otp_pin_field_widget.dart';

class OTPScreen extends StatefulWidget {
  final ModelOTP? mModelOTP;
  final String? phoneNumber;
  const OTPScreen({Key? key, this.mModelOTP, this.phoneNumber}) : super(key: key);
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  var controller = Get.put(OtpController());
  @override
  void initState() {
    controller.mControllerOTP.clear();
    startTimer();
    super.initState();
  }

  Timer? _timer;
  int _start = 30;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double otpwidth = size.width / 9;
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.colorWhite,
            body: Stack(
              children: [
                Container(
                  decoration: AppViews.getGradientBoxDecoration(),
                ),
                Container(
                    padding: const EdgeInsets.only(top: AppDimens.dimens_10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                left: AppDimens.dimens_10, top: size.height / 8, bottom: size.height / 20, right: AppDimens.dimens_10),
                            child: Text(
                              Constants.TXT_ONE_TIME_PASSWORD.tr,
                              style: AppStyle.textViewStyleXXXLarge(
                                  context: context, color: AppColors.colorWhite, fontSizeDelta: -3, fontWeightDelta: 2),
                            )),
                        Expanded(
                            child: Container(
                          width: size.width,
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppDimens.dimens_16),
                              topRight: Radius.circular(AppDimens.dimens_16),
                              bottomLeft: Radius.zero,
                              bottomRight: Radius.zero,
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: AppDimens.dimens_30),
                                child: Image.asset(
                                  AppImages.ic_otp_icon,
                                  width: AppDimens.dimens_50,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: AppDimens.dimens_40),
                                child: Text(
                                  Constants.TXT_ENT_CODE_MSG.tr,
                                  textAlign: TextAlign.center,
                                  style: AppStyle.textViewStyleSmall(
                                      context: context, color: AppColors.colorTextFieldHint.withOpacity(0.6), fontSizeDelta: 0, fontWeightDelta: -1),
                                ),
                              ),
                              Text(
                                widget.mModelOTP?.emailId ?? widget.phoneNumber ?? "", // "test@yopamil.com",
                                textAlign: TextAlign.center,
                                style:
                                    AppStyle.textViewStyleSmall(context: context, color: AppColors.colorBlack, fontSizeDelta: 0, fontWeightDelta: 2),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: AppDimens.dimens_40),
                                child: OtpPinField(
                                  otpPinFieldInputType: OtpPinFieldInputType.none,
                                  onSubmit: (text) {
                                    log(text);
                                    controller.mControllerOTP.text = text;
                                  },
                                  otpPinFieldStyle: OtpPinFieldStyle(
                                    defaultFieldBorderColor: AppColors.greyOTPBg,
                                    activeFieldBorderColor: AppColors.lightGrey,
                                    defaultFieldBackgroundColor: AppColors.greyOTPBg,
                                    activeFieldBackgroundColor: AppColors.lightGrey, // Background Color for active/focused Otp_Pin_Field
                                  ),
                                  maxLength: 6,
                                  highlightBorder: false,
                                  fieldWidth: otpwidth,
                                  fieldHeight: otpwidth,
                                  keyboardType: TextInputType.number,
                                  autoFocus: false,
                                  otpPinFieldDecoration: OtpPinFieldDecoration.defaultPinBoxDecoration,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: AppDimens.dimens_40, bottom: 20),
                                child: CustomButton(
                                    isGradient: true,
                                    isRoundBorder: true,
                                    fontColor: AppColors.colorWhite,
                                    width: size.width / 1.5,
                                    onPressed: () {
                                      if (widget.mModelOTP != null) {
                                        controller.verifyOTPTask(context, widget.mModelOTP!);
                                      } else {
                                        //phone number verification
                                        // verifyNumberOTPTask
                                        controller.verifyNumberOTPTask(context, widget.phoneNumber);
                                      }
                                    },
                                    strTitle: Constants.TXT_SUBMIT.tr),
                              ),
                              _start != 0
                                  ? Text("$_start")
                                  : TextButton(
                                      onPressed: () {
                                        if (widget.mModelOTP != null) {
                                          controller.sendOTPTask(widget.mModelOTP!.emailId, context);
                                        } else {
                                          //phone number verification
                                          controller.sendNumberOTPTask(widget.phoneNumber!, context);
                                        }
                                      },
                                      child: Text('Resend'.tr))
                            ],
                          ),
                        )),
                      ],
                    )),
                GetBuilder<OtpController>(
                    init: controller,
                    builder: (value) {
                      return AppViews.showLoadingWithStatus(controller.isShowLoader);
                    })
              ],
            )));
  }
}
