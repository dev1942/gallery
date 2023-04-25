import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/Dashboard/Controllers/dashboard_controller.dart';
import 'package:otobucks/View/Dashboard/Views/dashboard_sub_category_item_list.dart';
import 'package:otobucks/View/Promotion_discount/View/banner_page_view.dart';

import '../../../global/app_colors.dart';
import '../../../global/app_dimens.dart';
import '../../../global/app_views.dart';

class DashboardFragmentPageTwo extends StatefulWidget {
  const DashboardFragmentPageTwo({Key? key}) : super(key: key);

  @override
  DashboardFragmentPageTwoState createState() => DashboardFragmentPageTwoState();
}

class DashboardFragmentPageTwoState extends State<DashboardFragmentPageTwo> {
  var controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController()).isHomePage = false;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.getMainBgColor(),
        body: Obx(() => AppViews.getSetData(context, controller.mShowData.value, mShowWidget(controller))));
  }

  Widget mShowWidget(DashboardController controller) => ListView(
        children: [
          Stack(
            children: [
              Container(
                color: AppColors.colorBlueStart,
                width: double.infinity,
                height: AppDimens.dimens_170,
              ),
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  controller.alPromotions.where((element) => element.location == "servicePage").toList().isNotEmpty
                      ? Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(
                              bottom: AppDimens.dimens_14, top: AppDimens.dimens_14, left: AppDimens.dimens_10, right: AppDimens.dimens_10),
                          child: BannerPageView(
                            alPromotions: controller.alPromotions,
                          ),
                        )
                      : SizedBox(
                          height: 20,
                        ),
                  const DashboardSubCategoryList(),
                ],
              ),
            ],
          ),
        ],
      );
}
