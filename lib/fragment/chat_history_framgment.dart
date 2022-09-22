import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/controllers/chat_controllers/chat_screen_controller.dart';
import 'package:otobucks/controllers/home_screen_controller.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/global/text_styles.dart';
import 'package:otobucks/model/my_rooms_model.dart';
import 'package:otobucks/widgets/fade_in_image.dart';

import '../../../../global/app_colors.dart';
import '../../../../global/app_dimens.dart';
import '../../../../global/app_style.dart';
import '../../../../global/app_views.dart';
import '../page/chat/chat_detail_screen.dart';

class ChatHistoryFragment extends StatefulWidget {
  const ChatHistoryFragment({Key? key}) : super(key: key);

  @override
  ChatHistoryFragmentState createState() => ChatHistoryFragmentState();
}

class ChatHistoryFragmentState extends State<ChatHistoryFragment> {
  var controller = Get.put(ChatHistorController());

  @override
  void initState() {
    controller.getRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget widgetM = GetBuilder<ChatHistorController>(builder: (value) {
      return AppViews.getSetData(
          context,
          value.mShowData,
          ListView(
            children: [
              // profile pic and name
              Container(
                padding: const EdgeInsets.only(
                    left: AppDimens.dimens_50,
                    top: AppDimens.dimens_25,
                    bottom: AppDimens.dimens_32),
                alignment: Alignment.center,
                color: AppColors.colorBlueStart,
                child: Row(
                  children: [
                    Container(
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppDimens.dimens_50),
                        child: NetworkImageCustom(
                            image: Get.find<HomeScreenController>().image,
                            fit: BoxFit.fill,
                            height: AppDimens.dimens_60,
                            width: AppDimens.dimens_60),
                      ),
                      margin: const EdgeInsets.only(right: AppDimens.dimens_10),
                    ),
                    Flexible(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(
                                top: AppDimens.dimens_5,
                                bottom: AppDimens.dimens_2),
                            child: Text(
                              Get.find<HomeScreenController>()
                                  .fullName
                                  .capitalize!,
                              style: AppStyle.textViewStyleNormalBodyText2(
                                  context: context,
                                  color: AppColors.colorWhite,
                                  fontSizeDelta: 0,
                                  fontWeightDelta: 0),
                            )),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Car Owner",
                              style: AppStyle.textViewStyleSmall(
                                  context: context,
                                  color: AppColors.colorWhite.withOpacity(0.7),
                                  fontSizeDelta: -2,
                                  fontWeightDelta: 0),
                            )),
                      ],
                    )),
                  ],
                ),
              ),

              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(
                      right: AppDimens.dimens_18,
                      left: AppDimens.dimens_18,
                      top: AppDimens.dimens_10,
                      bottom: AppDimens.dimens_10),
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 1,
                      color: AppColors.grayDashboardItem,
                    );
                  },
                  itemBuilder: (BuildContext contextM, index) {
                    MyRoomModel roomModel = value.rooms[index];
                    RoomUser? user;

                    for (var roomUser in roomModel.users) {
                      if (roomUser.id !=
                          Get.find<HomeScreenController>().userId) {
                        user = roomUser;
                        break;
                      }
                    }
                    if (user == null) {
                      return Container();
                    }
                    // EstimatesModel mEstimatesModel = alEstimates[index];
                    return InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(
                          AppDimens.dimens_10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                right: AppDimens.dimens_10,
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(AppDimens.dimens_50),
                                child: NetworkImageCustom(
                                    image: user.image,
                                    fit: BoxFit.fill,
                                    height: AppDimens.dimens_34,
                                    width: AppDimens.dimens_34),
                              ),
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          user.firstName + " " + user.lastName,
                                          style: AppStyle
                                              .textViewStyleNormalBodyText2(
                                                  context: context,
                                                  color: AppColors.colorBlack,
                                                  fontSizeDelta: 0,
                                                  fontWeightDelta: 0),
                                        )),
                                        Text(
                                          Global.getTimeFormat(roomModel
                                              .getDateInFormate()
                                              .toString()
                                              .split(' ')[1]),
                                          style: AppStyle
                                              .textViewStyleNormalBodyText2(
                                                  context: context,
                                                  color: AppColors
                                                      .grayDashboardText,
                                                  fontSizeDelta: -1,
                                                  fontWeightDelta: -1),
                                        )
                                      ],
                                    )),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            roomModel.serverChatModel == null
                                                ? ''
                                                : roomModel
                                                    .serverChatModel!.message,
                                            style: AppStyle.textViewStyleSmall(
                                                context: context,
                                                color:
                                                    AppColors.grayDashboardText,
                                                fontSizeDelta: -1,
                                                fontWeightDelta: 0),
                                          )),
                                    ),
                                    roomModel.serverChatModel != null
                                        ? roomModel.serverChatModel!.from.id ==
                                                Get.find<HomeScreenController>()
                                                    .userId
                                            ? const SizedBox.shrink()
                                            : roomModel.unReadMessages
                                                        .toString() ==
                                                    '0'
                                                ? Container()
                                                : CircleAvatar(
                                                    radius: 8,
                                                    backgroundColor:
                                                        AppColors.colorGreen,
                                                    child: Text(
                                                      roomModel.unReadMessages
                                                          .toString(),
                                                      style: regularText(12)
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  )
                                        : const SizedBox.shrink()
                                  ],
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                      onTap: () {
                        roomModel.unReadMessages = 0;
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatDetailScreen(
                                      roomUser: user!,
                                      roomId: roomModel.myRoomModelId,
                                    )));
                      },
                    );
                  },
                  itemCount: value.rooms.length)
            ],
          ));
    });

    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.getMainBgColor(),
        body: Stack(
          children: [
            Container(
              color: AppColors.colorBlueStart,
              //height: AppDimens.dimens_120,
              height: 0,
            ),
            // Container(height: size.height, child: widgetM),
            widgetM,
            GetBuilder<ChatHistorController>(builder: (value) {
              return AppViews.showLoadingWithStatus(value.isShowLoader);
            })
          ],
        ));
  }
}
