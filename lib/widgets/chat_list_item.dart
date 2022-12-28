import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/container_properties.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/widgets/fade_in_image.dart';

import '../global/app_images.dart';
import '../View/Chat/Models/local_chat_model.dart';

class ChatListItem extends StatelessWidget {
  final LocalChatModel mChatModel;
  final Function onTap;

  const ChatListItem({Key? key, required this.mChatModel, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget mWidget = Container();
    switch (mChatModel.mMsgType) {
      case MsgType.left:
        mWidget = Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                child: Container(
              margin: const EdgeInsets.only(right: AppDimens.dimens_80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: AppColors.colorChatBgLeft,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(AppDimens.dimens_10)),
                      ),
                      padding: const EdgeInsets.all(AppDimens.dimens_12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mChatModel.message,
                            style: AppStyle.textViewStyleNormalBodyText2(
                                context: context,
                                color: AppColors.colorChatMsg,
                                fontSizeDelta: 0,
                                fontWeightDelta: 0),
                          ),
                          Container(
                            child: Text(
                              mChatModel.time.toString(),
                              style: AppStyle.textViewStyleNormalBodyText2(
                                  context: context,
                                  color: AppColors.colorChatTimeLeft,
                                  fontSizeDelta: 0,
                                  fontWeightDelta: 0),
                            ),
                            alignment: Alignment.centerRight,
                          )
                        ],
                      )),
                  Visibility(
                      visible: mChatModel.images.isNotEmpty ? true : false,
                      child: Column(
                        children:
                            List.generate(mChatModel.images.length, (index) {
                          return Container(
                            margin: const EdgeInsets.only(top: 5),
                            height: 200,
                            decoration: ContainerProperties.simpleDecoration(),
                            child: InkWell(
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(AppDimens.dimens_5),
                                  child: NetworkImageCustom(
                                    image: mChatModel.images[index],
                                    height: 70,
                                    width: double.infinity,
                                  )),
                              onTap: () {
                                final imageProvider =
                                    Image.network(mChatModel.images[index])
                                        .image;
                                showImageViewer(context, imageProvider,
                                    useSafeArea: true,
                                    onViewerDismissed: () {});
                              },
                            ),
                          );
                        }),
                      )),
                ],
              ),
            )),
          ],
        );
        break;
      case MsgType.right:
        mWidget = Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                child: Container(
              margin: const EdgeInsets.only(left: AppDimens.dimens_80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: AppColors.colorChatBgRight,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(AppDimens.dimens_10),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(AppDimens.dimens_10),
                            bottomLeft: Radius.circular(AppDimens.dimens_10)),
                      ),
                      padding: const EdgeInsets.all(AppDimens.dimens_12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mChatModel.message,
                            style: AppStyle.textViewStyleNormalBodyText2(
                                context: context,
                                color: AppColors.colorWhite,
                                fontSizeDelta: 0,
                                fontWeightDelta: 0),
                          ),
                          Container(
                            child: Text(
                              mChatModel.time.toString(),
                              style: AppStyle.textViewStyleNormalBodyText2(
                                  context: context,
                                  color: AppColors.colorWhite,
                                  fontSizeDelta: 0,
                                  fontWeightDelta: 0),
                            ),
                            alignment: Alignment.centerRight,
                          )
                        ],
                      )),
                  Visibility(
                      visible: mChatModel.images.isNotEmpty ? true : false,
                      child: Column(
                        children:
                            List.generate(mChatModel.images.length, (index) {
                          return Container(
                            margin: const EdgeInsets.only(top: 5),
                            height: 200,
                            decoration: ContainerProperties.simpleDecoration(),
                            child: InkWell(
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(AppDimens.dimens_5),
                                  child: NetworkImageCustom(
                                    image: mChatModel.images[index],
                                    height: 70,
                                    width: double.infinity,
                                  )),
                              onTap: () {
                                final imageProvider =
                                    Image.network(mChatModel.images[index])
                                        .image;
                                showImageViewer(context, imageProvider,
                                    useSafeArea: true,
                                    onViewerDismissed: () {});
                              },
                            ),
                          );
                        }),
                      )),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(top: AppDimens.dimens_2),
                    child: Image.asset(AppImages.ic_message_tick,
                        color: mChatModel.isRead
                            ? null
                            : AppColors.colorChatBgRight,
                        width: AppDimens.dimens_18,
                        height: AppDimens.dimens_9),
                  )
                ],
              ),
            )),
          ],
        );
        break;
    }

    return Container(
      margin: const EdgeInsets.all(AppDimens.dimens_5),
      child: mWidget,
    );
  }
}
