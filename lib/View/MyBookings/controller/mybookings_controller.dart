import 'dart:collection';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../global/app_views.dart';
import '../../../global/connectivity_status.dart';
import '../../../global/constants.dart';
import '../../../global/enum.dart';
import '../../../global/global.dart';
import '../../../global/url_collection.dart';
import '../../../model/failure.dart';
import '../../../services/rest_api/request_listener.dart';
import '../Models/AllBookingsModel.dart';

class MyBookingsController extends GetxController {
  @override
  //..................variabls..............................
  var log = Logger();
  String? token;

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

  Future<AllBookingsModel> getAllBookings() async {
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
      return AllBookingsModel.fromJson(data);
    } else {
      log.e("Get booking API Failed");
      log.e(response.body);
      log.w(token.toString());
    }
    update();
    return AllBookingsModel.fromJson(data);
  }

  //..................Get token...............................
  getToken() async {
    final prefManager = await SharedPreferences.getInstance();
    token = prefManager.getString(SharedPrefKey.KEY_ACCESS_TOKEN);
    //accessToken=token;
  }
}
