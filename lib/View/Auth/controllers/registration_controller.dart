import 'dart:collection';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/View/Auth/Models/country_code.dart';
import 'package:otobucks/View/Auth/Models/model_otp.dart';
import 'package:otobucks/services/repository/otp_repo.dart';
import 'package:otobucks/services/repository/registration_repo.dart';

import '../View/login_in_screen.dart';
import '../View/otp_screen.dart';

class RegistrationScreenController extends GetxController {
  bool isShowLoader = false;
  bool connectionStatus = false;
  bool obscureTextM = true;
  String strVersionName = "";

  late TextEditingController controllerFirstName;
  late TextEditingController controllerLastName;
  late TextEditingController controllerCountry;
  late TextEditingController controllerEmail;
  late TextEditingController controllerPhone;
  late TextEditingController controllerHowAboutUs;
  late TextEditingController controllerInviteCode;
  late TextEditingController controllerPassword;

  FocusNode mFocusNodeFirstName = FocusNode();
  FocusNode mFocusNodeEmail = FocusNode();
  FocusNode mFocusNodePassword = FocusNode();
  FocusNode mFocusNodeLastName = FocusNode();
  FocusNode mFocusNodeCountry = FocusNode();
  FocusNode mFocusNodeHowAboutUs = FocusNode();
  FocusNode mFocusNodePhone = FocusNode();
  FocusNode mFocusNodeInviteCode = FocusNode();

  String strCountyCode = "+971";

  String strCountyFlag = "ae";

  void changeLocale(String locale) {
    switch (locale) {
      case 'English':
        Get.updateLocale(const Locale('en', 'UE'));
        break;
      case 'Arabic':
        Get.updateLocale(const Locale('ar', 'AE'));
        break;
      default:
        Get.updateLocale(const Locale('ar', 'AE'));
    }
  }

  setUpInviteCode(String code) {
    if (code != '') {
      controllerInviteCode.text = code;
      controllerHowAboutUs.text = 'Other';
      update();
    }
  }

