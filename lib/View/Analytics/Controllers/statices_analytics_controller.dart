// ignore_for_file: unnecessary_overrides

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:otobucks/View/Analytics/model/analytics_model.dart';
import 'package:otobucks/global/url_collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../global/constants.dart';
import '../../../global/enum.dart';

class StaticesAnalyticsController extends GetxController {
  //..................variabls..............................

  var log = Logger();
  String? token;
  ShowData mShowData = ShowData.showLoading;
  bool connectionStatus = false;
  bool isShowLoader = false;
  @override
  void onInit() {
    super.onInit();
    fetchdata();
    getToken();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //...............Get All Bookings...........................
//event
  //var analyModel=  analyticsDataModel().obs;
  var isLoading = true.obs;
  Future<AnalyticsDataModel?> fetchdata() async {
    final prefManager = await SharedPreferences.getInstance();
    token = prefManager.getString(SharedPrefKey.KEY_ACCESS_TOKEN);
    try {
      isLoading(true);
      // var response = await NetworkApi.eventList();
      final headers = {'Authorization': "Bearer $token", "Content-Type": "application/json"};
      final response = await http.get(Uri.parse(RequestBuilder.API_GET_STATISTICS), headers: headers);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        log.i("Get analytics api success");
        log.i(data);
        return AnalyticsDataModel.fromJson(data);
      } else {
        log.e("Get Analytics  API Failed");
        log.e(response.body);
        log.w(token.toString());
        update();
        return null;
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
