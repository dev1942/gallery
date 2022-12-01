import 'dart:collection';
import 'dart:developer';

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
      print("response----------3----------");

      alEstimates = mResult.responseData as List<EstimatesModel>;
   for(int i=0;i<alEstimates.length;i++){
     print(alEstimates[i].status);
     print(alEstimates[i].offerCreated);
   }
      if (alEstimates.isNotEmpty) {
        mShowData = ShowData.showData;
      } else {
        mShowData = ShowData.showNoDataFound;
      }
      update();
    });
  }

  //----------------------------Create Offer-post Api------------

 createAnOffer({
    String? estimateid,var offerAmount}) async {
    mShowData = ShowData.showLoading;

    update(); // isShowLoader = true;

    HashMap<String, Object> requestParams = HashMap();
    requestParams['estimateID'] = estimateid!;
    requestParams['offerAmount'] = offerAmount;


    var categories = await EstimatesRepo().CreateAnOfferEstimate(requestParams);
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
          strMsg:"Offer Created Successfully",// mResult.responseMessage,
          toastType: TOAST_TYPE.toastSuccess);
      //clearController();
      // getCardsMine();
      //getCarList();
      getEstimation("submitted");
      update();
    });
  }


}
