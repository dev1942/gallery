import 'dart:collection';
import 'dart:convert';
import 'package:otobucks/View/MyBookings/Models/view_booking_model.dart'as viewBookingModel;
import 'package:otobucks/View/MyBookings/Models/AllBookingsModel.dart' as bookingResult;

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
import '../../../global/app_views.dart';
import '../../../global/connectivity_status.dart';
import '../../../global/constants.dart';
import '../../../global/enum.dart';
import '../../../global/global.dart';
import '../../../global/url_collection.dart';
import '../../Chat/Models/my_rooms_model.dart';
import '../../../services/repository/chat_repo.dart';
import '../../../services/rest_api/request_listener.dart';
import '../Models/AllBookingsModel.dart';

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

  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllBookings();
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

  //...............Get All Bookings...........................
  Future<BookingModel> getAllBookings() async {
    final prefManager = await SharedPreferences.getInstance();
    token = prefManager.getString(SharedPrefKey.KEY_ACCESS_TOKEN);
    log.e("token at start is");

    log.e(token);
    final headers = {
      'Authorization': "Bearer ${token}",
      "Content-Type": "application/json"
    };
    final response = await http.get(
        Uri.parse(
            "https://developmentapi-app.otobucks.com/v1/bookings/bookService"),
        headers: headers);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      log.i("Get booking API success");
      //log.i(data);
      return BookingModel.fromJson(data);
    } else {
      log.e("Get booking API Failed");
      log.e(response.body);
      log.w(token.toString());
    }
    update();
    return BookingModel.fromJson(data);
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
  List<Result> ?pendingsbookinglist;
  void searchInShop(String query){
    List<Result>? filteredBookingList=pendingsbookinglist!;
    final suggestions=pendingsbookinglist?.where((filteredBooking){
      final shopName=filteredBooking.source?.title?.toLowerCase();
      final input=query.toLowerCase();
      return shopName!.contains(input);
    }).toList();
    filteredBookingList=suggestions;
    update();
  }
  /*----------------------Delete booking----------------------------------------*/
  Future<void> deleteBooking({
    String? bookingID,
  }) async {
    final prefManager = await SharedPreferences.getInstance();
    String ? token = prefManager.getString(SharedPrefKey.KEY_ACCESS_TOKEN);
    try {
      final body = json.encode({
        "bookingID":bookingID
      });
      log.i("$token");
      log.i("$body");
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      var uriSaveCart = Uri.parse(RequestBuilder.API_DELETE_Booking);
      http.Response response =
      await http.delete(uriSaveCart, headers: headers, body: body);
      log.i("BodyI sent when remover cart=======>${body}");
      final message = json.decode(response.body.toString());

      log.e("token befor remover cart${token}");
      //ActivityIndicator().showProgressIndicatorDialog();
      //..............Response Ok Part...................................................
      if (response.statusCode == 200) {
        log.i(response.statusCode);
        log.i(
            "Server Response to me while remover market shopis======>>${message["message"]}");
       AppViews.showCustomAlert(context: Get.context!, strTitle: "Deleted", strMessage: "Deleted Successfully",);
      }
      //.........................not ok ...................................................
      else {
        AppViews.showCustomAlert(context: Get.context!, strTitle: "Error", strMessage: "Something went wrong",);
        log.e(response.statusCode);
        log.e(
            "Server Response to me  while remover market shop is =====>>  ${response.body.toString()}");
      }
    } catch (e) {
      AppViews.showCustomAlert(context: Get.context!, strTitle: "Sory", strMessage: "Something went wrong in our end",);

      log.e("Exception is whileremover market shop  is=======>>${e.toString()}");
    }
  }

}
