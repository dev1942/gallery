import 'dart:collection';
import 'package:otobucks/services/repository/my_profile_repo.dart';

import '../../../../../global/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/Profile/Model/car_list_model.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/model/user_model.dart';
import 'package:otobucks/services/repository/user_repo.dart';
import 'package:otobucks/widgets/image_selection_bottom_sheet.dart';

class ProfileScreenController extends GetxController {
  ShowData mShowData = ShowData.showLoading;
  // Rx<ShowData> mShowData1 = ShowData.showLoading.obs;
  List<GetCarModelResult> carList=[];
  bool connectionStatus = false;
  bool isShowLoader = false;

  TextEditingController controllerAddress = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerEmgName = TextEditingController();
  TextEditingController controllerEmgPhone = TextEditingController();
  TextEditingController controllerCarBrand = TextEditingController();
  TextEditingController controllerCarModelYear = TextEditingController();
  TextEditingController controllerMileage = TextEditingController();
  TextEditingController controllerColour = TextEditingController();
  TextEditingController controllerCode = TextEditingController();
  TextEditingController controllerCity = TextEditingController();
  TextEditingController controllerNumber = TextEditingController();

  FocusNode mFocusNodeAddress = FocusNode();
  FocusNode mFocusNodePhone = FocusNode();
  FocusNode mFocusNodeEmail = FocusNode();
  FocusNode mFocusNodeEmgName = FocusNode();
  FocusNode mFocusNodeEmgPhone = FocusNode();

  String selectedDate = "";
  String imgProfilePic = "";
  String imgMulkia = "";
  String imgDrivingLicence = "";
  String imgEmIdFront = "";
  String imgEmIdBack = "";

  String strCountyCode = "";
  String strEmgCountyECode = "";

  bool isEmailVerified = false;
  bool isPhoneVerified = false;
  bool isEnableAddress = true;
  bool isEnablePhone = true;
  bool isEnableEmail = true;
  bool isEnableEmgName = true;
  bool isEnableEmgPhone = true;
  String strFname = "";
  String strCountry = "";
  String strLname = "";
  String oldPhoneNumebr="";



clearController(){
  controllerCarBrand.clear();
  controllerCarModelYear.clear();
  controllerMileage.clear();
  controllerColour.clear();
  controllerCode.clear();
  controllerCity.clear();
  controllerNumber.clear();
}

  removeImage(String image) {
    switch (image) {
      case 'mulkia':
        imgMulkia = '';
        break;
      case 'driving':
        imgDrivingLicence = '';
        break;
      case 'emirate_front':
        imgEmIdFront = '';
        break;
      case 'emirate_back':
        imgEmIdBack = '';
        break;
    }
    update();
  }

