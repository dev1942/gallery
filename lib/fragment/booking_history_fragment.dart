import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/controllers/booking_history_controllers/booking_history_fargment_controller.dart';
import 'package:otobucks/fragment/booking_list_fragments/cancelled_booking.dart';
import 'package:otobucks/fragment/booking_list_fragments/completed_booking.dart';
import 'package:otobucks/fragment/booking_list_fragments/in_progress_booking.dart';
import 'package:otobucks/fragment/booking_list_fragments/pending_booking.dart';

import '../../../global/app_colors.dart';
import '../../../global/app_dimens.dart';
import '../../../global/app_style.dart';
import '../../../global/app_views.dart';

class BookingHistoryFragment extends StatefulWidget {
  const BookingHistoryFragment({Key? key}) : super(key: key);

  @override
  BookingHistoryFragmentState createState() => BookingHistoryFragmentState();
}

class BookingHistoryFragmentState extends State<BookingHistoryFragment>
    with SingleTickerProviderStateMixin {
  var controller = Get.put(BookingHistoryController());

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
    double width = size.width / 4;

    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: AppColors.getMainBgColor(),
            body: GetBuilder<BookingHistoryController>(
              init: BookingHistoryController(),
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
                          indicatorSize: TabBarIndicatorSize.label,
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
                                "In Progress",
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
                                "Completed",
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
                                "Cancelled",
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
                        PendingBooking(
                          status: 'pending',
                          screen: 'pending',
                        ),
                        InProgressBooking(
                          status: 'inProgress',
                          screen: 'InProgress',
                        ),
                        CompletedBooking(
                          status: 'completed',
                          screen: 'complete',
                        ),
                        CancelledBooking(
                          status: 'cancelled',
                          screen: 'cancelled',
                        ),

                        // InProgressJobTab(alEstimates: alEstimatesInProgress),
                        // CompletedJobTab(alEstimates: alEstimatesCompleted),
                        // CancelledJobTab(alEstimates: alEstimatesCancelled),
                      ],
                    ),
                  ),
                  // Expanded(child: Container()),
                ],
              ),
            )));
  }
}
