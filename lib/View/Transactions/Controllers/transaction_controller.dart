import 'dart:collection';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/View/Transactions/Models/transaction_model.dart';
import 'package:otobucks/services/repository/transaction_repo.dart';

class TransactionController extends GetxController {
  ShowData mShowData = ShowData.showLoading;

  bool connectionStatus = false;
  bool isShowLoader = false;
  var endDate;
  var startDate;
  bool isRangePicked=false;
  List<TransactionModel> transactions = [];

  TextEditingController controllerName = TextEditingController();

  TextEditingController controllerPrice = TextEditingController();

  FocusNode nodeName = FocusNode();
  FocusNode nodePrice = FocusNode();
  final List<String> items = ['All', 'Paid', 'Fail', 'In Progress'];
  String selectedValue = "All";

  getTransactions() async {
    transactions.clear();
    mShowData = ShowData.showLoading;
    // isShowLoader = true
    update();

    HashMap<String, Object> requestParams = HashMap();

    var alTransactions = await TransactionRepo().getTransactions(requestParams);

    alTransactions.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);

      mShowData = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      transactions = mResult.responseData as List<TransactionModel>;
      mShowData = ShowData.showData;
      update();
    });
  }
  //-------------------Date range picker---------------------------------
  dateRangerPicker(){

    showCustomDateRangePicker(
      Get.context!,
      dismissible: true,
      minimumDate: DateTime.now(),
      maximumDate: DateTime.now().add(const Duration(days: 30)),
      endDate: endDate,
      startDate: startDate,
      onApplyClick: (start, end) {
        isRangePicked=true;
        endDate = end;
        startDate = start;
        DateTime now = DateTime.now();
        startDate= new DateTime(now.year, now.month, now.day,);
        endDate= new DateTime(now.year, now.month, now.day,);

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
  //................Save and launch file...........................................


  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    final path = (await getExternalStorageDirectory())?.path;
    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open('$path/$fileName');
  }
}
