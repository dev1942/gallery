import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:otobucks/View/Auth/View/registation_screen.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/View/Auth/Models/model_otp.dart';

import 'package:otobucks/services/navigation_service.dart' as my_nav_service;
import 'package:otobucks/services/repository/login_repo.dart';
import 'package:otobucks/services/repository/registration_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../../View/Auth/View/forgot_password_screen.dart';
import '../../View/Auth/View/login_in_screen.dart';
import '../../View/Auth/View/otp_screen.dart';

class MainViewModel extends BaseViewModel {
  var navigationService = my_nav_service.NavigationService();

  late SharedPreferences prefs;
  var dio = Dio();

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------//

//########################################################################### Login Screen #######################################################################################//
/////////////////////////////////////////////////////////////////////////    Start    /////////////////////////////////////////////////////////////////////////////////////

  bool connectionStatus = false;
  bool isShowLoader = false;
  bool obscureTextM = false;

  String strVersionName = "";
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  FocusNode mFocusNodeEmail = FocusNode();
  FocusNode mFocusNodePassword = FocusNode();

  final List<String> items = ['English', 'Arabic'];
  String selectedValue = "English";

  isValid(BuildContext context) {
    String strEmail = controllerEmail.text.toString();
    String strPassword = controllerPassword.text.toString();

    if (!Global.checkNull(strEmail)) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_ENTER_EMAIL, toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeEmail);
      return false;
    } else if (Global.checkNull(strEmail) && !Global.checkValidEmail(strEmail)) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_ENTER_VALID_EMAIL, toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeEmail);
      return false;
    } else if (!Global.checkNull(strPassword)) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_ENTER_PASSWORD, toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodePassword);
      return false;
    }
    return true;
  }

  loginUserTask(BuildContext context) async {
    isShowLoader = true;
    notifyListeners();
    String? fcmToken = await Global.taskGetToken();
    String strEmailID = controllerEmail.text.toString();
    String strPassword = controllerPassword.text.toString();
    HashMap<String, Object> requestParams = HashMap();

    requestParams[PARAMS.PARAM_EMAIL] = strEmailID;
    requestParams[PARAMS.PARAM_PASSWORD] = strPassword;
    requestParams[PARAMS.PARAM_FIREBASE_TOKEN] = fcmToken != null && Global.checkNull(fcmToken) ? fcmToken : "";

    var signInEmail = await LoginRepo().login(requestParams);

    isShowLoader = false;
    notifyListeners();

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

  void pushRegisterScreen(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationScreen()));
  }

  void forgoPasswordScreen(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
  }

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------//

//########################################################################### Login Screen #######################################################################################//
/////////////////////////////////////////////////////////////////////////    End    /////////////////////////////////////////////////////////////////////////////////////

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------//

