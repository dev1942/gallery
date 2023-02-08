import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/View/CatAssesories/Models/store_model.dart';
import 'package:otobucks/services/repository/accessories_repo.dart';

class AccessoriesSubCatController extends GetxController {
  ShowData mShowData = ShowData.showNoDataFound;
  List<AccessoriesStoreModel> stores = [];
  Future<void> getStores() async {
    stores.clear();
    mShowData = ShowData.showLoading;
    update();
    HashMap<String, Object> requestParams = HashMap();
    var categories = await AccessoriesRepo().getStores(requestParams);
    categories.fold((failure) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
      mShowData = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      stores = mResult.responseData as List<AccessoriesStoreModel>;
      if (stores.isNotEmpty) {
        mShowData = ShowData.showData;
      } else {
        mShowData = ShowData.showNoDataFound;
      }
      update();
    });
  }

  var showSearch = false;

  TextEditingController searchController = TextEditingController();

  onChangeSearch(String value) {
    if (value.isEmpty) {
      showSearch = false;
      update();
    } else {
      showSearch = true;
      update();
    }
  }
}
