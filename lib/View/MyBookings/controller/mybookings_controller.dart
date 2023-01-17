import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:otobucks/View/MyBookings/Models/view_booking_model.dart'
    as viewBookingModel;
import 'package:otobucks/View/MyBookings/Models/AllBookingsModel.dart'
    as bookingResult;

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:otobucks/View/Chat/Views/chat_detail_screen.dart';
import 'package:otobucks/View/MyBookings/Models/view_booking_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Home/Controllers/home_screen_controller.dart';
import '../../../global/constants.dart';
import '../../../global/enum.dart';
import '../../../global/global.dart';
import '../../../global/url_collection.dart';
import '../../Chat/Models/my_rooms_model.dart';
import '../../../services/repository/chat_repo.dart';
import '../Models/PromotionBookingModel.dart';

class MyBookingsController extends GetxController {
  @override
  //..................variabls..............................

  var log = Logger();
  String? token;
  ShowData mShowData = ShowData.showLoading;
  bool connectionStatus = false;
  bool chatNowLoading = false;
  bool isShowLoader = false;
  String chatNowRoomId = '';
  bool isSearching = false;

  void onInit() {
    // TODO: implement onInit
    super.onInit();
    futurBookings = getAllBookings();
    futurePromotionBookings=getAllPromotionBookings();
    getToken();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  late Future<BookingModel> futurBookings;
  late Future<PromotionBookingHistory> futurePromotionBookings;

  //...............Get All Bookings...........................
  Future<BookingModel> getAllBookings() async {
    final prefManager = await SharedPreferences.getInstance();
    token = prefManager.getString(SharedPrefKey.KEY_ACCESS_TOKEN);
    log.e("token at start is");
    log.e(token);
    final headers = {
      'Authorization': "Bearer $token",
      "Content-Type": "application/json"
    };
    final response = await http.get(Uri.parse(RequestBuilder.API_GET_ALL_BOOKINGS), headers: headers);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      log.i("Get booking API success");
      // log.i(data);
      //
      //
      return BookingModel.fromJson(data);
    } else {
      log.e("Get booking API Failed");
      log.e(response.body);
      log.w(token.toString());
    }
    update();
    return BookingModel.fromJson(data);
  }
  //...............Get All Promotion  Bookings...........................
  Future<PromotionBookingHistory> getAllPromotionBookings() async {
    final prefManager = await SharedPreferences.getInstance();
    token = prefManager.getString(SharedPrefKey.KEY_ACCESS_TOKEN);
    final headers = {
      'Authorization': "Bearer $token",
      "Content-Type": "application/json"
    };
    final response = await http.get(Uri.parse(RequestBuilder.API_GET_PROMOTIONS_HISTORY), headers: headers);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      log.i("Promotion booking success");
      return PromotionBookingHistory.fromJson(data);
    } else {
      log.e("Get promotion booking API Failed");
      log.e(response.body);
      log.w(token.toString());
    }
    return PromotionBookingHistory.fromJson(data);
  }

  //..................Get token...............................
  getToken() async {
    final prefManager = await SharedPreferences.getInstance();
    token = prefManager.getString(SharedPrefKey.KEY_ACCESS_TOKEN);
    //accessToken=token;
  }

  //.................chating methods----------------------------------------------
  createRoom(String userId) async {
    chatNowLoading = true;
    update();
    HashMap<String, Object> requestParams = HashMap();

    var categories = await ChatRepo().createRoom(requestParams, userId);

    categories.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);

      chatNowLoading = false;
      update();
    }, (mResult) {
      chatNowRoomId = mResult.responseData as String;
      getMessages(chatNowRoomId);
    });
  }

  Future<void> refreshBookings() async {
    onInit();
    update();
  }

//------------------------------------------------Get messages--------------------------------------
  getMessages(String roomId) async {
    HashMap<String, Object> requestParams = HashMap();

    var alTransactions = await ChatRepo().getMyRoom(requestParams, roomId);

    alTransactions.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);

      mShowData = ShowData.showNoDataFound;
      update();
    }, (mResult) async {
      chatNowLoading = false;
      MyRoomModel model = mResult.responseData as MyRoomModel;
      if (model.users[0].id == Get.find<HomeScreenController>().userId) {
        Get.to(
            () => ChatDetailScreen(roomUser: model.users[1], roomId: roomId));
      } else {
        Get.to(
            () => ChatDetailScreen(roomUser: model.users[0], roomId: roomId));
      }
      update();
    });
  }

  //------------------------------------Launch whats app send message-----------------------------
  launchWhatsappSendMessage(String? phoneNumber, String? message) {
    var whatsappUrl =
        "whatsapp://send?phone=${phoneNumber}" + "&text=${message}";
    try {
      launch(whatsappUrl);
    } catch (e) {
      //To handle error and display error message

    }
  }

  //---------------------------Search booking------------------------------------------
  List<Result>? pendingsbookinglist;
  List<Result>? filteredBookingList;

  void searchInShop(String query) {
    filteredBookingList = pendingsbookinglist;
    final suggestions = pendingsbookinglist?.where((filteredBooking) {
      String? shopName =
          filteredBooking.source?.title?.toString().toLowerCase();
      final input = query.toLowerCase();
      return shopName!.contains(input);
    }).toList();
    filteredBookingList = suggestions;
    update();
  }

  void searchbyDate(String query) {
    filteredBookingList = pendingsbookinglist;
    final suggestions = pendingsbookinglist?.where((filteredBooking) {
      final shopName = filteredBooking.bookingDetails?.date?.toLowerCase();
      final input = query.toLowerCase();
      return shopName!.contains(input);
    }).toList();
    filteredBookingList = suggestions;
    update();
  }

//-------------------------------------Delete booking API method-------------------
  Future<void> deleteBooking({String? bookingID, m}) async {
    final prefManager = await SharedPreferences.getInstance();
    String? token = prefManager.getString(SharedPrefKey.KEY_ACCESS_TOKEN);
    try {
      final body = json.encode({"bookingID": bookingID});
      log.i("$token");
      log.i("$body");
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      var uriSaveCart =
          Uri.parse("${RequestBuilder.API_DELETE_BOOKING}/${bookingID}");
      http.Response response =
          await http.delete(uriSaveCart, headers: headers, body: body);
      log.i("BodyI sent when delete booking=======>${body}");
      final message = json.decode(response.body.toString());
      //..............Response Ok Part...................................................
      if (response.statusCode == 200) {
        log.i(response.statusCode);
        log.i(
            "Server Response to me while delete booking is======>>${message["message"]}");
        Global.showToastAlert(
            context: Get.context!,
            strTitle: "Deleted",
            strMsg: message["message"].toString(),
            toastType: TOAST_TYPE.toastSuccess);
      }
      //.........................not ok ...................................................
      else {
        Global.showToastAlert(
            context: Get.context!,
            strTitle: "Message",
            strMsg: message["message"].toString(),
            toastType: TOAST_TYPE.toastError);
        log.e(response.statusCode);
        log.e(
            "Server Response to me  while deleting booking =====>>  ${response.body.toString()}");
      }
    } catch (e) {
      Global.showToastAlert(
          context: Get.context!,
          strTitle: "Deleted",
          strMsg: e.toString(),
          toastType: TOAST_TYPE.toastSuccess);

      log.e(
          "Exception is whileremover market shop  is=======>>${e.toString()}");
    }
  }

//------------------------Date picker -------------------------------------
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
