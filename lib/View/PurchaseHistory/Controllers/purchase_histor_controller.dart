import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/View/Transactions/Models/transaction_model.dart';
import 'package:otobucks/services/repository/transaction_repo.dart';

class PurchaseHistorController extends GetxController {
  ShowData mShowData = ShowData.showLoading;

  bool isShowLoader = false;

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

    var alTransactions =
        await TransactionRepo().getPurchaseHistory(requestParams);

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
}
