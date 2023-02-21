// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/Home/Controllers/home_screen_controller.dart';
import 'package:otobucks/View/Drawer/Views/drawer_custom.dart';

import '../../../global/app_colors.dart';
import '../../../global/app_dimens.dart';
import '../../../global/app_style.dart';
import '../../../global/app_views.dart';
import '../../../global/enum.dart';
import '../../../widgets/bottom_bar.dart';
import '../../Notifications/Views/NotificationController.dart';

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
        log("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          log(message.notification!.title.toString());
          log(message.notification!.body.toString());
          log("message.data11 ${message.data}");
          // LocalNotificationService.display(message);

        }
      },
    );
  }

  void onListen() {
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        log("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          log(message.notification!.title.toString());
          log(message.notification!.body.toString());
          log("message.data22 ${message.data['_id']}");
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
    // var notificationController = Get.put(NotificationsController());
    return GetBuilder<HomeScreenController>(builder: (value) {
      return WillPopScope(
          onWillPop: controller.onWillPop,
          child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
            return Scaffold(
                key: scaffoldKey,
                backgroundColor: AppColors.colorWhite,
                //Get Date Function++++++++++++++++++++++++++++++++++++++++++++
                // floatingActionButton: FloatingActionButton(
                //   onPressed: () async {
                //     log("Test");
                //     var data = await getDate(
                //         startDate: DateTime.now().toString(),
                //         endDate: DateTime.now().toString());
                //     log(DateTime.now().toString());
                //     log("::::::::::::::::::::::::::::::: ${data}");
                //     log(
                //         "::::::::::::::::::::::::::::::: ${data['result'][0]}");
                //   },
                // ),
                appBar: AppViews.initAppBar(
                  icon: constraints.maxWidth < 600 ? null : const Icon(Icons.keyboard_arrow_left),
                  mContext: context,
                  centerTitle: controller.currentPageType == PageType.home || controller.currentPageType == PageType.home2 ? true : false,
                  strTitle: controller.currentPageType == PageType.home || controller.currentPageType == PageType.home2
                      ? controller.strTitle.tr + controller.firstName
                      : controller.strTitle.tr,
                  isShowNotification: true,
                  isShowSOS: false,
                  menuTap: () {
                    if (controller.currentPageType == PageType.home || controller.currentPageType == PageType.home2) {
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
                bottomNavigationBar: BottomBarDefault(
                  color: AppColors.colorWhite.withOpacity(0.6),
                  items: [
                    TabItem(
                      icon: Icons.home,
                    ),
                    // TabItem(
                    //   icon: Icons.shopping_basket,
                    // ),
                    TabItem(
                        icon: Icons.notifications,
                        count: GetBuilder<NotificationsController>(
                            init: NotificationsController(),
                            builder: (value) {
                              return Container(
                                  height: 20,
                                  width: 20,
                                  // padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(100)),
                                  margin: const EdgeInsets.only(left: AppDimens.dimens_6, top: AppDimens.dimens_2),
                                  child: Center(
                                    child: Text(
                                      value.alNotification.length.toString() ?? "0",
                                      style: AppStyle.textViewStyleNormalSubtitle2(
                                          context: context, color: AppColors.colorWhite, fontWeightDelta: 1, fontSizeDelta: -1),
                                    ),
                                  ));
                            })),
                    TabItem(
                      icon: Icons.person,
                    ),
                  ],
                  backgroundColor: AppColors.colorBlueStart,
                  colorSelected: AppColors.colorWhite,
                  animated: true,
                  indexSelected: value.indexM,
                  iconSize: 25,
                  top: 15,
                  bottom: 10,
                  onTap: (val) {
                    log(value.indexM.toString());
                    log(val.toString());
                    value.onChangeBottomBar(val);
                  },
                ));
          }));
    });
  }
}
