import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/model/estimates_model.dart';
import 'package:otobucks/page/rating/rating_page.dart';
import 'package:otobucks/page/services/estimation/view_estimation.dart';
import 'package:otobucks/services/repository/booking_repo.dart';

import '../../global/global.dart';

class CancelBookingController extends GetxController {
  ShowData mShowData = ShowData.showLoading;
  bool connectionStatus = false;
  bool isShowLoader = false;

  List<EstimatesModel> alEstimates = [];

  getEstimation(String status) async {
    mShowData = ShowData.showLoading;
    update();
    HashMap<String, Object> requestParams = HashMap();

    var categories = await BookingRepo().getBookings(requestParams, status);

    categories.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);

      mShowData = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      alEstimates = mResult.responseData as List<EstimatesModel>;

      if (alEstimates.isEmpty) {
        mShowData = ShowData.showNoDataFound;
      } else {
        mShowData = ShowData.showData;
      }
      update();
    });
  }

  gotoViewEstimation(
      EstimatesModel mEstimatesModel, String screen, BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ViewEstimation(
                  mEstimatesModel: mEstimatesModel,
                  screen: screen,
                )));
  }

  gotoRating(EstimatesModel estimatesModel, BuildContext context) async {
    mShowData = ShowData.showLoading;
    update();
    HashMap<String, Object> requestParams = HashMap();

    var categories = await BookingRepo()
        .getBookingByEstimation(requestParams, estimatesModel.id);

    categories.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
      mShowData = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      GetProviderBooking getProviderBooking =
          mResult.responseData as GetProviderBooking;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RatingScreen(
                    bookingId: getProviderBooking.bookingId,
                    providerId: getProviderBooking.providerId,
                  )));
      mShowData = ShowData.showData;

      update();
    });
  }
}