//########################################################################### Register Screen #######################################################################################//
/////////////////////////////////////////////////////////////////////////    Start    /////////////////////////////////////////////////////////////////////////////////////

  TextEditingController controllerFirstName = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();
  TextEditingController controllerCountry = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerHowAboutUs = TextEditingController();
  TextEditingController controllerInviteCode = TextEditingController();

  FocusNode mFocusNodeFirstName = FocusNode();
  FocusNode mFocusNodeLastName = FocusNode();
  FocusNode mFocusNodeCountry = FocusNode();
  FocusNode mFocusNodeHowAboutUs = FocusNode();
  FocusNode mFocusNodePhone = FocusNode();
  FocusNode mFocusNodeInviteCode = FocusNode();

  String strCountyCode = "+971";

  String strCountyFlag = "ae";

  isValidSignup(BuildContext context) {
    String strFirstName = controllerFirstName.text.toString();
    String strLastName = controllerLastName.text.toString();
    String strEmail = controllerEmail.text.toString();
    String strCountry = controllerCountry.text.toString();
    String strPhone = controllerPhone.text.toString();
    String strPassword = controllerPassword.text.toString();

    if (!Global.checkNull(strFirstName)) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_ENTER_FN, toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeFirstName);
      return false;
    } else if (!Global.checkNull(strLastName)) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_ENTER_LN, toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeLastName);
      return false;
    } else if (!Global.checkNull(strEmail)) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_ENTER_EMAIL, toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeEmail);
      return false;
    } else if (Global.checkNull(strEmail) && !Global.checkValidEmail(strEmail)) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_ENTER_VALID_EMAIL, toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeEmail);
      return false;
    } else if (!Global.checkNull(strCountry)) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_SELECT_COUNTRY, toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeCountry);
      return false;
    } else if (!Global.checkNull(strPhone)) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_ENTER_NUMBER, toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodePhone);
      return false;
    } else if (Global.checkNull(strPhone) && !Global.checkValidMobile(strPhone)) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_ENTER_VALID_NUMBER, toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodePhone);
      return false;
    } else if (!Global.checkNull(strPassword)) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_ENTER_PASSWORD, toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodePassword);
      return false;
    }
    return true;
  }

  registerUserTask(BuildContext context) async {
    isShowLoader = true;
    notifyListeners();
    String? fcmToken = await Global.taskGetToken();
    String strMobileEmail = controllerEmail.text.toString();
    String strMobileNumber = controllerPhone.text.toString();
    String strPassword = controllerPassword.text.toString();
    String strCountry = controllerCountry.text.toString();
    String strFirst = controllerFirstName.text.toString();
    String strLastName = controllerLastName.text.toString();
    String strInviteCode = controllerInviteCode.text.toString();
    String strHowHear = controllerHowAboutUs.text.toString();
    HashMap<String, Object> requestParams = HashMap();

    requestParams[PARAMS.PARAM_PASSWORD] = strPassword;
    requestParams[PARAMS.PARAM_FIRSTNAME] = strFirst;
    requestParams[PARAMS.PARAM_LASTNAME] = strLastName;
    requestParams[PARAMS.PARAM_EMAIL] = strMobileEmail;
    requestParams[PARAMS.PARAM_COUNTRY] = strCountry;
    requestParams[PARAMS.PARAM_PHONE] = strMobileNumber;
    requestParams[PARAMS.PARAM_PASSWORD] = strPassword;
    requestParams[PARAMS.PARAM_PASSWORD_CONFIRM] = strPassword;
    requestParams[PARAMS.PARAM_HEAREDABOUTUS] = strHowHear;
    requestParams[PARAMS.PARAM_INVITE] = strInviteCode;
    requestParams[PARAMS.PARAM_COUNTRY_CODE] = strCountyCode;
    requestParams[PARAMS.PARAM_FIREBASE_TOKEN] = fcmToken != null && Global.checkNull(fcmToken) ? fcmToken : "test";

    var signInEmail = await RegistrationRepo().registration(requestParams);
    isShowLoader = false;
    notifyListeners();
    signInEmail.fold((failure) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
    }, (mResult) {
      gotoMobileOTPScreen(context);
    });
  }

  void gotoMobileOTPScreen(BuildContext context) async {
    String strEmail = controllerEmail.text.toString();
    String strPassword = controllerPassword.text.toString();
    ModelOTP mModelOTP = ModelOTP(password: strPassword, emailId: strEmail);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OTPScreen(
                  mModelOTP: mModelOTP,
                  isFromRegistration: true,
                  phoneNumber: controllerPhone.text,
                )));
  }

  void pushRegisterScreen1(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));
  }

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------//

//########################################################################### Register Screen #######################################################################################//
/////////////////////////////////////////////////////////////////////////    End   /////////////////////////////////////////////////////////////////////////////////////

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------//

