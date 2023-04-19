import 'dart:collection';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/CatBuyCar/models/carsListModel.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../global/constants.dart';
import '../../../services/repository/buy_car_repo.dart';
import '../Views/rating_screen.dart';

class BuyCarController extends GetxController {
  Rx<ShowData> mShowData = ShowData.showData.obs;

  bool connectionStatus = false;
  bool isShowLoader = false;
  CarsListModel? carsListModel;
// inquiry
  String name = '';
  String email = '';
  String phoneNumber = '';
  String note = '';
  String userId = '';
  String productId = '';

  updateName(String newName) {
    name = newName;
    update();
  }

  updateEmail(String newEmail) {
    email = newEmail;
    update();
  }

  updatePhoneNumber(String newphoneNumber) {
    phoneNumber = newphoneNumber;
    update();
  }

  updatenote(String newNote) {
    note = newNote;
    update();
  }

  updatProductId(String newProductId) {
    productId = productId;
    update();
  }

  isValidInquiry(BuildContext context) {
    if (name.trim().isEmpty) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: "Name is Required", toastType: TOAST_TYPE.toastError);
    } else if (email.trim().isEmpty) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: "Email is Required", toastType: TOAST_TYPE.toastError);
    } else if (phoneNumber.trim().isEmpty) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: "Phone is Required", toastType: TOAST_TYPE.toastError);
    } else {
      inquiryTask(context);
    }
  }

//----------------------------get Car List From api available for purchasing------------------

  Future<void> getCarsList() async {
    mShowData.value = ShowData.showLoading;
    update();

    // isShowLoader = true;

    HashMap<String, Object> requestParams = HashMap();

    var categories = await BuyCarRepo().getCarsList(requestParams);

    categories.fold((failure) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);

      mShowData.value = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      carsListModel = mResult.responseData as CarsListModel;

      mShowData.value = ShowData.showData;
      update();
    });
  }

  inquiryTask(BuildContext context) async {
    isShowLoader = true;
    update();

    HashMap<String, Object> requestParams = HashMap();
    final prefs = await SharedPreferences.getInstance();
    var userId = await prefs.getString(SharedPrefKey.KEY_USER_ID);
    ;
    requestParams['name'] = name;
    requestParams['email'] = email;
    requestParams['phone'] = phoneNumber;
    requestParams['userId'] = phoneNumber;
    requestParams['productId'] = productId;
    requestParams['userId'] = userId ?? "";
    requestParams['note'] = note;
    inspect(requestParams);

    var inquiryTask = await BuyCarRepo().sendInquiryForCar(requestParams);

    isShowLoader = false;
    update();

    inquiryTask.fold((failure) {
      inspect(failure);
      Global.showToastAlert(context: context, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
    }, (mResult) {
      Get.to(() => const RatingScreenCarBuy());
      inspect(mResult);
    });
  }

  filterCarsTask(BuildContext context,
      {required String condition,
      required String brand,
      required String modelYear,
      required String minPrice,
      required String maxPrice,
      required String transmissiontype}) async {
    isShowLoader = true;
    update();

    HashMap<String, Object> requestParams = HashMap();
    final prefs = await SharedPreferences.getInstance();
    var userId = await prefs.getString(SharedPrefKey.KEY_USER_ID);
    ;
    requestParams['brand'] = brand;
    requestParams['modelYear'] = email;
    requestParams['minPrice'] = phoneNumber;
    requestParams['maxPrice'] = phoneNumber;
    requestParams['transmisionType'] = transmissiontype;

    inspect(requestParams);

    var carFilerTask = await BuyCarRepo().filterCars(requestParams);

    isShowLoader = false;
    update();

    carFilerTask.fold((failure) {
      inspect(failure);
      Global.showToastAlert(context: context, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
    }, (mResult) {
      carsListModel!.result!.clear();
      carsListModel = mResult.responseData as CarsListModel;

      update();
      if (carsListModel != null && carsListModel!.result!.isNotEmpty) {
        mShowData.value = ShowData.showData;

        Get.back();
      } else {
        Global.showToastAlert(context: context, strTitle: "", strMsg: "No Cars found please change filters", toastType: TOAST_TYPE.toastError);
      }

      // inspect(mResult);
    });
    update();
  }
}
