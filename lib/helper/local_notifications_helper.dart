import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationChannel {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static initializer() {
    InitializationSettings initializationSettings =
        const InitializationSettings(
            android: AndroidInitializationSettings('@drawable/ic_notification'),
            iOS: DarwinInitializationSettings(
                onDidReceiveLocalNotification: onDidReceiveLocalNotification));

    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails(
            'high_importance_channel', 'high_importance_channel channal',
            importance: Importance.max, priority: Priority.max));
    await _flutterLocalNotificationsPlugin.show(
        id, title, body, notificationDetails);
    // display a dialog with the notification details, tap ok to go to another page
  }

  static Future<void> display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails = const NotificationDetails(
          android: AndroidNotificationDetails(
              'high_importance_channel', 'high_importance_channel channal',
              importance: Importance.max, priority: Priority.max));
      await _flutterLocalNotificationsPlugin.show(
          id,
          message.notification!.title,
          message.notification!.body,
          notificationDetails);
    } catch (e) {
      log(e.toString());
    }
  }

  // static Future<void> displayScheduled(title, body, DateTime dateTime) async {
  //   try {
  //     final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  //     NotificationDetails notificationDetails = NotificationDetails(
  //         android: AndroidNotificationDetails(
  //             'high_importance_channel', 'high_importance_channel channal',
  //             importance: Importance.max, priority: Priority.max));
  //     await _flutterLocalNotificationsPlugin.zonedSchedule(id, title, body,
  //         tz.TZDateTime.from(dateTime, tz.local), notificationDetails,
  //         payload: "",
  //         androidAllowWhileIdle: true,
  //         uiLocalNotificationDateInterpretation:
  //             UILocalNotificationDateInterpretation.absoluteTime);
  //     log(dateTime.toString());
  //   } catch (e) {
  //     log(e);
  //   }
  // }
}
