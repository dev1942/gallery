
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/Home/Controllers/home_screen_controller.dart';
import 'package:otobucks/View/Drawer/Views/drawer_custom.dart';

import '../../../global/app_colors.dart';
import '../../../global/app_views.dart';
import '../../../global/enum.dart';
import '../../../widgets/bottom_bar.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var controller = Get.put(HomeScreenController());
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();



   // controller.getAccountName();

  void onMessage() {
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          // LocalNotificationService.display(message);

        }
      },
    );
  }

  void onListen() {
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
  }

  @override
  void initState() {
    controller.getAccountName();
    onMessage();
    onListen();
    onMessage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(builder: (value) {
      return WillPopScope(
          onWillPop: controller.onWillPop,
          child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
            return Scaffold(
                key: scaffoldKey,
                backgroundColor: AppColors.colorWhite,
                appBar: AppViews.initAppBar(
                  icon: constraints.maxWidth < 600
                      ? null
                      : const Icon(Icons.keyboard_arrow_left),
                  mContext: context,
                  centerTitle: controller.currentPageType == PageType.home ||
                          controller.currentPageType == PageType.home2
                      ? true
                      : false,
                  strTitle: controller.currentPageType == PageType.home ||
                          controller.currentPageType == PageType.home2
                      ? controller.strTitle.tr + controller.firstName
                      : controller.strTitle.tr,
                  isShowNotification: true,
                  isShowSOS: true,
                  menuTap: () {
                    if (controller.currentPageType == PageType.home ||
                        controller.currentPageType == PageType.home2) {
                      scaffoldKey.currentState!.openDrawer();
                    } else {
                      controller.callback(PageType.home);
                    }
                  },
                ),
                
                resizeToAvoidBottomInset: false,
                drawer: constraints.maxWidth > 600 ? null : drawer(context),
                body: constraints.maxWidth > 600
                    ? Row(
                        children: [
                          Expanded(flex: 1, child: drawer(context)),
                          Expanded(
                            flex: 2,
                            child: value.currentPage,
                          )
                        ],
                      )
                    : value.currentPage,
                bottomNavigationBar: BottomBar(
                    indexM: value.indexM,
                    onTap: (int index) => value.onChangeBottomBar(index)));
          }));
    });
  }
}