  getProfile() async {
    mShowData = ShowData.showLoading;
    update();

    HashMap<String, Object> requestParams = HashMap();
    var categories = await UserRepo().getUser(requestParams);
    categories.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
      mShowData = ShowData.showNoDataFound;
      update();
    }, (mResult) {

      UserModel mUserModel = mResult.responseData as UserModel;
      controllerAddress.text = Global.getString(mUserModel.address);

      strFname = Global.getString(mUserModel.firstName);
      strLname = Global.getString(mUserModel.lastName);
      strCountry = Global.getString(mUserModel.country.first);
      oldPhoneNumebr=Global.getString(mUserModel.phone);
      controllerPhone.text = Global.getString(mUserModel.phone);
      controllerEmail.text = Global.getString(mUserModel.email);
      isEmailVerified = mUserModel.isEmailVerified;
      isPhoneVerified = mUserModel.isPhoneVerified;
      controllerEmgName.text =
          Global.getString(mUserModel.emergency.emergencyName);
      controllerEmgPhone.text =
          Global.getString(mUserModel.emergency.emergencyPhone);
      controllerCarBrand.text = Global.getString(mUserModel.car.brand);
      controllerCarModelYear.text = Global.getString(mUserModel.car.modelYear);
      controllerMileage.text = Global.getString(mUserModel.car.mileage);
      controllerColour.text = Global.getString(mUserModel.car.color);

      imgProfilePic = Global.getString(mUserModel.image);
      imgMulkia = Global.getString(mUserModel.customer.mulkiya);
      imgDrivingLicence = Global.getString(mUserModel.customer.drivingLicence);
      imgEmIdFront = Global.getString(mUserModel.customer.emiratesIDFront);
      imgEmIdBack = Global.getString(mUserModel.customer.emiratesIDBack);

      if (Global.checkNull(mUserModel.countryCode)) {
        strCountyCode = mUserModel.countryCode;
        strEmgCountyECode = mUserModel.countryCode;
      }

      mShowData = ShowData.showData;
      update();
    });
  }

  updateProfile(BuildContext context) async {
    isShowLoader = true;
    update();

    String strAddress = controllerAddress.text.toString();
    String strPhone = controllerPhone.text.toString();
    String strEmail = controllerEmail.text.toString();
    String strEmgName = controllerEmgName.text.toString();
    String strEmgPhone = controllerEmgPhone.text.toString();
    HashMap<String, String> requestParams = HashMap();
    HashMap<String, String> requestParamsImage = HashMap();

    requestParams[PARAMS.PARAM_ADDRESS] = strAddress;
    requestParams[PARAMS.PARAM_PHONE] = strPhone;
    requestParams[PARAMS.PARAM_EMAIL] = strEmail;
    requestParams[PARAMS.PARAM_FIRSTNAME] = strFname;
    requestParams[PARAMS.PARAM_LASTNAME] = strLname;
    requestParams[PARAMS.PARAM_EMERGENCYNAME] = strEmgName;
    requestParams[PARAMS.PARAM_EMERGENCYPHONE] = strEmgPhone;
    requestParams[PARAMS.PARAM_COUNTRYCODE] = strCountyCode;


    if (Global.checkNull(imgMulkia)) {
      if (Global.isURL(imgMulkia)) {
        requestParams[PARAMS.PARAM_SCANMULKIA] = imgMulkia;
      } else {
        requestParamsImage[PARAMS.PARAM_SCANMULKIA] = imgMulkia;
      }
    }

    if (Global.checkNull(imgDrivingLicence)) {
      if (Global.isURL(imgDrivingLicence)) {
        requestParams[PARAMS.PARAM_SCANDRIVINGLISCENCE] = imgDrivingLicence;
      } else {
        requestParamsImage[PARAMS.PARAM_SCANDRIVINGLISCENCE] =
            imgDrivingLicence;
      }
    }
    if (Global.checkNull(imgEmIdFront)) {
      if (Global.isURL(imgEmIdFront)) {
        requestParams[PARAMS.PARAM_SCANEMIRATESFRONT] = imgEmIdFront;
      } else {
        requestParamsImage[PARAMS.PARAM_SCANEMIRATESFRONT] = imgEmIdFront;
      }
    }

    if (Global.checkNull(imgEmIdBack)) {
      if (Global.isURL(imgEmIdBack)) {
        requestParams[PARAMS.PARAM_SCANEMIRATESBACK] = imgEmIdBack;
      } else {
        requestParamsImage[PARAMS.PARAM_SCANEMIRATESBACK] = imgEmIdBack;
      }
    }

    if (Global.checkNull(imgProfilePic)) {
      if (Global.isURL(imgProfilePic)) {
        requestParams[PARAMS.PARAM_IMAGE] = imgProfilePic;
      } else {
        requestParamsImage[PARAMS.PARAM_IMAGE] = imgProfilePic;
      }
    }

    var categories = await UserRepo()
        .updateUser(requestParams, requestParamsImage, ReqType.patch);
    isShowLoader = false;
    update();
    categories.fold((failure) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
    }, (mResult) async {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: mResult.responseMessage,
          toastType: TOAST_TYPE.toastSuccess);
      getProfile();
    });
  }

  selectDocs(IdType mIdType, BuildContext context) {
    Get.bottomSheet(ImageSelection(
      isCropImage: false,
      mImagePath: (String strPath) {
        switch (mIdType) {
          case IdType.mulkia:
            imgMulkia = strPath;
            break;
          case IdType.drivingLicence:
            imgDrivingLicence = strPath;
            break;
          case IdType.emIdBack:
            imgEmIdBack = strPath;
            break;
          case IdType.emIdFront:
            imgEmIdFront = strPath;
            break;
        }
        update();
      },
      mMaxHeight: 1024,
      mMaxWidth: 1024,
      mRatioX: 1.0,
      mRatioY: 1.0,
    ));
  }

  isValid(BuildContext context) {
    String strAddress = controllerAddress.text.toString();

    String strEmail = controllerEmail.text.toString();
    String strEmgName = controllerEmgName.text.toString();
    String strEmgPhone = controllerEmgPhone.text.toString();
    // String strCarBrand = controllerCarBrand.text.toString();
    // String strCarModelYear = controllerCarModelYear.text.toString();
    // String strMileage = controllerMileage.text.toString();
    // String strColour = controllerColour.text.toString();

    if (!Global.checkNull(strAddress)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_ADDRESS,
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeAddress);
      return false;
    } else if (!Global.checkNull(strEmail)) {
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
    } else if (!Global.checkNull(strEmgName)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_EMG_NAME,
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeEmgName);
      return false;
    } else if (!Global.checkNull(strEmgPhone)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_EMG_NUMBER,
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeEmgPhone);
      return false;
    } else if (!Global.checkNull(strEmgPhone)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_VALID_NUMBER,
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeEmgPhone);
      return false;
    }
    //else if (!Global.checkNull(strCarBrand)) {
    //   Global.showToastAlert(
    //       context: context,
    //       strTitle: "",
    //       strMsg: AppAlert.ALERT_ENTER_CAR_BRAND,
    //       toastType: TOAST_TYPE.toastError);
    //   return false;
    // } else if (!Global.checkNull(strCarModelYear)) {
    //   Global.showToastAlert(
    //       context: context,
    //       strTitle: "",
    //       strMsg: AppAlert.ALERT_ENTER_CAR_MODEL_YEAR,
    //       toastType: TOAST_TYPE.toastError);
    //   return false;
    // } else if (!Global.checkNull(strMileage)) {
    //   Global.showToastAlert(
    //       context: context,
    //       strTitle: "",
    //       strMsg: AppAlert.ALERT_ENTER_CAR_MILAGE,
    //       toastType: TOAST_TYPE.toastError);
    //   return false;
    // } else if (!Global.checkNull(strColour)) {
    //   Global.showToastAlert(
    //       context: context,
    //       strTitle: "",
    //       strMsg: AppAlert.ALERT_ENTER_CAR_COLOR,
    //       toastType: TOAST_TYPE.toastError);
    //   return false;
    // }
    return true;
  }

  selectProfilePic(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return ImageSelection(
            isCropImage: true,
            mImagePath: (String strPath) {
              imgProfilePic = strPath;
              update();
            },
            mMaxHeight: 1024,
            mMaxWidth: 1024,
            mRatioX: 1.0,
            mRatioY: 1.0,
          );
        });
  }


