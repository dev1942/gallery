import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
// import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:location/location.dart' as location_selection;
import 'package:otobucks/global/Models/failure.dart';
import 'package:otobucks/global/Models/time_model.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/View/Videos/Views/show_video_screen.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path_provider/path_provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:quiver/time.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../View/Auth/Models/country_code.dart';
import '../widgets/custom_ui/bot_sms.dart';
import '../widgets/custom_ui/bottom_sheet.dart';
import 'Models/date_model.dart';
import '../View/auth/Models/user_detail.dart';
import 'Models/result.dart';
import 'app_colors.dart';
import 'app_dimens.dart';
import 'app_images.dart';
import 'app_views.dart';
import 'constants.dart';

//Main Global class
class Global {
  static LatLng mLatLng = const LatLng(25.2048, 55.2708);
  // All String
  static const String poppins = "poppins";

  static showAlert(BuildContext contextM, String strMessage) {
    if (strMessage.isEmpty) {
      strMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
    }
    showSimpleNotification(
        Container(
          child: Text(
            strMessage,
            style: Theme.of(contextM).textTheme.subtitle2?.merge(const TextStyle(color: Colors.white)),
          ),
          padding: const EdgeInsets.all(AppDimens.dimens_5),
          decoration: BoxDecoration(
            color: AppColors.colorAccent,
            border: Border.all(width: AppDimens.dimens_1, color: AppColors.colorWhite),
          ),
        ),
        duration: const Duration(seconds: 3),
        background: AppColors.colorAccent);
  }

  static setLatLong() async {
    final prefManager = await SharedPreferences.getInstance();

    double? mLatitude = prefManager.getDouble(SharedPrefKey.KEY_APP_LATITUDE);
    double? mLongitude = prefManager.getDouble(SharedPrefKey.KEY_APP_LONGITUDE);

    if (mLatitude != null && mLongitude != null) {
      mLatLng = LatLng(mLatitude, mLongitude);
    }
  }

  static showToastAlert({required BuildContext context, required String strTitle, required String strMsg, required TOAST_TYPE toastType}) {
    if (!Global.checkNull(strMsg)) {
      strMsg = AppAlert.ALERT_SERVER_NOT_RESPONDING;
    }
    Widget widgetM = Container();
    Color bgColor = AppColors.colorLogoGreenLight;
    String strIcon = AppImages.ic_alert_circle;
    switch (toastType) {
      case TOAST_TYPE.toastInfo:
        bgColor = AppColors.curiousBlue.withOpacity(0.2);
        strIcon = AppImages.ic_alert_circle;
        break;
      case TOAST_TYPE.toastSuccess:
        bgColor = AppColors.colorLogoGreenLight;
        strIcon = AppImages.ic_check_circle;
        break;

      case TOAST_TYPE.toastWarning:
        bgColor = AppColors.orange;
        strIcon = AppImages.ic_alert_triangle;

        break;

      case TOAST_TYPE.toastError:
        bgColor = AppColors.darkRed;
        strIcon = AppImages.ic_alert_octagon;
        break;
    }

    widgetM = Container(
      margin: const EdgeInsets.only(top: AppDimens.dimens_10),
      child: Container(
        decoration: AppViews.getRoundBorder(
            cBoxBgColor: AppColors.colorWhite,
            cBorderColor: AppColors.colorTextFildBorderColor,
            dRadius: AppDimens.dimens_10,
            dBorderWidth: AppDimens.dimens_1),
        child: Container(
          alignment: Alignment.center,
          width: double.maxFinite,
          child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(AppDimens.dimens_15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsetsDirectional.only(end: AppDimens.dimens_25),
                    height: AppDimens.dimens_40,
                    width: AppDimens.dimens_40,
                    decoration: BoxDecoration(color: bgColor.withOpacity(0.2), shape: BoxShape.circle),
                    padding: const EdgeInsets.all(AppDimens.dimens_12),
                    child: Image.asset(
                      strIcon,
                      color: bgColor,
                    ),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Global.checkNull(strTitle)
                          ? Text(
                              strTitle,
                              textAlign: TextAlign.start,
                              style: AppStyle.textViewStyleNormalButton(context: context, color: bgColor, fontWeightDelta: 1, fontSizeDelta: 0),
                            )
                          : Container(
                              height: 0,
                            ),
                      Text(
                        strMsg,
                        textAlign: TextAlign.start,
                        style: AppStyle.textViewStyleSmall(context: context, color: AppColors.colorBlack, fontWeightDelta: 0, fontSizeDelta: 0),
                      ),
                    ],
                  )),
                ],
              )),
        ),
      ),
    );

    showSimpleNotification(widgetM, background: Colors.transparent);
  }

  static showNoInternetDialog(BuildContext contextM) {
    showDialogM(contextM, AppAlert.ALERT, AppAlert.ALERT_NO_INTERNET_CONNECTION);
  }

  // show dialog
  static showDialogM(BuildContext contextM, String strTitle, String strMsg) {
    // return object of type Dialog
    var alert = AlertDialog(
      title: Text(strTitle),
      content: Text(strMsg),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        TextButton(
          child: const Text("Close"),
          onPressed: () {
            Navigator.of(contextM, rootNavigator: true).pop();
          },
        ),
      ],
    );
    showDialog(context: contextM, builder: (context) => alert);
  }

