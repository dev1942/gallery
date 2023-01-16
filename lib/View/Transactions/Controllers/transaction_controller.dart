import 'dart:collection';
import 'package:intl/intl.dart';
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
  bool isSearching=false;
  bool isRangePicked = false;
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

  //-------------------Search filteres---------------------------------
  List<TransactionModel>? filteredBookingList;
  void searchInShop(String query){
    filteredBookingList=transactions;
    final suggestions=transactions.where((filteredBooking){
      final shopName=filteredBooking.amount.toString().toLowerCase();
      final input=query.toLowerCase();
      return shopName.contains(input);
    }).toList();
    filteredBookingList=suggestions;
    update();
  }
  void searchbyDate(String query){
    filteredBookingList=transactions;
    final suggestions=transactions.where((filteredBooking){
      final shopName=filteredBooking.createdAt.toLowerCase();
      final input=query.toLowerCase();
      return shopName!.contains(input);
    }).toList();
    filteredBookingList=suggestions;
    update();
  }
  //................Save and launch file...........................................

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    final path = (await getExternalStorageDirectory())?.path;
    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open('$path/$fileName');

  }
  DateTime selectedDate = DateTime.now();
  TextEditingController datePickerController = TextEditingController();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      //----
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(selectedDate);
      datePickerController.text = formatted;
      isSearching = true;
      searchbyDate(datePickerController.text);
      update();
    }
  }
}
