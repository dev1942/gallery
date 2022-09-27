import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/services/repository/login_repo.dart';

class ForgotPasswordController extends GetxController {
  String strVersionName = "";
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController reEnterNewPassword = TextEditingController();
  TextEditingController code = TextEditingController();
  FocusNode mFocusNodePhone = FocusNode();
  FocusNode mFocusNodeNewPass = FocusNode();
  FocusNode mFocusNodeReEnterPass = FocusNode();
  FocusNode mFocusNodeCode = FocusNode();
  FocusNode mFocusNodeEmail = FocusNode();
  bool isShowLoader = false;
  String strCountyCode = "+971";
  bool connectionStatus = true;

  PageController pageController = PageController(
    initialPage: 0,
  );
  isValid(BuildContext context) {
    String strEmail = controllerEmail.text.toString();
    String strPhone = controllerPhone.text.toString();

    if (!Global.checkNull(strEmail) && !Global.checkNull(strPhone)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_EMAIL_OR_PHONE,
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeEmail);
      return false;
    }
    bool isMobile = false;

    if (strPhone.isNotEmpty) {
      isMobile = true;
    } else if (strEmail.isNotEmpty) {
      isMobile = false;
    }

    if (!isMobile && !Global.checkNull(strEmail)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_EMAIL,
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeEmail);
      return false;
    } else if (!isMobile &&
        Global.checkNull(strEmail) &&
        !Global.checkValidEmail(strEmail)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_VALID_EMAIL,
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeEmail);
      return false;
    } else if (isMobile && !Global.checkNull(strPhone)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_NUMBER,
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodePhone);
      return false;
    } else if (isMobile &&
        Global.checkNull(strPhone) &&
        !Global.checkValidMobile(strPhone)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_VALID_NUMBER,
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodePhone);
      return false;
    }
    return true;
  }

  isValidReset(BuildContext context) {
    String password = newPassword.text.toString();
    String againPassword = reEnterNewPassword.text.toString();

    if (password.isEmpty || againPassword.isEmpty) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_PASSWORD,
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeEmail);
      return false;
    }
    if (password.length < 8) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_PASSWORD_LESS,
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeEmail);
      return false;
    }
    if (password != againPassword) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_PASSWORD_NOT_MATCH,
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeEmail);
      return false;
    }
    if (!Global.checkNull(code.text)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_CODE,
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeCode);
      return false;
    }
    if (!Global.checkNull(code.text)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_CODE,
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeCode);
      return false;
    }
    return true;
  }

  loginUserTaskForget(BuildContext context) async {
    if (!isValid(context)) {
      return;
    }
    isShowLoader = true;
    update();
    String strEmailID = controllerEmail.text.toString().trim();
    String strPhone = controllerPhone.text.toString().trim();
    HashMap<String, Object> requestParams = HashMap();

    requestParams[PARAMS.PARAM_DATA] =
        Global.checkNull(strEmailID) ? strEmailID : strCountyCode + strPhone;

    var signInEmail = await LoginRepo().forgotPassword(requestParams);
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
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    });
  }

  resetPassword(BuildContext context) async {
    if (!isValidReset(context)) {
      return;
    }
    isShowLoader = true;
    update();
    HashMap<String, Object> requestParams = HashMap();
    requestParams[PARAMS.PARAM_PASSWORD] = newPassword.text;
    requestParams[PARAMS.PARAM_PASSWORD_CONFIRM] = reEnterNewPassword.text;

    var signInEmail = await LoginRepo().resetPassword(requestParams, code.text);
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
      navigateToLogin(context);
    });
  }

  void navigateToLogin(BuildContext context) async {
    Navigator.pushReplacementNamed(context, Constants.ACT_LOGIN);
  }

  @override
  void onInit() {
    controllerEmail.clear();
    controllerPhone.clear();
    newPassword.clear();
    reEnterNewPassword.clear();
    code.clear();
    super.onInit();
  }
}
