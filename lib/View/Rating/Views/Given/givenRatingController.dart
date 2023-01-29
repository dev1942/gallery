import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/global.dart';

import '../../../../global/enum.dart';
import '../../../../services/repository/rating_repo.dart';
import '../../../Home/Controllers/home_screen_controller.dart';
import '../../model/rating_component_model.dart';

class GivenRatingController extends GetxController {
  Rx<ShowData> mShowData = ShowData.showData.obs;

  bool connectionStatus = false;
  bool isShowLoader = false;

  RxList alReviewModel = [].obs;

  getRating(BuildContext context) async {
    mShowData.value = ShowData.showLoading;
    update();

    HashMap<String, Object> requestParams = HashMap();

    var categories = await RatingRepo().getRatingsIndividual(requestParams, RatingType.given, Get.find<HomeScreenController>().userId);

    categories.fold((failure) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);

      mShowData.value = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      alReviewModel.value = mResult.responseData as List<RatingComponentModel>;
      mShowData.value = ShowData.showData;
      update();
    });
  }
}
