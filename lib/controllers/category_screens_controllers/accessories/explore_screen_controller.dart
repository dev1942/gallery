import 'dart:collection';

import 'package:get/get.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/model/accessories/product_model.dart';
import 'package:otobucks/services/repository/accessories_repo.dart';

class StoreExploreController extends GetxController {
  ShowData mShowData = ShowData.showNoDataFound;
  List<StoreProductModel> products = [];
  getProductsByStore(String storeId) async {
    products.clear();

    mShowData = ShowData.showLoading;
    update();

    HashMap<String, Object> requestParams = HashMap();

    var categories =
        await AccessoriesRepo().getProductsByStore(requestParams, storeId);

    categories.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
      mShowData = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      products = mResult.responseData as List<StoreProductModel>;
      if (products.isNotEmpty) {
        mShowData = ShowData.showData;
      } else {
        mShowData = ShowData.showNoDataFound;
      }
      update();
    });
  }
}
