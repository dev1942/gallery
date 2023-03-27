import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/ThankYou/Views/thankyou_fragment.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/View/CheckOut/Models/card_model.dart';
import 'package:otobucks/services/repository/card_repo.dart';
import 'package:otobucks/services/repository/estimates_repo.dart';

import '../../../../widgets/custom_ui/carousel_slider/carousel_controller.dart';

class EstCheckOutController extends GetxController {
  ShowData mShowData = ShowData.showData;

  bool connectionStatus = false;
  bool isShowLoader = false;

  List<CardModel> alCardModel = [];

  TextEditingController cardNumber = TextEditingController();
  TextEditingController expiryDate = TextEditingController();
  TextEditingController cardHolderName = TextEditingController();
  TextEditingController cvvCode = TextEditingController();

  String? cardId;

  int current = 0;

  final CarouselController controller = CarouselController();
  updateCard(int current) {
    cardId = alCardModel[current].id.toString();
    cardNumber.text = alCardModel[current].last4.toString();
    cardHolderName.text = alCardModel[current].name.toString();
    cvvCode.text = alCardModel[current].cvcCheck.toString();
    expiryDate.text = alCardModel[current].expMonth.toString() + "/" + alCardModel[current].expYear.toString();
    update();
  }

  onPageChange(int index) {
    current = index;
    updateCard(current);
    update();
  }

  getCardsMine() async {
    cardNumber.clear();
    expiryDate.clear();
    cardHolderName.clear();
    cvvCode.clear();
    cardId = null;
    mShowData = ShowData.showLoading;
    // isShowLoader = true;
    update();

    HashMap<String, Object> requestParams = HashMap();

    var categories = await CardRepo().getCards(requestParams);

    categories.fold((failure) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
      mShowData = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      alCardModel = mResult.responseData as List<CardModel>;
      if (alCardModel.isNotEmpty) {
        updateCard(0);
      }
      mShowData = ShowData.showData;
      update();
    });
  }

  addNewCard(String number, int month, int year, String cvc, String name) async {
    mShowData = ShowData.showLoading;

    update(); // isShowLoader = true;

    HashMap<String, Object> requestParams = HashMap();
    requestParams['number'] = number;
    requestParams['exp_month'] = month;
    requestParams['exp_year'] = year;
    requestParams['name'] = name;
    requestParams['cvc'] = cvc;

    var categories = await CardRepo().addCard(requestParams);

    categories.fold((failure) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
      mShowData = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: mResult.responseMessage, toastType: TOAST_TYPE.toastSuccess);
      getCardsMine();
    });
  }

  deletecard(String cardId) async {
    cardNumber.clear();
    expiryDate.clear();
    cardHolderName.clear();
    cvvCode.clear();
    mShowData = ShowData.showLoading;
    update();
    HashMap<String, Object> requestParams = HashMap();
    requestParams['cardId'] = cardId;

    var categories = await CardRepo().deletecard(requestParams);

    categories.fold((failure) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
      mShowData = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: mResult.responseMessage, toastType: TOAST_TYPE.toastSuccess);
      getCardsMine();
    });
  }

  bool isValid() {
    if (!Global.checkNull(cardId)) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: "Invalid Card Details", toastType: TOAST_TYPE.toastError);

      return false;
    }
    return true;
  }

  bookEstimation({String? promotionId, String? time, String? date, String? address, String? cardId, String? note}) async {
    if (!isValid()) return;
    mShowData = ShowData.showLoading;
    update();
    // isShowLoader = true;
    HashMap<String, Object> requestParams = HashMap();
    requestParams['promotionID'] = promotionId!;
    requestParams['paymentType'] = "card";
    requestParams['cardID'] = cardId ?? "0";
    requestParams['address'] = address ?? "";
    requestParams['date'] = date ?? "";
    requestParams['time'] = time!;
    requestParams['note'] = note ?? "";
    var categories = await EstimatesRepo().bookingEstimation(requestParams);
    categories.fold((failure) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
      mShowData = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: mResult.responseMessage, toastType: TOAST_TYPE.toastSuccess);

      mShowData = ShowData.showNoDataFound;
      update();
      Get.offAll(() => ThankYouFragment(isFromPromotion: true));
    });
  }

//----------------------------Partial Payment
  bookEstimationPartial({String? bookingID, String? cardId}) async {
    if (!isValid()) return;
    mShowData = ShowData.showLoading;
    update();
    // isShowLoader = true;
    HashMap<String, Object> requestParams = HashMap();
    requestParams['bookingID'] = bookingID!;
    requestParams['cardID'] = cardId ?? "0";
    requestParams['paymentType'] = "card";
    var categories = await EstimatesRepo().bookingPartialEstimation(requestParams);
    categories.fold((failure) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
      mShowData = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: mResult.responseMessage, toastType: TOAST_TYPE.toastSuccess);

      mShowData = ShowData.showNoDataFound;
      update();
      Get.offAll(() => ThankYouFragment(isFromPromotion: true));
    });
  }

  //----------------------------Fully Amount Pay
  bookEstimationFullPay({String? bookingID, String? cardId}) async {
    if (!isValid()) return;
    mShowData = ShowData.showLoading;
    update();
    // isShowLoader = true;
    HashMap<String, Object> requestParams = HashMap();
    requestParams['bookingID'] = bookingID!;
    requestParams['cardID'] = cardId ?? "0";
    requestParams['paymentType'] = "card";
    var categories = await EstimatesRepo().bookingFullyPayedEstimation(requestParams);
    categories.fold((failure) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
      mShowData = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: mResult.responseMessage, toastType: TOAST_TYPE.toastSuccess);

      mShowData = ShowData.showNoDataFound;
      update();
      Get.offAll(() => ThankYouFragment(isFromPromotion: true));
    });
  }
}
