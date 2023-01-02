import 'dart:collection';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:otobucks/View/Analytics/model/analytics_model.dart';
import 'package:otobucks/View/Chat/Views/chat_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
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


class StaticesAnalyticsController extends GetxController {
  @override
  //..................variabls..............................

   var log = Logger();
  String? token;
  ShowData mShowData = ShowData.showLoading;
  bool connectionStatus = false;
  bool isShowLoader = false;




  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchdata();
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
//event
  //var analyModel=  analyticsDataModel().obs;
  var isLoading = true.obs;
  Future<analyticsDataModel?> fetchdata() async {
    final prefManager = await SharedPreferences.getInstance();
    token = prefManager.getString(SharedPrefKey.KEY_ACCESS_TOKEN);
    try {
      isLoading(true);
     // var response = await NetworkApi.eventList();
      final headers = {
        'Authorization': "Bearer ${token}",
        "Content-Type": "application/json"
      };
      final response = await http.get(
          Uri.parse(
              "https://developmentapi-app.otobucks.com/v1/auth/customers/dashboard/statistics"),
          headers: headers);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        log.i("Get booking API success");
        return analyticsDataModel.fromJson(data);
      } else {
       log.e("Get Analytics  API Failed");
       log.e(response.body);
        log.w(token.toString());
        update();

      }
    } finally {
      isLoading(false);
    }
  }

  //..................Get token...............................
  getToken() async {
    final prefManager = await SharedPreferences.getInstance();
    token = prefManager.getString(SharedPrefKey.KEY_ACCESS_TOKEN);
    //accessToken=token;
  }
}
