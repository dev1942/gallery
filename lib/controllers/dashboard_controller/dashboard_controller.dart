import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/controllers/home_screen_controller.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/model/category_model.dart';
import 'package:otobucks/model/promotion_model.dart';
import 'package:otobucks/page/services/service_screen.dart';
import 'package:otobucks/services/repository/categories_repo.dart';

import '../../services/repository/promotions_repo.dart';

class DashboardController extends GetxController {
  Rx<ShowData> mShowData = ShowData.showLoading.obs;

  TextEditingController controllerSearch = TextEditingController();
  ScrollController scrollController = ScrollController();

  bool connectionStatus = false;

  late TabController tabcontroller;

  final PageController controller = PageController();
  int intCurrentPage = 0;
  int intTabPosition = 0;

  List<CategoryModel> alCategory = [];
  List<PromotionsModel> alPromotions = [];

  late CategoryModel mCategoryModel;

  getCategory() async {
    HashMap<String, Object> requestParams = HashMap();

    var categories = await CategoriesRepo().getCategories(requestParams);

    categories.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
      mShowData.value = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      alCategory = mResult.responseData as List<CategoryModel>;
      alCategory = alCategory.reversed.toList();
      mShowData.value = ShowData.showData;
      update();
    });
  }

  getPromotion() async {
    log('promotion called');
    mShowData.value = ShowData.showLoading;
    update();

    HashMap<String, Object> requestParams = HashMap();

    var categories = await PromotionsRepo()
        .getPromotions(requestParams, BannerType.homePage);

    categories.fold((failure) {}, (mResult) {
      alPromotions = mResult.responseData as List<PromotionsModel>;
      update();
    });
    getCategory();
  }

  setCurrentTab(int pagePosition) {
    intCurrentPage = pagePosition;
    controller.animateToPage(pagePosition,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  onTapCategory(CategoryModel mCategoryModel_) {
    Get.find<HomeScreenController>().callback(PageType.home2);
    for (var i = 0; i < alCategory.length; i++) {
      CategoryModel mmCategoryModel = alCategory[i];
      if (Global.equalsIgnoreCase(mmCategoryModel.id, mCategoryModel_.id)) {
        intTabPosition = i;
      }
    }
    mCategoryModel = mCategoryModel_;

    onTapChangeTab(intTabPosition);
    update();
  }

  onTapSubCategory(CategoryModel mSubCategoryModel_, BuildContext context) {
    switch (mSubCategoryModel_.type) {
      case 'service':
        Navigator.push(
            context,
            MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => ServiceScreen(
                    mCategoryModel: mCategoryModel,
                    mSubCategoryModel: mSubCategoryModel_)));
        break;
    }
  }

  onTapChangeTab(int index) {
    mCategoryModel = alCategory[index];
    intTabPosition = index;
    update();
  }

  onPageChange(int position) {
    intCurrentPage = position;
    update();

    if (position == 0) {
      //  widget.updateisUsedOnPopUp(true);
    } else {
      // widget.updateisUsedOnPopUp(false);
    }
  }

  Future<void> initScreen() async {
    await Future.delayed(Duration.zero);
    Get.find<DashboardController>().getPromotion();
  }
}