//---------------------------get car list ---------
  getCarList() async {
    HashMap<String, Object> requestParams = HashMap();
    var categorie1 = await MyProfileRepository().getCarList(requestParams);

    categorie1.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
      mShowData = ShowData.showNoDataFound;
      update();
    }, (mResult) {

      carList = mResult.responseData as List<GetCarModelResult>;
      carList = carList.reversed.toList();
      mShowData = ShowData.showData;
      update();
    });
  }
//---------------------------add new car---------
  addNewCar(
      String brand, String color, String year, String km, String city,String code,String number) async {
    mShowData = ShowData.showLoading;

    update(); // isShowLoader = true;

    HashMap<String, Object> requestParams = HashMap();
    requestParams['brand'] = brand;
    requestParams['color'] = color;
    requestParams['modelYear'] = year;
    requestParams['mileage'] = km;
    requestParams['carCity'] = city;
    requestParams['carCode'] = code;
    requestParams['carNumber'] = number;

    var categories = await MyProfileRepository().addCar(requestParams);
    categories.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
      mShowData = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: mResult.responseMessage,
          toastType: TOAST_TYPE.toastSuccess);
      clearController();
     // getCardsMine();
      getCarList();
    });
  }
//-----------------------Delete car-------------------
  deletecar(String carId) async {
    // cardNumber.clear();
    // expiryDate.clear();
    // cardHolderName.clear();
    // cvvCode.clear();
    mShowData = ShowData.showLoading;
    update();
    HashMap<String, Object> requestParams = HashMap();
    //requestParams['cardId'] = cardId;
    var categories = await MyProfileRepository().deletecar(requestParams,carId);
    categories.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
      mShowData = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: mResult.responseMessage,
          toastType: TOAST_TYPE.toastSuccess);
      getCarList();
    });
  }

//-----------------------Update car----------------
  UpdateCar(
      String brand, String color, String year, String km, String city,String code,String number,String id) async {
    mShowData = ShowData.showLoading;

    update(); // isShowLoader = true;

    HashMap<String, Object> requestParams = HashMap();
    requestParams['brand'] = brand;
    requestParams['color'] = color;
    requestParams['modelYear'] = year;
    requestParams['mileage'] = km;
    requestParams['carCity'] = city;
    requestParams['carCode'] = code;
    requestParams['carNumber'] = number;

    var categories = await MyProfileRepository().updatecar(requestParams,id);

    categories.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
      mShowData = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: mResult.responseMessage,
          toastType: TOAST_TYPE.toastSuccess);
      clearController();
      // getCardsMine();
      getCarList();
    });
  }
}
