import 'dart:collection';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/View/CatCarLoan/Models/auto_loan_model.dart';
import 'package:otobucks/services/repository/auto_loan_repo.dart';

class AutoLoansScreenController extends GetxController {
  ShowData mShowData = ShowData.showNoDataFound;
  List<AutoLoanModel> alSubCategory = [];
  List<AutoLoanModel> alSubCategoryFiltered = [];
  getSubCategory(String categoryId) async {
    alSubCategory.clear();
    alSubCategoryFiltered.clear();
    mShowData = ShowData.showLoading;
    update();

    HashMap<String, Object> requestParams = HashMap();

    var categories = await AutoLoanRepo().getBanks(requestParams, categoryId);

    categories.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
      mShowData = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      alSubCategory = mResult.responseData as List<AutoLoanModel>;
      log(alSubCategory.length.toString());
      alSubCategoryFiltered = mResult.responseData as List<AutoLoanModel>;
      mShowData = ShowData.showData;
      update();
    });
  }

  runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      alSubCategoryFiltered = alSubCategory;
    } else {
      alSubCategoryFiltered = alSubCategory
          .where((user) =>
              user.title.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    // Refresh the UI
    update();
  }
}
