/*// @dart=2.9 */
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/auth/View/login_in_screen.dart';
import 'package:otobucks/app/locator.dart';
import 'package:otobucks/global/theme_data/theme_data.dart';
import 'package:otobucks/helper/local_notifications_helper.dart';
import 'package:otobucks/services/navigation_service.dart';
import 'package:otobucks/View/Home/Views/home_page.dart';
import 'package:otobucks/View/SplashScreen/Views/splash_screen.dart';
import 'package:otobucks/services/localization/localization.dart';
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

  LocalNotificationChannel.initializer();

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
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) =>
          const OverlaySupport(child: BoosterMaterialApp()), // Wrap your app
    ),
  );
}

class BoosterMaterialApp extends StatelessWidget {
  const BoosterMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
