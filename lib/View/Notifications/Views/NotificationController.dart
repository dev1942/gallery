// ignore_for_file: file_names

import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../global/constants.dart';
import '../../../global/enum.dart';
import '../../../global/global.dart';
import '../../../preferences/preferences.dart';
import '../../../services/repository/notification_repo.dart';
import '../Models/notification_model.dart';

class NotificationsController extends GetxController {
  int numberOfNotifications = 0;
  Rx<ShowData> mShowData = ShowData.showLoading.obs;

  bool connectionStatus = false;
  bool isShowLoader = false;
  String userImage = "", userName = "";
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  Preferences preferences = Preferences();

  List<NotificationModel> alNotification = [];

  Future<void> initConnectivity(BuildContext context) async {
    final prefManager = await SharedPreferences.getInstance();

    String? userImage_ = prefManager.getString(SharedPrefKey.KEY_USER_IMAGE);
    String? _userFirstName = prefManager.getString(SharedPrefKey.KEY_FIRST_NAME);
    String? _userLastImage = prefManager.getString(SharedPrefKey.KEY_LAST_NAME);

    if (Global.checkNull(userImage_)) {
      userImage = userImage_!;
    }
    if (Global.checkNull(_userFirstName) && Global.checkNull(_userLastImage)) {
      userName = _userFirstName! + " " + _userLastImage!;
    }

    update();

    // setState(() {
    //   if (connectionStatus) {
    //mShowData = ShowData.SHOW_DATA;
    if (alNotification.isEmpty) {
      getNotifications(context);
      update();
    }

    // } else {
    //   Global.showNoInternetDialog(context);
    // }
    // });
  }

  Future<void> getNotifications(BuildContext context) async {
    mShowData.value = ShowData.showLoading;
    update();

    HashMap<String, Object> requestParams = HashMap();

    var categories = await NotificationsRepo().getNotifications(requestParams);

    categories.fold((failure) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);

      mShowData.value = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      alNotification = mResult.responseData as List<NotificationModel>;
      update();

      if (alNotification.isNotEmpty) {
        mShowData.value = ShowData.showData;

        if (preferences.getnotificationId() != alNotification.last.id) {
          preferences.setNotificationId(alNotification.last.id);
          // createanddisplaynotification(title: alNotification.last.title, body: alNotification.last.title, payload: alNotification.last.id);
          update();
        }
      } else {
        mShowData.value = ShowData.showNoDataFound;
        update();
      }
      update();
    });
  }

  static void createanddisplaynotification({required String title, required String body, required String payload}) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "pushnotificationapp",
          "pushnotificationappchannel",
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      await _notificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails,
        payload: payload,
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
