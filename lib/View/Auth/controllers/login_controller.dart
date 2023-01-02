import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/connectivity_status.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/container_properties.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/View/auth/Models/model_otp.dart';
import 'package:otobucks/services/repository/login_repo.dart';
import 'package:otobucks/services/repository/otp_repo.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../View/forgot_password_screen.dart';
import '../View/otp_screen.dart';
import '../View/registation_screen.dart';
class LoginController extends GetxController {
  bool connectionStatus = false;
  bool isShowLoader = false;
  bool obscureTextM = true;
  bool rememberMe = false;
  List<Accounts> accounts = [];
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );
  String strVersionName = "";
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  FocusNode mFocusNodeEmail = FocusNode();
  FocusNode mFocusNodePassword = FocusNode();

  final List<String> items = ['English', 'Arabic'];
  String selectedValue = "English";

  void changeRemember(bool value) {
    rememberMe = value;
    update();
  }

  void changeLocale(String locale) {
    switch (locale) {
      case 'English':
        Get.updateLocale(const Locale('en', 'UE'));
        selectedValue = "English";
        break;
      case 'Arabic':
        Get.updateLocale(const Locale('ar', 'AE'));
        selectedValue = 'Arabic';
        break;
      default:
        Get.updateLocale(const Locale('ar', 'AE'));
    }
    update();
  }

  textObscureTap(bool value) {
    obscureTextM = value;
    update();
  }

  isValid(BuildContext context) {
    String strEmail = controllerEmail.text.toString();
    String strPassword = controllerPassword.text.toString();
    if (!Global.checkNull(strPassword) && !Global.checkNull(strEmail)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_EMAIL_AND_PASSWORD,
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeEmail);
      return false;
    }
    if (!Global.checkNull(strEmail)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_EMAIL,
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeEmail);
      return false;
    } else if (Global.checkNull(strEmail) &&
        !Global.checkValidEmail(strEmail)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_VALID_EMAIL,
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeEmail);
      return false;
    } else if (!Global.checkNull(strPassword)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_PASSWORD,
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodePassword);
      return false;
    }
    return true;
  }

  Future<bool> initConnectivity(BuildContext context) async {
    final PackageInfo info = await PackageInfo.fromPlatform();

    try {
      connectionStatus = await ConnectivityStatus.isConnected();
    } catch (e) {
      log(e.toString());
    }
    _packageInfo = info;

    if (connectionStatus) {
      strVersionName = _packageInfo.version;
      return true;
    } else {
      Global.showNoInternetDialog(context);
      return false;
    }
  }

  loginUserTask(BuildContext context) async {
    if (!isValid(context) || !(await initConnectivity(context))) {
      return;
    }
    isShowLoader = true;
    update();

    String strEmailID = controllerEmail.text.toString().trim();
    String strPassword = controllerPassword.text.toString();
    String firebaseToken = await FirebaseMessaging.instance.getToken() ?? '';
    await Global.taskStoreToken(firebaseToken);

    HashMap<String, Object> requestParams = HashMap();
    requestParams[PARAMS.PARAM_EMAIL] = strEmailID;
    requestParams[PARAMS.PARAM_PASSWORD] = strPassword;
    requestParams[PARAMS.PARAM_FIREBASE_TOKEN] = firebaseToken;
    log('Firebase Token->> $firebaseToken');

    var signInEmail = await LoginRepo().login(requestParams);

    isShowLoader = false;
    update();

    signInEmail.fold((failure) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
      if ("Please verify your email address first" == failure.MESSAGE) {
        gotoMobileOTPScreen(context);
      }
    }, (mResult) {
      navigateToHomePage(context);
    });
  }

  void gotoMobileOTPScreen(BuildContext context) async {
    ModelOTP mModelOTP = ModelOTP(
        password: controllerPassword.text.toString(),
        emailId: controllerEmail.text.toString());

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OTPScreen(mModelOTP: mModelOTP)));
    sendOTPTask();
  }

  void navigateToHomePage(BuildContext context) async {
    if (rememberMe) {
      await storeAccounts();
    }
    final prefManager = await SharedPreferences.getInstance();
    prefManager.setBool(SharedPrefKey.KEY_IS_LOGIN, true);
    Navigator.pushNamed(context, Constants.ACT_HOME);
  }

  void pushRegisterScreen(BuildContext context) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const RegistrationScreen()));
  }

  void forgoPasswordScreen(BuildContext context) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
  }

  sendOTPTask() async {
    isShowLoader = true;
    update();
    HashMap<String, Object> requestParams = HashMap();

    requestParams[PARAMS.PARAM_EMAIL] = controllerEmail.text;

    var signInEmail = await OTPRepo().sentOTPToEmail(requestParams);

    signInEmail.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
      isShowLoader = false;
      update();
    }, (mResult) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: mResult.responseMessage,
          toastType: TOAST_TYPE.toastSuccess);
      isShowLoader = false;
      update();
    });
  }

  bottomSheet() {
    return Get.bottomSheet(Container(
      padding: const EdgeInsets.all(15),
      height: 300,
      decoration: BoxDecoration(
          color: AppColors.colorWhite,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(13), topRight: Radius.circular(13))),
      child: Column(
        children: [
          Container(
            height: 5,
            width: 30,
            decoration:
                ContainerProperties.simpleDecoration(radius: 100.0).copyWith(
              color: AppColors.colorBlueStart,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Get.back();
                          controllerEmail.text = accounts[index].email;
                          controllerPassword.text = accounts[index].password;
                        },
                        child: Container(
                            alignment: AlignmentDirectional.centerStart,
                            height: 40,
                            width: double.infinity,
                            child: Text(accounts[index].email)),
                      ),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: accounts.length))
        ],
      ),
    ));
  }

  Future<void> getSavedAccounts() async {
    accounts.clear();
    final prefs = await SharedPreferences.getInstance();
    List<String> accountsSaved = prefs.getStringList("accounts") ?? [];
    for (var account in accountsSaved) {
      accounts.add(Accounts.fromMap(jsonDecode(account)));
    }
    if (accounts.isNotEmpty && controllerEmail.text.isEmpty) {
      bottomSheet();
    }
  }

  Future<void> storeAccounts() async {
    String account = jsonEncode(
        {'email': controllerEmail.text, 'password': controllerPassword.text});
    final prefs = await SharedPreferences.getInstance();
    List<String> accounts = prefs.getStringList("accounts") ?? [];

    if (!accounts.contains(account)) {
      accounts.insert(0, account);
    }
    if (accounts.length > 10) {
      accounts.removeLast();
    }
    prefs.setStringList("accounts", accounts);
  }

  onTapTextField() {
    getSavedAccounts();
  }
}

class Accounts {
  String email;
  String password;

  Accounts({required this.email, required this.password});
  factory Accounts.fromMap(Map<String, dynamic> json) =>
      Accounts(email: json['email'], password: json['password']);
}
