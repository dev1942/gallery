import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:otobucks/global/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future getDate({required String startDate, required String endDate}) async {
  final prefManager = await SharedPreferences.getInstance();
  String? token = prefManager.getString(SharedPrefKey.KEY_ACCESS_TOKEN);
  final headers = {
    'Authorization': "Bearer $token",
    "Content-Type": "application/json"
  };
  String url =
      "https://developmentapi-app.otobucks.com/v1/bookings/bookService?startDate=$startDate&endDate=$endDate";
  Uri urlf = Uri.parse(url);
  try {
    var res = await http.get(urlf, headers: headers);
    print("Token++++++: $token");
    return json.decode(res.body);
  } catch (e) {
    print(e);
    return e;
  }
}