  isValidSignup(BuildContext context) {
    String strFirstName = controllerFirstName.text.toString();
    String strLastName = controllerLastName.text.toString();
    String strEmail = controllerEmail.text.toString().trim();
    String strCountry = controllerCountry.text.toString();
    String strPhone = controllerPhone.text.toString();
    String strPassword = controllerPassword.text.toString();

    if (!Global.checkNull(strFirstName)) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_ENTER_FN.tr, toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeFirstName);
      return false;
    } else if (!Global.checkNull(strLastName)) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_ENTER_LN.tr, toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeLastName);
      return false;
    } else if (!Global.checkNull(strEmail)) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_ENTER_EMAIL.tr, toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeEmail);
      return false;
    } else if (Global.checkNull(strEmail) && !Global.checkValidEmail(strEmail)) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_ENTER_VALID_EMAIL.tr, toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeEmail);
      return false;
    } else if (!Global.checkNull(strCountry)) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_SELECT_COUNTRY.tr, toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeCountry);
      return false;
    }
    // else if (!Global.checkNull(strPhone)) {
    //   Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_ENTER_NUMBER.tr, toastType: TOAST_TYPE.toastError);
    //   FocusScope.of(context).requestFocus(mFocusNodePhone);
    //   return false;
    // }
    // else if (Global.checkNull(strPhone) && !Global.checkValidMobile(strPhone)) {
    //   Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_ENTER_VALID_NUMBER.tr, toastType: TOAST_TYPE.toastError);
    //   FocusScope.of(context).requestFocus(mFocusNodePhone);
    //   return false;
    // }
    else if (!Global.checkNull(strPassword)) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_ENTER_PASSWORD.tr, toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodePassword);
      return false;
    } else if (strPassword.length < 8) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_PASSWORD_LESS.tr, toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodePassword);
      return false;
    }
    return true;
  }

  registerUserTask(BuildContext context) async {
    if (!isValidSignup(context)) return;
    isShowLoader = true;
    update();

    String strMobileEmail = controllerEmail.text.toString().trim();
    String strMobileNumber = controllerPhone.text.toString().trim();
    String strPassword = controllerPassword.text.toString();
    String strCountry = controllerCountry.text.toString().trim();
    String strFirst = controllerFirstName.text.toString().trim();
    String strLastName = controllerLastName.text.toString().trim();
    String strInviteCode = controllerInviteCode.text.toString();
    String strHowHear = controllerHowAboutUs.text.toString();
    String firebaseToken = await FirebaseMessaging.instance.getToken() ?? '';
    await Global.taskStoreToken(firebaseToken);
    log("p" + strMobileNumber);

    HashMap<String, Object> requestParams = HashMap();
    requestParams[PARAMS.PARAM_PASSWORD] = strPassword;
    requestParams[PARAMS.PARAM_FIRSTNAME] = strFirst;
    requestParams[PARAMS.PARAM_LASTNAME] = strLastName;
    requestParams[PARAMS.PARAM_EMAIL] = strMobileEmail;
    requestParams[PARAMS.PARAM_COUNTRY] = strCountry;
    requestParams[PARAMS.PARAM_PHONE] = strMobileNumber.isEmpty ? "100000000" : strMobileNumber;
    requestParams[PARAMS.PARAM_PASSWORD] = strPassword;
    requestParams[PARAMS.PARAM_PASSWORD_CONFIRM] = strPassword;
    requestParams[PARAMS.PARAM_HEAREDABOUTUS] = strHowHear;
    requestParams[PARAMS.PARAM_INVITE] = strInviteCode;
    requestParams[PARAMS.PARAM_COUNTRY_CODE] = strCountyCode;
    requestParams[PARAMS.PARAM_COUNTRY_FLAG_CODE] = strCountyFlag;
    requestParams[PARAMS.PARAM_FIREBASE_TOKEN] = firebaseToken;

    var signInEmail = await RegistrationRepo().registration(requestParams);
    isShowLoader = false;
    update();
    signInEmail.fold((failure) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
    }, (mResult) {
      gotoMobileOTPScreen(context);
    });
  }

  void gotoMobileOTPScreen(BuildContext context) async {
    ModelOTP mModelOTP = ModelOTP(password: controllerPassword.text.toString(), emailId: controllerEmail.text.toString());

    Navigator.push(context, MaterialPageRoute(builder: (context) => OTPScreen(mModelOTP: mModelOTP)));
    sendOTPTask(mModelOTP.emailId, context);
  }

  sendOTPTask(String strEmailID, BuildContext context) async {
    HashMap<String, Object> requestParams = HashMap();

    requestParams[PARAMS.PARAM_EMAIL] = strEmailID;

    var signInEmail = await OTPRepo().sentOTPToEmail(requestParams);

    signInEmail.fold((failure) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
    }, (mResult) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: mResult.responseMessage, toastType: TOAST_TYPE.toastSuccess);
    });
  }

  void pushRegisterScreen1(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));
  }

  updateCountryCode(CountryCode mCountryCode) {
    controllerCountry.text = mCountryCode.name;
    strCountyFlag = mCountryCode.code.toLowerCase();
    update();
  }

  updateKnowAboutUs(String value) {
    controllerHowAboutUs.text = value;
    update();
  }

  onIniteScreen() {
    controllerFirstName = TextEditingController();
    controllerLastName = TextEditingController();
    controllerCountry = TextEditingController();
    controllerEmail = TextEditingController();
    controllerPhone = TextEditingController();
    controllerHowAboutUs = TextEditingController();
    controllerInviteCode = TextEditingController();
    controllerPassword = TextEditingController();
  }

  onDisposeScreen() {
    controllerFirstName.dispose();
    controllerLastName.dispose();
    controllerEmail.dispose();
    controllerCountry.dispose();
    controllerPhone.dispose();
    controllerHowAboutUs.dispose();
    controllerPassword.dispose();
    controllerInviteCode.dispose();
    connectionStatus = false;
    isShowLoader = false;
    obscureTextM = false;
    strVersionName = "";
  }
}
