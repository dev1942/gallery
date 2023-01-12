import 'dart:collection';


import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/services/repository/estimates_repo.dart';

import 'mybookings_controller.dart';

class EstimationFragmentController extends GetxController {
  ShowData mShowData = ShowData.showLoading;

  bool connectionStatus = false;
  bool isShowLoader = false;
  var endDate;
  var startDate;
  bool isRangePicked=false;
  int indexM = 0;
  int activeTabIndex = 0;
  TabController? tabController;

  changeIndex(int index) {
    activeTabIndex = index;
    update();
  }


  RatingBooking({required String? reason,required int ratingstarts  ,required String id,required BuildContext context}) async {
   // setState(() {
      mShowData = ShowData.showLoading;
      // isShowLoader = true;
    //});

    HashMap<String, Object> requestParams = HashMap();
    requestParams['bookingID'] = id;
    requestParams['review'] = reason??"";
    requestParams['stars'] = ratingstarts;

    var categories = await EstimatesRepo().ratingBookingRepo(
      requestParams);
    categories.fold((failure) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
      //setState(() {
        mShowData = ShowData.showNoDataFound;
     // });
    }, (mResult) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: mResult.responseMessage,
          toastType: TOAST_TYPE.toastSuccess);
      //setState(() {
        mShowData = ShowData.showNoDataFound;
     // });
      Get.back();
      //Get.find<EstimationListController>().getEstimation('submitted');
    });
  }
  MyBookingsController bookingController = MyBookingsController();

  //............................Date range pcker............................
  dateRangerPicker(){

    showCustomDateRangePicker(
      Get.context!,
      dismissible: true,
      minimumDate: DateTime.now(),
      maximumDate: DateTime.now().add(const Duration(days: 30)),
      endDate: endDate,
      startDate: startDate,
      onApplyClick: (start, end) async {
                 isRangePicked=true;
        endDate = end;
        startDate = start;
        await bookingController.getAllBookings(startDate: startDate,endDate: endDate);
        update();

      },
      onCancelClick: () {
isRangePicked=false;
        endDate = null;
        startDate = null;
        update();
      },
    );
  }
}
