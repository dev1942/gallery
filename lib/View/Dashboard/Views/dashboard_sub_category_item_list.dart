// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/CatAssesories/Views/auto_repair_sub_cat_screen.dart';
import 'package:otobucks/View/CatCarLoan/Views/car_loan_sub_cat.dart';
import 'package:otobucks/View/CatCarSell/Views/filter_screen.dart';
import 'package:otobucks/View/Dashboard/Controllers/dashboard_controller.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_images.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/constants.dart';
import '../Models/category_model.dart';
import '../../../widgets/custom_textfield_with_icon.dart';
import '../../../widgets/fade_in_image.dart';
import '../../CatAssesories/Views/acessories_sub_cat_screen.dart';

class DashboardSubCategoryList extends StatefulWidget {
  const DashboardSubCategoryList({
    Key? key,
  }) : super(key: key);

  @override
  DashboardSubCategoryListState createState() =>
      DashboardSubCategoryListState();
}

class DashboardSubCategoryListState extends State<DashboardSubCategoryList>
    with SingleTickerProviderStateMixin {
  var controller = Get.put(DashboardController());

  @override
  void initState() {
    super.initState();
    controller.tabcontroller = TabController(
        vsync: this, length: controller.alCategory.length, initialIndex: 0);
    controller.tabcontroller.animateTo(controller.intTabPosition);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (value) {
          return ListView(
            controller: value.scrollController,
            shrinkWrap: true,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(
                    left: AppDimens.dimens_15,
                    bottom: AppDimens.dimens_10,
                    right: AppDimens.dimens_15),
                child: CustomTextFieldWithIcon(
                  textInputAction: TextInputAction.next,
                  enabled: true,
                  controller: value.controllerSearch,
                  keyboardType: TextInputType.emailAddress,
                  hintText: Constants.STR_SEARCH.tr,
                  inputFormatters: const [],
                  obscureText: false,
                  onChanged: (String value) {},
                  suffixIcon: InkWell(
                    child: Image.asset(
                      AppImages.ic_search,
                      width: AppDimens.dimens_18,
                    ),
                    onTap: () {},
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Categories".tr,
                  style: AppStyle.textViewStyleLarge(
                      fontWeightDelta: 1,
                      fontSizeDelta: 2,
                      context: context, color: AppColors.colorYellowShade),
                ),
              ),
              TabBar(
                onTap: (index) => value.onTapChangeTab(index),
                isScrollable: true,
                controller: value.tabcontroller,
                physics: const BouncingScrollPhysics(),
                labelColor: AppColors.colorBlueStart,
                unselectedLabelColor:
                    AppColors.colorTextFieldHint.withOpacity(0.6),
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide.none,
                ),
                indicatorColor: AppColors.colorBlueStart,
                labelStyle: AppStyle.textViewStyleXSmall(
                    context: context,
                    color: AppColors.colorBlueStart,
                    fontWeightDelta: 2,
                    fontSizeDelta: 0),
                automaticIndicatorColorAdjustment: false,
                tabs: [
                  for (CategoryModel mCategoryModel in value.alCategory)
                    Tab(
                        height: 130,
                        text: mCategoryModel.title,
                        icon: Card(
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppDimens.dimens_10)),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color: AppColors.colorYellowShade,
                                borderRadius:
                                    BorderRadius.circular(AppDimens.dimens_10)),
                            width: 80,
                            height: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                AppDimens.dimens_8,
                              ),
                              child: NetworkImageCustom(
                                  image: mCategoryModel.image,
                                  height: AppDimens.dimens_60,
                                  width: AppDimens.dimens_60),
                            ),
                          ),
                        )),
                ],
              ),
              const Divider(
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Sub Categories".tr,
                  style: AppStyle.textViewStyleLarge(
                      context: context, color: AppColors.colorYellowShade,
                  fontWeightDelta: 1,
                  fontSizeDelta: 2),
                ),
              ),
              IndexedStack(
                  index: value.intTabPosition,
                  sizing: StackFit.loose,
                  children: List.generate(
                      controller.alCategory.length,
                      (index) => Visibility(
                            child: getRespectiveTabs(
                                controller.alCategory[index].title),
                            maintainState: false,
                            visible: value.intTabPosition == index,
                          ))),
            ],
          );
        });
  }

  Widget getRespectiveTabs(String catName) {
    switch (catName) {
      case 'Auto Repair Services':
        return AutoRepairSubCatScreen(
            mCategoryModel: controller.mCategoryModel);
      case 'Auto Loans':
        return AutoLoansScreen(categoryModel: controller.mCategoryModel);
      // return comingSoon();
      case 'Auto Spare Parts':
        return const AccessoriesSubCatScreen();
      case 'Sell a car':
        return const CarSellFilters();
    }
    return comingSoon();
  }

  Widget comingSoon() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      alignment: Alignment.topCenter,
      child: const Text('Coming soon'),
    );
  }
}
