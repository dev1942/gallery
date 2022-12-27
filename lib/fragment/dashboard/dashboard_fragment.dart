import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/Promotion_discount/View/banner_page_view.dart';
import 'package:otobucks/controllers/dashboard_controller/dashboard_controller.dart';

import '../../global/app_colors.dart';
import '../../global/app_dimens.dart';
import '../../global/app_views.dart';
import '../../widgets/banner_page_view.dart';
import 'dashboard_item_list.dart';

class DashboardFragment extends StatefulWidget {
  const DashboardFragment({Key? key}) : super(key: key);

  @override
  DashboardFragmentState createState() => DashboardFragmentState();
}

class DashboardFragmentState extends State<DashboardFragment> {
  var controller = Get.put(DashboardController());

  @override
  void initState() {
    controller.initScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.getMainBgColor(),
        body: Obx(() => AppViews.getSetData(
            context, controller.mShowData.value, mShowWidget(controller))));
  }

  Widget mShowWidget(controller) => ListView(
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
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(
                        bottom: AppDimens.dimens_14,
                        top: AppDimens.dimens_14,
                        left: AppDimens.dimens_20,
                        right: AppDimens.dimens_20),
                    // height: AppDimens.dimens_190,
                    child: BannerPageView(
                      alPromotions: controller.alPromotions,
                    ),
                  ),
                  DashboardItemList(),
                ],
              ),
            ],
          ),
        ],
      );
}
