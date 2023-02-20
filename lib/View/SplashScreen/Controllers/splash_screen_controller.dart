import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/helper/dynamic_links.dart';
import 'package:otobucks/helper/firebase_utils.dart';
import 'package:otobucks/helper/local_notifications_helper.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../global/connectivity_status.dart';
import '../../../global/constants.dart';

class SplashScreenController extends GetxController {
  late BuildContext context;
  SplashScreenController({required this.context});

  bool connectionStatus = false;
  String strVersionName = "";

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  startTime() async {
    final prefManager = await SharedPreferences.getInstance();

    bool? isStatus = prefManager.getBool(Constants.STATUS) ?? true;
    bool? isLogin = prefManager.getBool(SharedPrefKey.KEY_IS_LOGIN) ?? false;

    var _duration = const Duration(milliseconds: 4200);
    if (!isStatus) return;
    if (isLogin) {
      // navigateToHomePage();
      return Timer(_duration, navigateToHomePage);
    } else {
      //navigateToLogin();
      return Timer(_duration, navigateToLogin);
    }
  }

  Future<void> initConnectivity() async {
    final PackageInfo info = await PackageInfo.fromPlatform();

    try {
      connectionStatus = await ConnectivityStatus.isConnected();
    } catch (e) {
      log(e.toString());
    }

    _packageInfo = info;
    strVersionName = _packageInfo.version;
    if (connectionStatus) {
      startTime();
    } else {
      Global.showNoInternet(context);
    }
  }

  Future<void> pushNotifications() async {
    // 2. Instantiate Firebase Messaging
    FirebaseMessaging _messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else {
      log('User declined or has not accepted permission');
    }
    _messaging.subscribeToTopic('tycoo');
    FirebaseMessaging.instance.getInitialMessage().then((message) {});
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      LocalNotificationChannel.display(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
    FirebaseMessaging.onMessage.listen((event) async {
      await processNotification(event.data, context);
      // var data = jsonEncode(event.data);
      // log("FCM data: $data");
    });
    var token = await _messaging.getToken();
    log('token $token');
  }

  processNotification(Map<String, dynamic> message, BuildContext context) async {
    final prefManager = await SharedPreferences.getInstance();

    String strAppStatus = message["AAP_STATUS"].toString();

    if (Global.checkNull(strAppStatus)) {
      bool appStatus = Global.getStatusFromString(strAppStatus);
      prefManager.setBool(Constants.STATUS, appStatus);
    }
  }

  void navigateToHomePage() {
    Navigator.pushReplacementNamed(context, Constants.ACT_HOME);
    DynamicLinksApi().handleDynamicLink();
  }

  void navigateToLogin() async {
    Navigator.pushReplacementNamed(context, Constants.ACT_LOGIN);
    DynamicLinksApi().handleDynamicLink();
  }

//TOKEN SAMPLE // em-kXo2nQYScUJCA89pHqr:APA91bFVM2rjZf81IFPcGPyj1CNp2vkI7-IEtV5XSzc-TybBAqRa4nl85lAt0VM4Rca6ZSkgVBGueUIM3zb-0IhvLQAFJbhqFNY-TvEwVO93hqldNl9403Axsw4-moHUQnMe8wAFTX8k

  @override
  void onInit() {
    pushNotifications();
    initConnectivity();
    FirebaseUtils().initFirebase(context);
    super.onInit();
  }
}
