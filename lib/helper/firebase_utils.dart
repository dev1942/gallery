import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseUtils {
  initFirebase(BuildContext context) {
    FirebaseMessaging.onMessage.listen((event) async {
      await processNotification(event.data, context);
      // var data = jsonEncode(event.data);
      // log("FCM data: $data");
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      //showNotification(event.data);
      await processNotification(event.data, context);
    });
  }

  processNotification(
      Map<String, dynamic> message, BuildContext context) async {
    final prefManager = await SharedPreferences.getInstance();

    String strAppStatus = message["AAP_STATUS"].toString();

    if (Global.checkNull(strAppStatus)) {
      bool appStatus = Global.getStatusFromString(strAppStatus);
      prefManager.setBool(Constants.STATUS, appStatus);
    }
  }

  requestNotificationPermission(FirebaseMessaging firebaseMessaging) {
    firebaseMessaging.requestPermission(sound: true, badge: true, alert: true);
  }
}