//  set data on result
  static Result? getDataWithValue(String strResponse, String keyValue) {
    try {
      Map data = json.decode(strResponse);

      String strStatus = data[Constants.RES_STATUS].toString();
      String strMessage = data[Constants.RES_MESSAGE].toString();

      bool status = true;
      if (Global.checkNull(strStatus)) {
        if (Global.equalsIgnoreCase(strStatus, "fail") || Global.equalsIgnoreCase(strStatus, "error")) {
          status = false;
        }
      }

      dynamic dataObj;
      if (status && data.containsKey(keyValue)) {
        dataObj = data[keyValue];
      } else if (!status || data.containsKey(Constants.RES_ERROR)) {
        dataObj = data[Constants.RES_ERROR];
      }
      return Result(responseStatus: status, responseMessage: strMessage, responseData: dataObj ?? {});
    } catch (exception) {
      log('catch error : $exception');
      return Result(responseStatus: false, responseMessage: AppAlert.ALERT_PLEASE_TRY_AFTER_SOME_TIME, responseData: "");
    }
  }

  static Result? getData(String strResponse) {
    try {
      Map data = json.decode(strResponse);

      String strStatus = data[Constants.RES_STATUS].toString();
      String strMessage = data[Constants.RES_MESSAGE].toString();

      bool status = true;
      if (Global.checkNull(strStatus)) {
        if (Global.equalsIgnoreCase(strStatus, "fail") || Global.equalsIgnoreCase(strStatus, "error")) {
          status = false;
        }
      }

      dynamic dataObj;
      if (status && data.containsKey(Constants.RES_RESULT)) {
        dataObj = data[Constants.RES_RESULT];
        log("mapData: ${data[Constants.RES_RESULT]}");
      } else if (!status || data.containsKey(Constants.RES_ERROR)) {
        dataObj = data[Constants.RES_ERROR];
      }
      log("ResponseData $dataObj");
      return Result(responseStatus: status, responseMessage: strMessage, responseData: dataObj ?? {});
    } catch (exception) {
      log('catch error : $exception');
      return Result(responseStatus: false, responseMessage: AppAlert.ALERT_PLEASE_TRY_AFTER_SOME_TIME, responseData: "");
    }
  }

