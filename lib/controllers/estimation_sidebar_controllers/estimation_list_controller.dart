import 'dart:collection';

import 'package:get/get.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/model/estimates_model.dart';
import 'package:otobucks/services/repository/estimates_repo.dart';

class EstimationListController extends GetxController {
  ShowData mShowData = ShowData.showLoading;
  bool connectionStatus = false;
  bool isShowLoader = false;

  int indexM = 0;
  List<EstimatesModel> alEstimates = [];

  Future getEstimation(String status) async {
    mShowData = ShowData.showLoading;
    update();
    // isShowLoader = true;

    HashMap<String, Object> requestParams = HashMap();

    var categories = await EstimatesRepo().getEstimates(requestParams, status);

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

      if (alEstimates.isNotEmpty) {
        mShowData = ShowData.showData;
      } else {
        mShowData = ShowData.showNoDataFound;
      }
      update();
    });
  }
}