//########################################################################### Forget Screen #######################################################################################//
/////////////////////////////////////////////////////////////////////////    Start   /////////////////////////////////////////////////////////////////////////////////////

  isValidForget(BuildContext context) {
    String strEmail = controllerEmail.text.toString();
    String strPhone = controllerPhone.text.toString();

    bool isMobile = false;

    if (strPhone.isNotEmpty) {
      isMobile = true;
    } else if (strEmail.isNotEmpty) {
      isMobile = false;
    }

    if (!isMobile && !Global.checkNull(strEmail)) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_ENTER_EMAIL, toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeEmail);
      return false;
    } else if (!isMobile && Global.checkNull(strEmail) && !Global.checkValidEmail(strEmail)) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_ENTER_VALID_EMAIL, toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeEmail);
      return false;
    } else if (isMobile && !Global.checkNull(strPhone)) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_ENTER_NUMBER, toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodePhone);
      return false;
    } else if (isMobile && Global.checkNull(strPhone) && !Global.checkValidMobile(strPhone)) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_ENTER_VALID_NUMBER, toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodePhone);
      return false;
    }
    return true;
  }

  loginUserTaskForget(BuildContext context) async {
    isShowLoader = true;
    notifyListeners();
    String strEmailID = controllerEmail.text.toString();
    String strPhone = controllerPhone.text.toString();
    HashMap<String, Object> requestParams = HashMap();

    requestParams[PARAMS.PARAM_DATA] = Global.checkNull(strEmailID) ? strEmailID : strCountyCode + strPhone;

    var signInEmail = await LoginRepo().forgotPassword(requestParams);
    isShowLoader = false;
    notifyListeners();
    signInEmail.fold((failure) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
    }, (mResult) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: mResult.responseMessage, toastType: TOAST_TYPE.toastSuccess);
      navigateToLogin(context);
    });
  }

  void navigateToLogin(BuildContext context) async {
    Navigator.pushReplacementNamed(context, Constants.ACT_LOGIN);
  }

  // void navigateToVeryfyOTP(BuildContext context) async {
  //   Navigator.pushReplacementNamed(context, Constants.ACT_LOGIN);
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => Otp()));
  // }

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------//

//########################################################################### Forget Screen #######################################################################################//
/////////////////////////////////////////////////////////////////////////    End   /////////////////////////////////////////////////////////////////////////////////////

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------//

//########################################################################### OTP Screen #######################################################################################//
/////////////////////////////////////////////////////////////////////////    Start   /////////////////////////////////////////////////////////////////////////////////////

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------//

//########################################################################### OTP Screen #######################################################################################//
/////////////////////////////////////////////////////////////////////////    End   /////////////////////////////////////////////////////////////////////////////////////

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------//

//########################################################################### Profile Screen #######################################################################################//
/////////////////////////////////////////////////////////////////////////    Start   /////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------//

  TextEditingController controllerAddress = TextEditingController();
  TextEditingController controllerEmgName = TextEditingController();
  TextEditingController controllerEmgPhone = TextEditingController();
  TextEditingController controllerCarBrand = TextEditingController();
  TextEditingController controllerCarModelYear = TextEditingController();
  TextEditingController controllerMileage = TextEditingController();
  TextEditingController controllerColour = TextEditingController();
  FocusNode mFocusNodeAddress = FocusNode();
  FocusNode mFocusNodeEmgName = FocusNode();
  FocusNode mFocusNodeEmgPhone = FocusNode();
  String selectedDate = "";
  String imgProfilePic = "";
  String imgMulkia = "";
  String imgDrivingLicence = "";
  String imgEmIdFront = "";
  String imgEmIdBack = "";

  String strEmgCountyECode = "";

  bool isEnableAddress = true;
  bool isEnablePhone = true;
  bool isEnableEmail = true;
  bool isEnableEmgName = true;
  bool isEnableEmgPhone = true;

  String strFname = "";
  String strCountry = "";
  String strLname = "";

//###########################################################################Profile Screen #######################################################################################//
/////////////////////////////////////////////////////////////////////////    End   /////////////////////////////////////////////////////////////////////////////////////
}
