import 'package:flutter/material.dart';
import 'package:otobucks/fragment/estimation_main_fragment.dart';
import 'package:otobucks/global/container_properties.dart';
import 'package:otobucks/widgets/fade_in_image.dart';
import 'package:otobucks/widgets/small_button.dart';

import '../../../model/estimates_model.dart';
import '../../../../global/app_colors.dart';
import '../../../../global/app_dimens.dart';
import '../../../../global/app_style.dart';
import '../../../../global/app_views.dart';
import '../page/services/estimation/estimation_details_pdf_screen.dart';
import '../model/notification_model.dart';

class NotificationDetails extends StatefulWidget {
  final NotificationModel notificationModel;
  final String userName;
  final String userImage;
  const NotificationDetails(
      {Key? key,
      required this.notificationModel,
      this.userName = '',
      this.userImage = ''})
      : super(key: key);

  @override
  NotificationDetailsState createState() => NotificationDetailsState();
}

class NotificationDetailsState extends State<NotificationDetails> {
  List<NotificationModel> alNotification = [];

  late DateTime dateTime;
  @override
  void initState() {
    dateTime = widget.notificationModel.getDateInFormate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget mShowWidget = ListView(
      children: [
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
                  borderRadius: BorderRadius.circular(AppDimens.dimens_50),
                  child: NetworkImageCustom(
                      image: widget.userImage,
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
                          top: AppDimens.dimens_5, bottom: AppDimens.dimens_2),
                      child: Text(
                        widget.userName,
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: ContainerProperties.shadowDecoration(),
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Text(
                  'Details: ${widget.notificationModel.title.contains('submitted') ? 'Your Estimation has been submitted' : ''}',
                  style: AppStyle.textViewStyleNormalBodyText2(
                      context: context,
                      color: HexColor('#1DCD24'),
                      fontSizeDelta: 0,
                      fontWeightDelta: 1)),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: ContainerProperties.shadowDecoration(),
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('From',
                            style: AppStyle.textViewStyleNormalBodyText2(
                              context: context,
                              color: AppColors.colorBlueStart,
                              fontSizeDelta: 0,
                              fontWeightDelta: 1,
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Date',
                            style: AppStyle.textViewStyleNormalBodyText2(
                              context: context,
                              color: AppColors.colorBlueStart,
                              fontSizeDelta: 0,
                              fontWeightDelta: 1,
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('time',
                            style: AppStyle.textViewStyleNormalBodyText2(
                              context: context,
                              color: AppColors.colorBlueStart,
                              fontSizeDelta: 0,
                              fontWeightDelta: 1,
                            ))
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.notificationModel.from),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(dateTime.toString().split(' ')[0]),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(getTimeFormat(dateTime.toString().split(' ')[1])),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            if (widget.notificationModel.type == 'estimate')
              SizedBox(
                width: 200,
                child: PrimaryButton(
                    label: const Text('Estimation Details'),
                    onPress: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => EstimationDetailsPDFScreen(
                      //               mEstimatesModel: EstimatesModel(
                      //                 address: widget.notificationModel.,
                      //                 cutomerNote: ,
                      //                 date: ,
                      //                 discount: ,
                      //                 grandTotal: ,
                      //                 id: ,
                      //                 image: ,
                      //                 mServiceProviderModel: ,
                      //                 itemModel: ,
                      //                 serviceTax: ,
                      //                 source: ,
                      //                 status: ,
                      //                 subTotal: ,
                      //                 time: ,
                      //                 video: ,
                      //                 voiceNote:
                      //               ),
                      //               callback: (bool isRefresh) {
                      //                 setState(() {});
                      //               },
                      //             )));
                    },
                    color: null),
              )
          ],
        )
      ],
    );

    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
            appBar: AppViews.initAppBar(
              mContext: context,
              centerTitle: false,
              strTitle: 'Details',
              isShowNotification: true,
              isShowSOS: true,
            ),
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
                mShowWidget,
              ],
            )));
  }

  String getTimeFormat(String time) {
    String hour = time.split(':')[0];
    String minute = time.split(':')[1].split('.')[0];

    if (int.parse(hour) > 11) {
      return '${int.parse(hour) - 12}:$minute PM';
    }
    return '$hour:$minute AM';
  }
}
