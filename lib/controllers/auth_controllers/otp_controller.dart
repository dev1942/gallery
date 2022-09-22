import 'dart:collection';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/model/model_otp.dart';
import 'package:otobucks/services/repository/login_repo.dart';
import 'package:otobucks/services/repository/otp_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpController extends GetxController {
  bool isShowLoader = false;
  bool connectionStatus = false;
  bool obscureTextM = true;
  String strVersionName = "";

  TextEditingController mControllerOTP = TextEditingController();

  isValid(BuildContext context) {
    String strOTP = mControllerOTP.text.toString();
    log(strOTP);

    if (!Global.checkNull(strOTP)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_OTP,
          toastType: TOAST_TYPE.toastError);
      return false;
    } else if (strOTP.length != 6) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_VALID_OTP,
          toastType: TOAST_TYPE.toastError);
      return false;
    }
    return true;
  }

  sendOTPTask(String strEmailID, BuildContext context) async {
    isShowLoader = true;
    update();
    HashMap<String, Object> requestParams = HashMap();

    requestParams[PARAMS.PARAM_EMAIL] = strEmailID;

    var signInEmail = await OTPRepo().sentOTPToEmail(requestParams);

    signInEmail.fold((failure) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
      isShowLoader = false;
      update();
    }, (mResult) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: mResult.responseMessage,
          toastType: TOAST_TYPE.toastSuccess);
      isShowLoader = false;
      update();
    });
  }

  verifyOTPTask(BuildContext context, ModelOTP modelOTP) async {
    if (!isValid(context)) {
      return;
    }
    isShowLoader = true;
    update();
    String strOTP = mControllerOTP.text.toString();
    String strEmailID = modelOTP.emailId;
    HashMap<String, Object> requestParams = HashMap();

    requestParams[PARAMS.PARAM_EMAIL] = strEmailID;

    var signInEmail = await OTPRepo().verifyOTP(requestParams, strOTP);
    isShowLoader = false;
    update();

    signInEmail.fold((failure) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
    }, (mResult) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: mResult.responseMessage,
          toastType: TOAST_TYPE.toastSuccess);
      loginUserTask(context, modelOTP);
    });
  }

  loginUserTask(BuildContext context, ModelOTP modelOTP) async {
    isShowLoader = true;
    update();
    String? fcmToken = await Global.taskGetToken();
    String strEmailID = modelOTP.emailId;
    String strPassword = modelOTP.password;
    HashMap<String, Object> requestParams = HashMap();

    requestParams[PARAMS.PARAM_EMAIL] = strEmailID;
    requestParams[PARAMS.PARAM_PASSWORD] = strPassword;
    requestParams[PARAMS.PARAM_FIREBASE_TOKEN] =
        fcmToken != null && Global.checkNull(fcmToken) ? fcmToken : "";

    var signInEmail = await LoginRepo().login(requestParams);

    isShowLoader = false;
    update();
    signInEmail.fold((failure) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
    }, (mResult) {
      navigateToHomePage(context);
    });
  }

  void navigateToHomePage(BuildContext context) async {
    final prefManager = await SharedPreferences.getInstance();
    prefManager.setBool(SharedPrefKey.KEY_IS_LOGIN, true);
    Navigator.pushReplacementNamed(context, Constants.ACT_HOME);
  }
}
