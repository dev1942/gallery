import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:otobucks/View/MyBookings/view/tabs_views/PendingFragment.dart';
import 'package:otobucks/View/MyBookings/view/tabs_views/cancelled_booking.dart';
import 'package:otobucks/View/MyBookings/view/tabs_views/completed_booking.dart';
import 'package:otobucks/View/MyBookings/view/tabs_views/in_progress_booking.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/View/MyBookings/controller/estimation_screen_controller.dart';

class EstimationFragment extends StatefulWidget {
  const EstimationFragment({Key? key}) : super(key: key);

  @override
  EstimationFragmentState createState() => EstimationFragmentState();
}

class EstimationFragmentState extends State<EstimationFragment>
    with SingleTickerProviderStateMixin {
  var controller = Get.put(EstimationFragmentController());

  @override
  void initState() {
    controller.tabController = TabController(length: 4, vsync: this);
    controller.activeTabIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: AppColors.getMainBgColor(),
            body: GetBuilder<EstimationFragmentController>(
              init: EstimationFragmentController(),
              builder: (value) => Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        color: AppColors.colorBlueStart,
                        height: AppDimens.dimens_85,
                      ),
                      Container(
                        child: TabBar(
                          onTap: (index) => value.changeIndex(index),
                          labelStyle: AppStyle.textViewStyleNormalSubtitle2(
                              context: context, color: AppColors.colorBlack),
                          indicatorColor: AppColors.colorBlueEnd,
                          isScrollable: true,
                          indicatorPadding: const EdgeInsets.only(
                              left: AppDimens.dimens_5,
                              right: AppDimens.dimens_5),
                          padding: EdgeInsets.zero,
                          labelPadding: const EdgeInsets.only(
                              left: AppDimens.dimens_5,
                              right: AppDimens.dimens_5),
                          labelColor: AppColors.colorWhite,
                          unselectedLabelColor: AppColors.colorBlack2,
                          indicator: AppViews.getRoundBorderDecor(
                              mColor: Colors.white, mBorderRadius: 5),
                          indicatorSize: TabBarIndicatorSize.tab,
                          tabs: [
                            tabButtons(
                                title: "Pending",
                                activeindex: value.activeTabIndex,
                                id: 0),
                            tabButtons(
                                title: "In Progress",
                                activeindex: value.activeTabIndex,
                                id: 1),
                            tabButtons(
                                title: "Completed",
                                activeindex: value.activeTabIndex,
                                id: 2),
                            tabButtons(
                                title: "Cancelled",
                                activeindex: value.activeTabIndex,
                                id: 3),
                          ],
                          controller: value.tabController,
                        ),
                        margin: const EdgeInsets.only(
                            top: AppDimens.dimens_10, left: AppDimens.dimens_3),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: value.tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: const [
                        PendingFragment(),
                        InProgressFragment(),
                        CompletedFragment(),
                        CancelledFragment(),
                      ],
                    ),
                  ), // Expanded(child: Container()),
                ],
              ),
            )));
  }

  Widget tabButtons({int? activeindex, int? id, String? title}) {
    return Container(
      decoration: activeindex != id
          ? AppViews.getColorDecor(mColor: Colors.white, mBorderRadius: 5)
          : null,
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width / 5,
      height: AppDimens.dimens_38,
      child: Text(
        title ?? "",
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
      ),
    );
  }
}
