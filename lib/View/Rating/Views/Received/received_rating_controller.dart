import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/enum.dart';
import '../../../../global/global.dart';
import '../../../../services/repository/rating_repo.dart';
import '../../../Home/Controllers/home_screen_controller.dart';
import '../../model/rating_component_model.dart';

class ReceivedRatingController extends GetxController {
  Rx<ShowData> mShowData = ShowData.showData.obs;

  bool connectionStatus = false;
  // Rx<bool> isShowLoader = false.obs;

  RxList alReviewModel = [].obs;

  Future<void> getRating(BuildContext context) async {
    mShowData.value = ShowData.showLoading;
    update();

    HashMap<String, Object> requestParams = HashMap();
    var categories = await RatingRepo().getRatingsIndividual(requestParams, RatingType.recieved, Get.find<HomeScreenController>().userId);
    categories.fold((failure) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);

      mShowData.value = ShowData.showNoDataFound;

      update();
    }, (mResult) {
      alReviewModel.value = mResult.responseData as List<RatingComponentModel>;

      update();
      if (alReviewModel.value.isNotEmpty) {
        mShowData.value = ShowData.showData;
        log("data found");

        update();
      } else {
        mShowData.value = ShowData.showNoDataFound;

        update();
      }
    });
  }
}