//  set data on result
  static getInJson(String strResponse) {
    try {
      return json.decode(strResponse);
    } catch (exception) {
      return null;
    }
  }

  static bool equalsIgnoreCase(String? a, String? b) => (a == null && b == null) || (a != null && b != null && a.toLowerCase() == b.toLowerCase());

  static launchDialerOrWhatsApp(String strNumber, bool isWhatsApp) async {
    if (isWhatsApp) {
      strNumber = strNumber.replaceAll(" ", "");
      if (!strNumber.startsWith("+91")) {
        strNumber = "+91" + strNumber.trim();
      }

      String whatsAppURl = Constants.STR_APP_URL_ANDROID;
      if (Platform.isAndroid) {
        whatsAppURl = Constants.STR_APP_URL_ANDROID;
      } else if (Platform.isIOS) {
        whatsAppURl = Constants.STR_APP_URL_IOS;
      }

      await launchURL(whatsAppURl);
    } else {
      String url = "tel://$strNumber";
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchURL(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  static whatsAppOpen(String strNumber, String strMessage) async {
    strNumber = strNumber.replaceAll(" ", "");
    if (!strNumber.startsWith("+91")) {
      strNumber = "+91" + strNumber.trim();
    }

    var whatsappUrl = "whatsapp://send?phone=$strNumber&text=$strMessage";
    // ignore: unused_local_variable
    String whatsAppURl = Constants.STR_APP_URL_ANDROID;
    if (Platform.isAndroid) {
      whatsAppURl = Constants.STR_APP_URL_ANDROID;
    } else if (Platform.isIOS) {
      whatsAppURl = Constants.STR_APP_URL_IOS;
    }

    launchURL(whatsappUrl);
  }

  static launchURL(String strUrl) async {
    if (strUrl.isNotEmpty) {
      if (await launchURL(strUrl)) {
        try {
          await launchURL(strUrl);
        } catch (e) {
          log(e.toString());
        }
      } else {
        throw 'Could not launch $strUrl';
      }
    }
  }

  static String getTimeFormat(String time) {
    String hour = time.split(':')[0];
    String minute = time.split(':')[1].split('.')[0];

    if (int.parse(hour) > 11) {
      return '${int.parse(hour) - 12}:$minute PM';
    }
    return '$hour:$minute AM';
  }

//   * Replace Currency Code to Currency Sign.
  static String replaceCurrencySign(String currency) {
    if (Global.checkNull(currency)) {
      switch (currency.trim()) {
        case "INR":
          currency = Constants.SYMBOL_RUPEE;
          break;

        case "USD":
          currency = Constants.SYMBOL_DOLLAR;
          break;

        case "EUR":
          currency = Constants.SYMBOL_EURO;
          break;

        case "CAD":
          currency = Constants.SYMBOL_CDOLLAR;
          break;

        case "GBP":
          currency = Constants.SYMBOL_POUND;
          break;

        case "DEM":
          currency = Constants.SYMBOL_POUND;
          break;

        case "FRF":
          currency = Constants.SYMBOL_FRF;
          break;

        case "JPY":
          currency = Constants.SYMBOL_YEN;
          break;

        case "NLG":
          currency = Constants.SYMBOL_NLG;
          break;

        case "ITL":
          currency = Constants.SYMBOL_LIRA;
          break;

        case "CHF":
          currency = Constants.SYMBOL_CHF;
          break;

        case "DZD":
          currency = Constants.SYMBOL_DZD;
          break;

        case "ATS":
          currency = Constants.SYMBOL_ATS;
          break;

        case "CNY":
          currency = Constants.SYMBOL_YEN;
          break;

        case "MXP":
          currency = Constants.SYMBOL_PESO;
          break;

        case "RUR":
          currency = Constants.SYMBOL_RUR;
          break;

        default:
          currency = currency;
          break;
      }
    } else {
      currency = "AED"; //Constants.SYMBOL_DOLLAR;
    }

    return currency;
  }

  static checkValidEmail(String strEmail) {
    if (strEmail.isNotEmpty) {
//      return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//          .hasMatch(strEmail);
      return RegExp(Constants.EMAIL_REGX).hasMatch(strEmail);
    } else {
      return false;
    }
  }

  static checkValidMobile(String strMobile) {
    if (strMobile.isNotEmpty) {
      return RegExp(Constants.MOBILE_REGX).hasMatch(strMobile);
    } else {
      return false;
    }
  }

  static checkValidPassWord(String strMobile) {
    if (strMobile.isNotEmpty) {
      return RegExp(Constants.PASSWORD_REGX).hasMatch(strMobile);
    } else {
      return false;
    }
  }

  static showAlertDialog(BuildContext mContext, String strTitle, String strMessage, List<Widget> widgetActions) {
    return showDialog(
      context: mContext,
      builder: (context) => AlertDialog(
        title: Text(strTitle,
            style: Theme.of(mContext).textTheme.subtitle2?.merge(
                  const TextStyle(color: Colors.black),
                )),
        content: Text(strMessage,
            style: Theme.of(mContext).textTheme.subtitle2?.merge(
                  const TextStyle(color: Colors.black),
                )),
        actions: widgetActions,
      ),
    );
  }

  static showAlertDialogN(BuildContext mContext, String strTitle, String strMessage, List<Widget> widgetActions, bool isBarrierDismissible) {
    return showDialog(
      context: mContext,
      barrierDismissible: isBarrierDismissible,
      builder: (context) => AlertDialog(
        title: Text(
          strTitle,
          style: Theme.of(mContext).textTheme.subtitle2?.merge(const TextStyle(color: Colors.black)),
        ),
        content: Text(strMessage,
            style: Theme.of(mContext).textTheme.subtitle2?.merge(
                  const TextStyle(color: Colors.black),
                )),
        actions: widgetActions,
      ),
    );
  }

  static bool isKeyLengthValid(String key) {
    return key.length == 16 || key.length == 24 || key.length == 32;
  }

  static updateVersionCode(BuildContext mContext, bool isUpdate, bool isForceFullUpdate, String strRedirectUrl) {
    if (isUpdate || isForceFullUpdate) {
      if (!Constants.FLAG_DIALOG_APP_UPDATE) {
        List<Widget> widgetActions;

        if (isForceFullUpdate) {
          widgetActions = <Widget>[
            // ignore: argument_type_not_assignable
            TextButton(
              onPressed: () {
                Global.launchURL(strRedirectUrl);
              },
              child: Text(Constants.KEY_UPDATE_APP,
                  style: Theme.of(mContext).textTheme.subtitle2?.merge(
                        const TextStyle(color: Colors.black),
                      )),
            )
          ];
        } else {
          widgetActions = <Widget>[
            // ignore: argument_type_not_assignable
            TextButton(
              onPressed: () => Navigator.of(mContext, rootNavigator: true).pop(),
              child: Text(Constants.KEY_NO_THANKS,
                  style: Theme.of(mContext).textTheme.subtitle2?.merge(
                        const TextStyle(color: Colors.black),
                      )),
            ),
            TextButton(
              onPressed: () {
                Global.launchURL(strRedirectUrl);
              },
              child: Text(Constants.KEY_UPDATE_APP,
                  style: Theme.of(mContext).textTheme.subtitle2?.merge(
                        const TextStyle(color: Colors.black),
                      )),
            ),
          ];
        }
        return Global.showAlertDialogN(mContext, Constants.KEY_APP_UPDATE_TITLE, Constants.KEY_APP_UPDATE_MESSAGE, widgetActions, false);
      }
    }
  }

  static bool isTokenExpire(int intExpireTime, int intApiCallTime) {
    var diff = DateTime.now().millisecondsSinceEpoch - intApiCallTime;
    if (intExpireTime > 0) {
      var result = 120000;
      if (diff > result) {
        return true;
      }
    }

    return false;
  }

  // static refreshToken(BuildContext contextM) async {
  //   bool isSucess = false;
  //
  //   HashMap<String, String> requestParams = new HashMap();
  //
  //   try {
  //     String strResponce = await ReqListener.fetchPost(
  //         strUrl: RequestBuilder.API_LOGIN,
  //         requestParams: requestParams,
  //         mReqType: ReqType.POST,
  //         mParamType: ParamType.SIMPLE);
  //     if (strResponce != null && strResponce.isNotEmpty) {
  //       Result? mResponce = Global.getData(strResponce);
  //       if (mResponce != null) {
  //         if (mResponce.STATUS == PARAMS.RESULT_SUCCESS) {
  //           await storeToken(mResponce);
  //           isSucess = true;
  //         }
  //       }
  //     }
  //   } catch (exception) {
  //     log(exception.toString());
  //   }
  //
  //   return isSucess;
  // }

  static getTimeFromTimeStamp(int timestamp, String strDateFormate) {
    String strDate = "";
    var formatter = DateFormat(strDateFormate);
    strDate = formatter.format(DateTime.fromMillisecondsSinceEpoch(timestamp * 1000));
    return strDate;
  }

  static List<CountryCode> getCountyCode() {
    List<CountryCode> alCountryCode = [];
    String strCountryCode = utf8.decode(base64.decode(Constants.CONTRY_CODE_BASE64));
    if (strCountryCode.isNotEmpty) {
      // ignore: non_constant_identifier_names
      var country_code = json.decode(strCountryCode);

      for (var countryCode in country_code) {
        CountryCode mCountryCode = CountryCode.fromJson(countryCode);
        alCountryCode.add(mCountryCode);
      }
    }
    return alCountryCode;
  }

  static showLogoutDialog(BuildContext mContext) {
    AppViews.showCustomAlert(
        context: mContext,
        strTitle: Constants.STRING_SIGN_OUT,
        strMessage: Constants.STRING_SIGN_OUT_MSG,
        strLeftBtnText: Constants.TEXT_CANCEL,
        onTapLeftBtn: () {
          Navigator.pop(mContext);
        },
        strRightBtnText: Constants.STRING_OK,
        onTapRightBtn: () {
          setLogout(mContext);
        });
  }

  static setLogout(BuildContext mContext) async {
    final prefManager = await SharedPreferences.getInstance();

    // prefManager.clear();
    prefManager.setString(SharedPrefKey.KEY_USER_ID, "");
    prefManager.setBool(SharedPrefKey.KEY_IS_LOGIN, false);

    prefManager.setString(SharedPrefKey.KEY_USER_ID, "");
    prefManager.setString(SharedPrefKey.KEY_FIRST_NAME, "");
    prefManager.setString(SharedPrefKey.KEY_USER_IMAGE, "");

    prefManager.setString(SharedPrefKey.KEY_KEY_MOBILE_NUMBER, "");
    prefManager.setString(SharedPrefKey.KEY_KEY_EMAIL_ID, "");
    prefManager.setInt(SharedPrefKey.KEY_CART_ITEM_COUNT, 0);
    prefManager.setString(SharedPrefKey.KEY_ACCESS_TOKEN, "");
    prefManager.setString(SharedPrefKey.KEY_FIREBASE_TOKEN, "");

    Navigator.of(mContext).pop(false);
    Navigator.of(mContext).pushReplacementNamed(Constants.ACT_LOGIN);
  }

  static String trimString(String strString, int intLength) {
    if (strString.isNotEmpty && strString.length > intLength) {
      strString = strString.substring(0, intLength) + "..";
    }

    return strString;
  }

  static bool checkNull(String? strString) {
    if (strString != null && strString.isNotEmpty && !Global.equalsIgnoreCase(strString, "null")) {
      return true;
    }
    return false;
  }

  static bool checkIsLink(String? strString) {
    if (checkNull(strString) && strString!.startsWith("http")) {
      return true;
    }
    return false;
  }

  static showAlertDialogBtnRow(BuildContext mContext, String strTitle, Widget widgetActions, bool isBarrierDismissible) {
    return showDialog(
      context: mContext,
      barrierDismissible: isBarrierDismissible,
      builder: (context) => AlertDialog(title: Text(strTitle.isNotEmpty ? strTitle : AppAlert.ALERT), content: widgetActions),
    );
  }

  ///[amount] should may contain 2 decimal places
  static String _formatNumber(String amount) {
    NumberFormat formatter;
    if (amount.contains(".")) {
      formatter = NumberFormat('#,##,000.00');
    } else {
      formatter = NumberFormat('#,##,000');
    }
    double convertedNumber = convertStringToDouble(amount);
    if (convertedNumber == -1) return amount;
    return formatter.format(convertedNumber);
  }

  static double convertStringToDouble(String numberAsString) {
    try {
      final double doubleParsed = double.parse(numberAsString);
      final twoDecimalString = doubleParsed.toStringAsFixed(2);
      final double twoDecimalNumber = double.parse(twoDecimalString);
      return twoDecimalNumber;
    } catch (e) {
      log(e.toString());
      return -1;
    }
  }

  static String addSpacesToPhoneNumber(String mobileNumber) {
    if (mobileNumber.length != 13) return mobileNumber;

    var formattedMobileNumber = mobileNumber.substring(0, 3) +
        " " +
        mobileNumber.substring(3, 7) +
        " " +
        mobileNumber.substring(7, 10) +
        " " +
        mobileNumber.substring(10, mobileNumber.length);
    return formattedMobileNumber;
  }

  static storeToken(String strAccessToken) async {
    final prefManager = await SharedPreferences.getInstance();
    if (Global.checkNull(strAccessToken)) {
      prefManager.setString(SharedPrefKey.KEY_ACCESS_TOKEN, strAccessToken);
    }
  }

  // static getCropFile(

  static storeUserDetails(UserDetail mUserDetail) async {
    final prefManager = await SharedPreferences.getInstance();
    prefManager.setString(SharedPrefKey.KEY_USER_ID, mUserDetail.id);
    prefManager.setString(SharedPrefKey.KEY_FIRST_NAME, mUserDetail.firstName);
    prefManager.setString(SharedPrefKey.KEY_LAST_NAME, mUserDetail.lastName);
    prefManager.setString(SharedPrefKey.KEY_USER_IMAGE, mUserDetail.avatar);
    prefManager.setString(SharedPrefKey.KEY_KEY_MOBILE_NUMBER, mUserDetail.mobile);
    prefManager.setString(SharedPrefKey.KEY_KEY_EMAIL_ID, mUserDetail.email);
    if (Global.checkNull(mUserDetail.accessToken)) {
      prefManager.setString(SharedPrefKey.KEY_ACCESS_TOKEN, mUserDetail.accessToken);
    }
    prefManager.setBool(SharedPrefKey.KEY_IS_LOGIN, true);
  }

  //     {required String imagePath,
  //       required  double mRatioX,
  //       required double mRatioY,
  //       required int mMaxHeight,
  //       required  int mMaxWidth}) async {
  //   File? croppedFile = await ImageCropper.cropImage(
  //       sourcePath: imagePath,
  //       aspectRatio: new CropAspectRatio(ratioX: mRatioX, ratioY: mRatioY),
  //       maxHeight: mMaxHeight,
  //       maxWidth: mMaxWidth,
  //       androidUiSettings: AndroidUiSettings(
  //           toolbarTitle: 'Crop Image',
  //           toolbarColor: AppColors.colorAccent,
  //           toolbarWidgetColor: AppColors.colorWhite),
  //       iosUiSettings: IOSUiSettings(title: 'Crop Image'));
  //
  //   return croppedFile;
  // }

  // static getDeviceDetails() async {
  //   PackageInfo info = await PackageInfo.fromPlatform();
  //   String strDeviceName = "",
  //       strDeviceModel = "",
  //       strOsversion = "",
  //       strDeviceType = "";

  //   // HashMap<String, String> requestParams = new HashMap();
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  //   if (Platform.isAndroid) {
  //     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //     strDeviceName = androidInfo.manufacturer.toString() +
  //         " " +
  //         androidInfo.model.toString();
  //     strOsversion = androidInfo.version.release.toString();
  //     strDeviceModel = androidInfo.model.toString();
  //     strDeviceType = Constants.STR_PLATFORM_ANDROID;
  //   } else if (Platform.isIOS) {
  //     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

  //     strDeviceName = iosInfo.utsname.machine.toString();
  //     strOsversion = iosInfo.utsname.version.toString();
  //     strDeviceModel = iosInfo.model.toString();

  //     strDeviceType = Constants.STR_PLATFORM_IOS;
  //   }

  //   // requestParams[PARAMS.PARAM_FCM_TOKEN] =
  //   //     strToken != null ? strToken : "";
  //   // requestParams[PARAMS.PARAM_DEVICE_TYPE] = str_device_type;
  //   // requestParams[PARAMS.PARAM_DEVICE_NAME] = str_device_name;
  //   // requestParams[PARAMS.PARAM_CARRIER_NAME] = "NA";
  //   // requestParams[PARAMS.PARAM_OS_VERSION] = str_os_version;
  //   // requestParams[PARAMS.PARAM_APP_VERSION] = info.version.toString();
  //   // requestParams[PARAMS.PARAM_DEVICE_COUNTRY] = "NA";
  //   // requestParams[PARAMS.PARAM_ACTIVITY] = "dashboard";

  //   String message = "App Version : " +
  //       info.version.toString() +
  //       "<br>" +
  //       "Device Type : " +
  //       strDeviceType +
  //       "<br>" +
  //       "Phone Version : " +
  //       strOsversion +
  //       "<br>" +
  //       "Device Brand: " +
  //       strDeviceName +
  //       "<br>" +
  //       "Device Model : " +
  //       strDeviceModel +
  //       "<br>";

  //   return message;
  // }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  static setControllerValue(TextEditingController mController, String strValue) {
    if (checkNull(strValue)) {
      mController.text = strValue;
    }
  }

  static getStatusFromString(String strStatus) {
    if (checkNull(strStatus)) {
      if (Global.equalsIgnoreCase(strStatus, Constants.TEXT_YES) ||
          Global.equalsIgnoreCase(strStatus, Constants.TAG_ACTIVE) ||
          Global.equalsIgnoreCase(strStatus, Constants.STATUS_TRUE)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static showNoInternet(BuildContext context) {
    Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_NO_INTERNET_CONNECTION, toastType: TOAST_TYPE.toastError);
  }

  static getDiscount(String productMrp, String salePrice) {
    double dProductMrp = 0.0, discount = 0.0, dSalePrice = 0.0;

    if (checkNull(productMrp)) {
      dProductMrp = double.parse(productMrp);
    }
    if (checkNull(salePrice)) {
      dSalePrice = double.parse(salePrice);
    }

    if (dSalePrice > 0) {
      double diff = dProductMrp - dSalePrice;

      discount = diff / dProductMrp * 100;
    }

    return discount;
  }

  static Future<void> shareText({String? title, String? text, String? linkUrl, String? chooserTitle}) async {
    await Share.share(text!);
  }

  static taskStoreToken(String strToken) async {
    final prefManager = await SharedPreferences.getInstance();
    prefManager.setString(SharedPrefKey.KEY_FIREBASE_TOKEN, strToken);
  }

  static taskGetToken() async {
    final prefManager = await SharedPreferences.getInstance();
    String? strToken = prefManager.getString(SharedPrefKey.KEY_FIREBASE_TOKEN);

    return strToken ?? "";
  }

  static displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return CustomBottomSheet(child: Container());
        });
  }

  static downloadImage(String strURL) async {
    var response = await http.get(Uri.parse(strURL));
    var documentDirectory = await getApplicationDocumentsDirectory();
    var firstPath = documentDirectory.path + "/images";
    var filePathAndName = documentDirectory.path + '/images/pic.jpg';
    await Directory(firstPath).create(recursive: true);
    File file2 = File(filePathAndName);
    file2.writeAsBytesSync(response.bodyBytes);

    return filePathAndName;
  }

  // static showDateRangePicker(BuildContext mContext) async {
  //   List<DateTime> picked = await DateRangePicker.showDatePicker(
  //       context: mContext,
  //       initialFirstDate: new DateTime.now().add(new Duration(days: 0)),
  //       initialLastDate: new DateTime.now().add(new Duration(days: 0)),
  //       firstDate: new DateTime(2014),
  //       lastDate: new DateTime.now().add(new Duration(days: 0)));
  //   if (picked != null && picked.length == 2) {
  //     return picked;
  //   }
  // }

  static getTimeFromDate(DateTime mDateTime, String strDateFormate) {
    String strDate = "";
    var formatter = DateFormat(strDateFormate);
    strDate = formatter.format(mDateTime);
    return strDate;
  }

  static capitalizeFirstofEach(String strValue) {
    return strValue.replaceAll(RegExp('_'), ' ').split(" ").map((str) => inCaps(str)).join(" ");
  }

  static inCaps(String strValue) {
    return strValue.isNotEmpty ? '${strValue[0].toUpperCase()}${strValue.substring(1)}' : '';
  }

// Static Data

// get product list data

  static getScalFactor() {
    return 1.0;
  }

  static String getCapitalizeString({required String str}) {
    if (str.length <= 1) {
      return str.toUpperCase();
    }
    return '${str[0].toUpperCase()}${str.substring(1)}';
  }

  static String getString(String strValue) {
    if (Global.checkNull(strValue)) {
      return strValue;
    }
    return '';
  }

  static bool isURL(String strURL) {
    if (Global.checkNull(strURL)) {
      if (strURL.startsWith("http")) {
        return true;
      }
    }
    return false;
  }

  static showFailuerError({required BuildContext context, required String strTitle, required Failure failure}) {
    if (Global.checkNull(failure.DATA.toString())) {
      Map mData = failure.DATA as Map;
      var keyMain = mData.keys;
      for (var strMainKey in keyMain) {
        var mDataItems = mData[strMainKey.toString()];
        for (var itemSub in mDataItems) {
          String strSubItem = itemSub.toString();
          Global.showToastAlert(context: context, strTitle: strTitle, strMsg: strSubItem, toastType: TOAST_TYPE.toastError);
          break;
        }
        break;
      }
    } else {
      Global.showToastAlert(context: context, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
    }
  }

  static getAddressFromLatLong(LatLng mLatLong) async {
    StringBuffer strAddress = StringBuffer();
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(mLatLong.latitude, mLatLong.longitude);

      String streetAddress = placemarks[0].street.toString();
      String city = placemarks[0].locality.toString();
      String postal = placemarks[0].subLocality.toString();
      String countryName = placemarks[0].country.toString();
      if (Global.checkNull(streetAddress)) {
        strAddress.write(streetAddress + ", ");
      }

      if (Global.checkNull(postal)) {
        strAddress.write(postal + ", ");
      }
      if (Global.checkNull(city)) {
        strAddress.write(city + ", ");
      }

      if (Global.checkNull(countryName)) {
        strAddress.write(countryName);
      }
    } catch (exp) {
      return "";
    }
    return strAddress.toString();
  }

  // static getLatLongFromAddress(String strAddress) async {
  //   GeoCode geoCode = GeoCode();

  //   try {
  //     Coordinates coordinates =
  //         await geoCode.forwardGeocoding(address: strAddress);

  //     double? latitude = coordinates.latitude;
  //     double? longitude = coordinates.longitude;

  //     return LatLng(latitude!, longitude!);
  //   } catch (e) {
  //     log(e);
  //   }
  //   return null;
  // }

  static getCurrentDateTime() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    return formattedDate;
  }

  static getPrediction(BuildContext mContext, Function onError) async {
    Prediction? mPrediction = await PlacesAutocomplete.show(
      context: mContext,
      apiKey: Constants.STR_GOOGLE_API_KEY,
      onError: (PlacesAutocompleteResponse response) {
        onError(response);
      },
      mode: Mode.overlay,
      offset: 0,
      strictbounds: false,
      language: "en",
      components: [Component(Component.country, "in")],
      types: ["(regions)"],
      hint: "Search Location",
    );

    return mPrediction;
  }

  static getDoubleFromString(String strValue) {
    double dSubTotal = 0.0;
    if (Global.checkNull(strValue)) {
      dSubTotal = double.parse(strValue);
    }
    return dSubTotal;
  }

  static navigateToThankYou(BuildContext context) {
    Navigator.pushReplacementNamed(context, Constants.ACT_HOME_WITH_THANKS);
  }

  static getColorByStatus(String strStatus) {
    if (Global.checkNull(strStatus)) {
      switch (strStatus) {
        case "Success":
          return AppColors.colorLogoGreenLight;

        case "Fail":
          return AppColors.darkRed;
      }
    }
    return AppColors.colorBlack;
  }

  static getCropFile(
      {required String imagePath, required double mRatioX, required double mRatioY, required int mMaxHeight, required int mMaxWidth}) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imagePath,
        aspectRatio: CropAspectRatio(ratioX: mRatioX, ratioY: mRatioY),
        maxHeight: mMaxHeight,
        maxWidth: mMaxWidth,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: "Crop Image",
            toolbarColor: AppColors.colorBlueEnd,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(minimumAspectRatio: 1.0),
        ]);
    /*androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: AppColors.colorAccent,
        toolbarWidgetColor: AppColors.colorWhite),
    iosUiSettings: const IOSUiSettings(title: 'Crop Image'));*/
    return croppedFile;
  }

  static shareApp() {
    String strAppURL = Constants.STR_APP_URL_ANDROID;
    if (Platform.isAndroid) {
      strAppURL = Constants.STR_APP_URL_ANDROID;
    } else if (Platform.isIOS) {
      strAppURL = Constants.STR_APP_URL_IOS;
    }
    String strShareMessage = Constants.APP_NAME + " is really useful. Try it !!! \n\n" + strAppURL;

    shareText(title: Constants.APP_NAME, text: strShareMessage, chooserTitle: "Share", linkUrl: "");
  }

  static getCurrentLocation({required BuildContext context}) async {
    //LatLng mLatLngMain = Constants.mAhmedabadLatLng;
    LatLng mLatLngMain = const LatLng(0, 0);
    //
    // double? longitude =
    //     prefManager.getDouble(SharedPrefKey.KEY_CURRENT_LONGITUDE);
    // double? latitude =
    //     prefManager.getDouble(SharedPrefKey.KEY_CURRENT_LATITUDE);
    //
    // if (longitude != null && latitude != null) {
    //   mLatLngMain = LatLng(latitude, longitude);
    // } else {
    location_selection.Location location = location_selection.Location();

    late location_selection.PermissionStatus _permissionGranted;

    bool _serviceEnabled = false;
    bool isPermissionGranted = true;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        Global.getCurrentLocation(context: context);
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == location_selection.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != location_selection.PermissionStatus.granted) {
        isPermissionGranted = false;
        Global.getCurrentLocation(context: context);
      }
    }

    if (isPermissionGranted && _serviceEnabled) {
      location_selection.LocationData _locationData = await location.getLocation();
      mLatLngMain = LatLng(_locationData.latitude!, _locationData.longitude!);
      // prefManager.setDouble(
      //     SharedPrefKey.KEY_CURRENT_LONGITUDE, _locationData.longitude!);
      //
      // prefManager.setDouble(
      //     SharedPrefKey.KEY_CURRENT_LATITUDE, _locationData.latitude!);
    }
    // }
    return mLatLngMain;
  }

  static showDateRangePicker(BuildContext mContext, int daysCount) async {
    // DateTimeRange? picked = await DateRangePicker.showDateRangePicker(
    //   initialDateRange: DateTimeRange(
    //     start: new DateTime.now(),
    //     end: (new DateTime.now()).add(new Duration(days: daysCount)),
    //   ),
    //   firstDate: new DateTime.now(),
    //   currentDate: DateTime.now(),
    //   lastDate: new DateTime(DateTime.now().year + 2),
    //   context: mContext,
    // );
    // if (picked != null) {
    //   return picked;
    // }
  }
  static getColourByStatus(String status) {
    if (checkNull(status)) {
      if (equalsIgnoreCase(status.toLowerCase(), "delivered")) {
        return AppColors.colorLogoGreenDark;
      } else {
        return AppColors.darkRed;
      }
    }
    return AppColors.darkRed;
  }

  static getTimeList(TimeModel? _mTimeModel) {
    List<TimeModel> alTimeModel = [];
    int addedHR = 1;
    for (int index = 9; index < 21; ++index) {
      DateTime mDateTime = DateTime(DateTime.now().year, 8, 9, 8, 0).add(Duration(hours: addedHR));

      String time12HR = DateFormat('hh:00 aa').format(mDateTime);
      String time24HR = DateFormat('HH:00').format(mDateTime);

      bool isSelected = false;
      if (_mTimeModel != null) {
        if (_mTimeModel.time_24hr == time24HR) {
          isSelected = true;
        }
      }

      TimeModel mTimeModel = TimeModel(time_12hr: time12HR, isEnable: true, time_24hr: time24HR, t24hr: mDateTime.hour, isSelected: isSelected);

      alTimeModel.add(mTimeModel);
      ++addedHR;
    }
    return alTimeModel;
  }

  static checkIsToday(String selectedDate) {
    if (Global.checkNull(selectedDate)) {
      DateTime _selectedDate = DateFormat(Constants.STRING_YYYY_MM_DD).parse(selectedDate);
      DateTime currentDate = DateTime.now();

      bool isAfter = currentDate.isAfter(_selectedDate);

      if (currentDate.month == _selectedDate.month && currentDate.year == _selectedDate.year && currentDate.day == _selectedDate.day) {
        // same
        return DateType.today;
      } else if (isAfter) {
        // future
        return DateType.past;
      }
    }
    return DateType.none;
  }

  static getIntFromMonthName(String monthName) {
    int month = 1;
    if (Global.checkNull(monthName)) {
      switch (monthName) {
        case "January":
          month = 1;
          break;
        case "February":
          month = 2;
          break;
        case "March":
          month = 3;
          break;
        case "April":
          month = 4;
          break;
        case "May":
          month = 5;
          break;
        case "June":
          month = 6;
          break;
        case "July":
          month = 7;
          break;
        case "August":
          month = 8;
          break;
        case "September":
          month = 9;
          break;
        case "October":
          month = 10;
          break;
        case "November":
          month = 11;
          break;
        case "December":
          month = 12;
          break;
      }
    }
    return month;
  }

  static getMonthList({DateTime? selectedDate}) {
    DateTime mDateTimeNow = DateTime.now();
    if (selectedDate != null) {
      mDateTimeNow = selectedDate;
    }
    int currentMonth = mDateTimeNow.month;
    int addedDay = 30;
    switch (currentMonth) {
      case 12:
        addedDay = 31;
        break;
      case 2:
        addedDay = 28;
        break;
      case 11:
        addedDay = 30;
        break;
    }

    List<String> alDateModel = [];
    int addedHR = 0;
    for (int index = currentMonth; index < 24; ++index) {
      DateTime mDateTime = mDateTimeNow.add(Duration(days: addedHR));
      String mMonth = DateFormat(Constants.STRING_MMMM_yyyy).format(mDateTime);

      alDateModel.add(mMonth);
      addedHR = addedHR + addedDay;
    }
    // if (selectedDate == null) {
    //  DateTime.now().hour
    // }
    return alDateModel;
  }

  static getDayOfMonth(String strMonth, {DateTime? selectedDate}) {
    log('strMonth: $strMonth');
    List<DateModel> alDateModel = [];

    if (Global.checkNull(strMonth)) {
      bool removeDate = false;

      DateTime parseDate = DateFormat(Constants.STRING_MMMM_yyyy).parse(strMonth);

      int currentMonth = DateTime.now().month;
      int currentYear = DateTime.now().year;

      int month = parseDate.month;
      int year = parseDate.year;
      DateTime mmDateTime = DateTime(year, month);
      int gape = 0;
      if (currentYear == year && currentMonth == month) {
        gape = 0;
        mmDateTime = DateTime.now();
        if (selectedDate != null) {
          if (currentYear == selectedDate.year && currentMonth == selectedDate.month) {
            bool isAfter = mmDateTime.isAfter(selectedDate);
            if (isAfter) {
              mmDateTime = selectedDate;
            }
            // gape = 0;
          }
        }
        if (mmDateTime.hour > 20) {
          removeDate = true;
        }
      }

      int currentDate = mmDateTime.day + gape;
      int dayInMonth = daysInMonth(mmDateTime.year, mmDateTime.month);
      int addedHR = gape;

      for (int index = currentDate; index <= dayInMonth; ++index) {
        DateTime mDateTime = mmDateTime.add(Duration(days: addedHR));
        String mMonth = DateFormat('MM').format(mDateTime);

        String date = DateFormat('dd').format(mDateTime);
        String year = DateFormat('yyyy').format(mDateTime);
        String daysOfTheWeek = DateFormat('EE').format(mDateTime);
        bool isSelected = false;
        if (selectedDate != null) {
          int diff = selectedDate.difference(mDateTime).inDays;

          if (diff == 0 && selectedDate.day == mDateTime.day) {
            log(selectedDate.toString() + '---' + mDateTime.toString());
            isSelected = true;
          }
        }

        DateModel mTimeModel = DateModel(date: date, month: mMonth, year: year, daysOfTheWeek: daysOfTheWeek, isSelected: isSelected);
        alDateModel.add(mTimeModel);
        ++addedHR;
      }
      if (removeDate) {
        alDateModel.removeAt(0);
      }
    }

    return alDateModel;
  }

  static gotoVideoView(BuildContext context, String videoURL) {
    log("vidoe gellary seldciton");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ShowVideoScreen(
                  strVideoURL: videoURL,
                )));
  }

  static inProgressAlert(BuildContext context) {
    Get.to(() => const BotSms());
    // showToastAlert(
    //     context: context,
    //     strTitle: "Alert",
    //     strMsg: "This functionality in under construction",
    //     toastType: TOAST_TYPE.toastWarning);
  }

  static Future<String> destinationFile(String type) async {
    String directory;
    final String videoName = '${DateTime.now().millisecondsSinceEpoch}.$type';
    if (Platform.isAndroid) {
      // Handle this part the way you want to save it in any directory you wish.
      final List<Directory>? dir = await getExternalStorageDirectories(type: StorageDirectory.movies);
      directory = dir!.first.path;
      return File('$directory/$videoName').path;
    } else {
      final Directory dir = await getLibraryDirectory();
      directory = dir.path;
      return File('$directory/$videoName').path;
    }
  }

  // String _getVideoSize({required File file}) => formatBytes(file.lengthSync(), 2);

  static Future<double> getFileSize(String filepath) async {
    var file = File(filepath);
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);

    return sizeInMb;

    // int bytes = await file.length();
    // if (bytes <= 0) return "0 B";
    // const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    // var i = (log(bytes) / log(1024)).floor();
    // return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + ' ' + suffixes[i];
  }
}

extension CurrencyFormating on String {
  String toCurrencyFormat({bool ignoreDecimal = true}) {
    String unformattedString = this;
    if (ignoreDecimal && unformattedString.contains(".")) {
      unformattedString = unformattedString.split(".").first;
    }
    return Global._formatNumber(unformattedString);
  }
}
