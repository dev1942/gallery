import 'dart:collection';

import 'package:get/get.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/model/category_model.dart';
import 'package:otobucks/services/repository/categories_repo.dart';

class ServicesSubCatScreenController extends GetxController {
  ShowData mShowData = ShowData.showLoading;
  List<CategoryModel> alSubCategory = [];
  List<CategoryModel> alSubCategoryFiltered = [];
  getSubCategory(String categoryId) async {
    alSubCategory.clear();
    alSubCategoryFiltered.clear();
    mShowData = ShowData.showLoading;
    update();

    HashMap<String, Object> requestParams = HashMap();

    var categories =
        await CategoriesRepo().getSubCategories(requestParams, categoryId);

    categories.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
      mShowData = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      alSubCategory = mResult.responseData as List<CategoryModel>;
      alSubCategoryFiltered = mResult.responseData as List<CategoryModel>;
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
