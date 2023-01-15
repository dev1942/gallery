// @dart=2.9
import 'dart:async';
import 'dart:collection';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otobucks/View/Notifications/Models/notification_model.dart';
import 'package:otobucks/View/auth/View/login_in_screen.dart';
import 'package:otobucks/app/locator.dart';
import 'package:otobucks/global/theme_data/theme_data.dart';
import 'package:otobucks/helper/firebase_utils.dart';
import 'package:otobucks/helper/local_notifications_helper.dart';
import 'package:otobucks/preferences/preferences.dart';
import 'package:otobucks/services/navigation_service.dart';
import 'package:otobucks/View/Home/Views/home_page.dart';
import 'package:otobucks/View/SplashScreen/Views/splash_screen.dart';
import 'package:otobucks/services/localization/localization.dart';
import 'package:otobucks/services/repository/notification_repo.dart';
import 'package:overlay_support/overlay_support.dart';
import 'app/bindings/initial_binding.dart';
import 'global/adaptive_helper.dart';
import 'global/constants.dart';

class Controller extends GetxController {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }
}

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification.title);
}

Preferences preferences = Preferences();
final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

void createanddisplaynotification({String title, String body, String payload}) async {
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
    print(e);
  }
}

getNotifications() async {
  List alNotification = [];
  HashMap<String, Object> requestParams = HashMap();
  var categories = await NotificationsRepo().getNotifications(requestParams);
  categories.fold((failure) {}, (mResult) {
    alNotification = mResult.responseData as List<NotificationModel>;
    if (alNotification.isNotEmpty) {
      if (preferences.getnotificationId() != alNotification.last.id) {
        preferences.setNotificationId(alNotification.last.id);
        createanddisplaynotification(body: alNotification.last.title, payload: alNotification.last.id);
      }
    } else {}
  });
}

// void onStart() {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   final service = FlutterBackgroundService();
//   service.setForegroundMode(false);
//
// }

void onStart() {
  WidgetsFlutterBinding.ensureInitialized();
  final service = FlutterBackgroundService();
  service.startService().then((value) {
    Timer.periodic(const Duration(seconds: 30), (value) {
      print("Check");
      getNotifications();
    });
  });
}


// late Directory appDocsDir;
Future<void> main() async {
  Get.put(Controller());
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(

      // options: const FirebaseOptions(
      //     apiKey: 'AIzaSyDC4XfvaeaCZWtDL1x4ofgou9V8vOQvkBg',
      //     appId: '1:443053986656:web:a3aa37766cd5063690c405',
      //     messagingSenderId: '443053986656',
      //     projectId: 'otobucks-43859')
      );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationChannel.initializer();
  onStart();

  // Get any initial links
  await configure();

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // You should get the Application Documents Directory only once.
  // WidgetsFlutterBinding.ensureInitialized();
  // appDocsDir = await getApplicationDocumentsDirectory();
  await GetStorage.init();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const OverlaySupport(child: BoosterMaterialApp()), // Wrap your app
    ),
  );
}

class BoosterMaterialApp extends StatelessWidget {
  const BoosterMaterialApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
      ],
    );
    return LayoutBuilder(
      builder: (context, constrainst) {
        Responsive.init(constrainst.maxHeight, constrainst.maxWidth);
        return GetMaterialApp(
          themeMode: ThemeMode.light,
          translations: LocaleLanguages(),
          fallbackLocale: const Locale('en', 'US'),
          locale: const Locale('en', 'US'),
          defaultTransition: Transition.cupertino,
          navigatorKey: NavigationService.navigationKey,
          darkTheme: BoosterThemeData(context).dark,
          theme: BoosterThemeData.of(context).light,
          debugShowCheckedModeBanner: false,
          initialBinding: InitialBinding(),
          home: const SplashScreen(),
          //home: NotificationDetails(notificationModel: notificationModel),
          builder: (context, child) {
            //ignore system scale factor
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.0,
              ),
              child: child ?? Container(),
            );
          },
          routes: <String, WidgetBuilder>{
            Constants.ACT_LOGIN: (BuildContext context) => const LogInScreen(),
            Constants.ACT_HOME: (BuildContext context) => const HomePage(),
          },
        );
      },
    );
  }
}
