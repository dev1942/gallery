import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/Services_All/Views/service_detail_screen.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/View/Services_All/Models/service_model.dart';
import 'package:otobucks/services/repository/services_repo.dart';

class ServiceScreenController extends GetxController {
  ShowData mShowData = ShowData.showLoading;
  bool connectionStatus = false;
  int intCurrentPage = 0;
  List<ServiceModel> alServices = [];
  TextEditingController controllerSearch = TextEditingController();
  int indexM = 0;
  getServiceProvider(catId, subCatId) async {
    mShowData = ShowData.showLoading;
    // isShowLoader = true;
    update();

    HashMap<String, Object> requestParams = HashMap();

    var categories = await ServicesRepo()
        .getServices(requestParams, catId: catId, subCatId: subCatId);

    categories.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);

      mShowData = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      alServices = mResult.responseData as List<ServiceModel>;
      if (alServices.isNotEmpty) {
        mShowData = ShowData.showData;
      } else {
        mShowData = ShowData.showNoDataFound;
      }
    });
    update();
  }

  gotoServiceDetail(ServiceModel mServiceModel, BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ServiceDetailScreen(mServiceModel: mServiceModel)));
  }
}
