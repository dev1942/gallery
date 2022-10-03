import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:otobucks/controllers/chat_controllers/chat_detail_controller.dart';
import 'package:otobucks/custom_ui/loader/three_bounce.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_images.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/model/local_chat_model.dart';
import 'package:otobucks/model/my_rooms_model.dart';
import 'package:otobucks/widgets/chat_list_item.dart';
import 'package:otobucks/widgets/fade_in_image.dart';

class ChatDetailScreen extends StatefulWidget {
  final RoomUser roomUser;
  final String roomId;

  const ChatDetailScreen(
      {Key? key, required this.roomUser, required this.roomId})
      : super(key: key);

  @override
  ChatDetailScreenState createState() => ChatDetailScreenState();
}

class ChatDetailScreenState extends State<ChatDetailScreen> {
  var controller = Get.put(ChatDetailController());
  var _isSubmitted = false;

  @override
  void dispose() {
    controller.disableEmoji();
    controller.socket.disconnect();
    super.dispose();
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      controller.initSocket(widget.roomId);
      controller.getMessages(widget.roomId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget widgetM = Container();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.getMainBgColor(),
      appBar: AppViews.initEmptyAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              // profile pic and name
              Container(
                padding: const EdgeInsets.only(
                    left: AppDimens.dimens_5,
                    top: AppDimens.dimens_15,
                    bottom: AppDimens.dimens_12),
                alignment: Alignment.center,
                color: AppColors.colorBlueStart,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop(_isSubmitted);
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_left_rounded,
                          color: AppColors.colorWhite,
                          size: AppDimens.dimens_20,
                        )),
                    Container(
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppDimens.dimens_15),
                        child: NetworkImageCustom(
                            image: widget.roomUser.image,
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
                              widget.roomUser.firstName +
                                  " " +
                                  widget.roomUser.lastName,
                              style: AppStyle.textViewStyleNormalBodyText2(
                                  context: context,
                                  color: AppColors.colorWhite,
                                  fontSizeDelta: 0,
                                  fontWeightDelta: 0),
                            )),
                      ],
                    )),
                  ],
                ),
              ),
              Expanded(
                  child: GetBuilder<ChatDetailController>(builder: (value) {
                return value.mShowData
                    ?
                    //new interactive shimmer loading
                    ListView.builder(
                        padding: EdgeInsets.all(AppDimens.dimens_15),
                        itemCount: 15,
                        itemBuilder: (context, i) {
                          return AppViews.shimmerChat();
                        },
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(AppDimens.dimens_10),
                        reverse: true,
                        itemBuilder: (BuildContext contextM, index) {
                          LocalChatModel chat = value.alChat[index];

                          return ChatListItem(
                            mChatModel: chat,
                            onTap: () {},
                          );
                        },
                        itemCount: value.alChat.length);
              })),
              GetBuilder<ChatDetailController>(builder: (value) {
                return SizedBox(
                  height: value.isShowEmojis ? 250 : 50,
                );
              }),
            ],
          ),
          Column(
            children: [
              Flexible(
                child: widgetM,
                flex: 1,
              ),
              Container(
                height: AppDimens.dimens_50,
                decoration: BoxDecoration(
                    border: Border(
                  top: BorderSide(
                    color: Colors.grey.withOpacity(0.4),
                    width: 0.9,
                  ),
                )),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    onTap: () => controller.disableEmoji(),
                    onChanged: (String strvalue) =>
                        controller.changeText(strvalue),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    style: AppStyle.textViewStyleNormalBodyText2(
                        color: AppColors.colorBlack,
                        fontSizeDelta: 0,
                        fontWeightDelta: 0,
                        context: context),
                    controller: controller.controllerMessage,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      prefixIconConstraints:
                          const BoxConstraints(minWidth: AppDimens.dimens_35),
                      suffixIcon: Container(
                        margin:
                            const EdgeInsets.only(right: AppDimens.dimens_12),
                        alignment: Alignment.center,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: SizedBox(
                                width: AppDimens.dimens_40,
                                height: AppDimens.dimens_40,
                                child: Icon(
                                  Icons.image,
                                  color: AppColors.colorChatBgRight,
                                ),
                              ),
                              onTap: () => controller.selectProfilePic(
                                  context, widget.roomId),
                            ),
                            const SizedBox(
                              width: AppDimens.dimens_10,
                            ),
                            GetBuilder<ChatDetailController>(builder: (value) {
                              return InkWell(
                                borderRadius:
                                    BorderRadius.circular(AppDimens.dimens_20),
                                child: value.showSendButton
                                    ? InkWell(
                                        onTap: () {
                                          setState(() {
                                            _isSubmitted = true;
                                          });
                                          value.sendMessage(widget.roomId);
                                        },
                                        child: SizedBox(
                                          width: AppDimens.dimens_40,
                                          height: AppDimens.dimens_40,
                                          child: Icon(
                                            Icons.send,
                                            color: AppColors.colorBlueEnd,
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        width: AppDimens.dimens_40,
                                        height: AppDimens.dimens_40,
                                        child: Icon(
                                          Icons.send,
                                          color: AppColors.colorBlueEnd
                                              .withOpacity(0.6),
                                        ),
                                      ),
                                onTap: () {},
                              );
                            }),
                          ],
                        ),
                        width: AppDimens.dimens_90,
                      ),
                      prefixIcon: InkWell(
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: AppDimens.dimens_10,
                              right: AppDimens.dimens_12),
                          alignment: Alignment.center,
                          child: Image.asset(
                            AppImages.ic_smyle,
                          ),
                          width: AppDimens.dimens_30,
                        ),
                        onTap: () {
                          controller.showEmoji();
                          FocusScope.of(context).unfocus();
                        },
                      ),
                      contentPadding: const EdgeInsets.only(
                          top: AppDimens.dimens_7, left: AppDimens.dimens_15),
                      focusedBorder: AppViews.textFieldRoundBorder(),
                      border: AppViews.textFieldRoundBorder(),
                      disabledBorder: AppViews.textFieldRoundBorder(),
                      focusedErrorBorder: AppViews.textFieldRoundBorder(),
                      hintText: Constants.TXT_WRITE_A_MESSAGE,
                      filled: true,
                      fillColor: AppColors.colorWhite,
                      hintStyle: AppStyle.textViewStyleNormalBodyText2(
                          color: AppColors.colorTextFieldHint,
                          fontSizeDelta: 0,
                          fontWeightDelta: 0,
                          context: context),
                    ),
                  ),
                ),
                // color: Colors.red,
              ),
              GetBuilder<ChatDetailController>(builder: (value) {
                return Visibility(
                    visible: value.isShowEmojis,
                    child: SizedBox(
                      height: 200,
                      child: ListView(
                        padding: const EdgeInsets.all(10),
                        children: [
                          Wrap(
                            runAlignment: WrapAlignment.start,
                            alignment: WrapAlignment.start,
                            children: List.generate(
                                value.emojis.length,
                                (index) => InkWell(
                                      onTap: () {
                                        value.addEmojis(value.emojis[index]);
                                        setState(() {});
                                      },
                                      child: Text(
                                        value.emojis[index],
                                        style: const TextStyle(fontSize: 30),
                                      ),
                                    )),
                          )
                        ],
                      ),
                    ));
              })
            ],
          ),

          // AppViews.showLoadingWithStatus(isShowLoader)
        ],
      ),
    );
  }
}
