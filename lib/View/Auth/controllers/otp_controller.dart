import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/Profile/View/my_profile_view.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/View/Auth/Models/model_otp.dart';
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
      Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_ENTER_OTP, toastType: TOAST_TYPE.toastError);
      return false;
    } else if (strOTP.length != 6) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_ENTER_VALID_OTP, toastType: TOAST_TYPE.toastError);
      return false;
    }
    return true;
  }

//---------------For Email
  sendOTPTask(String strEmailID, BuildContext context) async {
    isShowLoader = true;
    update();
    HashMap<String, Object> requestParams = HashMap();
    requestParams[PARAMS.PARAM_EMAIL] = strEmailID;
    var signInEmail = await OTPRepo().sentOTPToEmail(requestParams);

    signInEmail.fold((failure) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
      isShowLoader = false;
      update();
    }, (mResult) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: mResult.responseMessage, toastType: TOAST_TYPE.toastSuccess);
      isShowLoader = false;
      update();
    });
  }

//--------------------------verify Email--------------
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
      Global.showToastAlert(context: context, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
    }, (mResult) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: mResult.responseMessage, toastType: TOAST_TYPE.toastSuccess);
      loginUserTask(context, modelOTP);
    });
  }
//------------------------For Number-------------

  //----------------------Send Otp------Number------
  sendNumberOTPTask(String phoneNumber, BuildContext context) async {
    isShowLoader = true;
    update();
    HashMap<String, Object> requestParams = HashMap();

    requestParams[PARAMS.PARAM_PHONE] = phoneNumber;

    var signInEmail = await OTPRepo().sentOTPToNumber(requestParams);

    signInEmail.fold((failure) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
      isShowLoader = false;
      update();
    }, (mResult) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: mResult.responseMessage, toastType: TOAST_TYPE.toastSuccess);
      isShowLoader = false;
      update();
    });
  }

//--------------------number otp verify ----------------------------
  verifyNumberOTPTask(BuildContext context, String? phoneNumber) async {
    if (!isValid(context)) {
      return;
    }
    isShowLoader = true;
    update();
    String strOTP = mControllerOTP.text.toString();
    String strPhoneNumber = phoneNumber!; //modelOTP.emailId;
    HashMap<String, Object> requestParams = HashMap();
    requestParams[PARAMS.PARAM_PHONE] = strPhoneNumber;
    var signInEmail = await OTPRepo().verifyNumberOTP(requestParams, strOTP);
    isShowLoader = false;
    update();

    signInEmail.fold((failure) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
    }, (mResult) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: mResult.responseMessage, toastType: TOAST_TYPE.toastSuccess);
      log("Navigator pop context--- otp verify-------");
      // Navigator.Pu
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyProfileFragment()));
      //Navigator.pushReplacementNamed(context, Constants.ACT_HOME);
      //  loginUserTask(context, modelOTP);
    });
  }

  //---------------------Number otp verify  end---------------------
  loginUserTask(BuildContext context, ModelOTP modelOTP) async {
    isShowLoader = true;
    update();
    String? fcmToken = await Global.taskGetToken();
    String strEmailID = modelOTP.emailId;
    String strPassword = modelOTP.password;
    HashMap<String, Object> requestParams = HashMap();
    requestParams[PARAMS.PARAM_EMAIL] = strEmailID;
    requestParams[PARAMS.PARAM_PASSWORD] = strPassword;
    requestParams[PARAMS.PARAM_FIREBASE_TOKEN] = fcmToken != null && Global.checkNull(fcmToken) ? fcmToken : "";

    var signInEmail = await LoginRepo().login(requestParams);

    isShowLoader = false;
    update();
    signInEmail.fold((failure) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
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
