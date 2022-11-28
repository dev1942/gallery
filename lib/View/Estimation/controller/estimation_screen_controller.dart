import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/enum.dart';

class EstimationFragmentController extends GetxController {
  ShowData mShowData = ShowData.showLoading;

  bool connectionStatus = false;
  bool isShowLoader = false;

  int indexM = 0;
  int activeTabIndex = 0;
  TabController? tabController;

  changeIndex(int index) {
    activeTabIndex = index;
    update();
  }
}
