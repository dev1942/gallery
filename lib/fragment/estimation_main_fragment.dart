import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/controllers/estimation_sidebar_controllers/estimation_fragment_controller.dart';
import 'package:otobucks/fragment/estimation_list.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';

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
    var size = MediaQuery.of(context).size;
    var style = const TextStyle(fontSize: 11, fontWeight: FontWeight.w500);
    double height = AppDimens.dimens_38;
    double width = size.width / 5;

    return SafeArea(
        top: false,
        bottom: false,
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
                            Container(
                              decoration: value.activeTabIndex != 0
                                  ? AppViews.getColorDecor(
                                      mColor: Colors.white, mBorderRadius: 5)
                                  : null,
                              alignment: Alignment.center,
                              width: width,
                              height: height,
                              child: Text(
                                "Pending",
                                style: style,
                              ),
                            ),
                            Container(
                              decoration: value.activeTabIndex != 1
                                  ? AppViews.getColorDecor(
                                      mColor: Colors.white, mBorderRadius: 5)
                                  : null,
                              alignment: Alignment.center,
                              width: width,
                              height: height,
                              child: Text(
                                "Partial Paid",
                                style: style,
                              ),
                            ),
                            Container(
                              decoration: value.activeTabIndex != 2
                                  ? AppViews.getColorDecor(
                                      mColor: Colors.white, mBorderRadius: 5)
                                  : null,
                              alignment: Alignment.center,
                              width: width,
                              height: height,
                              child: Text(
                                "Full Paid",
                                style: style,
                              ),
                            ),
                            Container(
                              decoration: value.activeTabIndex != 3
                                  ? AppViews.getColorDecor(
                                      mColor: Colors.white, mBorderRadius: 5)
                                  : null,
                              alignment: Alignment.center,
                              width: width,
                              height: height,
                              child: Text(
                                "Declined",
                                style: style,
                              ),
                            ),
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
                        EstimationListFragment(
                          estimationStatus: 'submitted',
                          screen: 'submitted',
                        ),
                        EstimationListFragment(
                          estimationStatus: 'inProgress',
                          screen: 'partial',
                        ),
                        EstimationListFragment(
                          estimationStatus: 'completed',
                          screen: 'complete',
                        ),
                        EstimationListFragment(
                          estimationStatus: 'declined',
                          screen: 'decline',
                        ),
                      ],
                    ),
                  ),
                  // Expanded(child: Container()),
                ],
              ),
            )));
  }
}
