import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/controllers/home_screen_controller.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/model/transaction_model.dart';
import 'package:otobucks/widgets/custom_button.dart';
import 'package:otobucks/widgets/fade_in_image.dart';
import 'package:otobucks/widgets/image_selection_bottom_sheet.dart';

class TransactionDetailScreen extends StatefulWidget {
  final TransactionModel transactionModel;
  const TransactionDetailScreen({Key? key, required this.transactionModel})
      : super(key: key);

  @override
  TransactionDetailScreenState createState() => TransactionDetailScreenState();
}

class TransactionDetailScreenState extends State<TransactionDetailScreen> {
  ShowData mShowData = ShowData.showLoading;

  bool connectionStatus = false;
  bool isShowLoader = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = AppDimens.dimens_36;

    Widget widgetM = Container();

    Widget mShowWidget = Column(
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
                  borderRadius: BorderRadius.circular(AppDimens.dimens_50),
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
                          top: AppDimens.dimens_5, bottom: AppDimens.dimens_2),
                      child: Text(
                        Get.find<HomeScreenController>().fullName.capitalize!,
                        style: AppStyle.textViewStyleNormalBodyText2(
                            context: context,
                            color: AppColors.colorWhite,
                            fontSizeDelta: 0,
                            fontWeightDelta: -3),
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

        Expanded(
            child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(AppDimens.dimens_20),
              child: Card(
                  elevation: AppDimens.dimens_3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimens.dimens_5),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(AppDimens.dimens_20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "ID",
                                    style:
                                        AppStyle.textViewStyleNormalBodyText2(
                                            context: context,
                                            color: AppColors.colorGray5,
                                            fontSizeDelta: 0,
                                            fontWeightDelta: 0),
                                  )),
                              Expanded(
                                child: Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      widget.transactionModel.transactionId,
                                      maxLines: 1,
                                      style:
                                          AppStyle.textViewStyleNormalBodyText2(
                                              context: context,
                                              color: AppColors.colorGray5,
                                              fontSizeDelta: 0,
                                              fontWeightDelta: 0),
                                    )),
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.only(
                              top: AppDimens.dimens_5,
                              bottom: AppDimens.dimens_2),
                        ),
                        AppViews.addDivider(),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.transactionModel.itemType
                                          .toString()
                                          .capitalize!,
                                      style:
                                          AppStyle.textViewStyleNormalBodyText2(
                                              context: context,
                                              color: AppColors.colorGray5,
                                              fontSizeDelta: 0,
                                              fontWeightDelta: 0),
                                    )),
                              ),
                              Expanded(
                                child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      widget.transactionModel.metadata
                                                  .service ==
                                              null
                                          ? ''
                                          : widget.transactionModel.metadata
                                              .service!.title
                                              .toString(),
                                      style:
                                          AppStyle.textViewStyleNormalBodyText2(
                                              context: context,
                                              color: AppColors.colorGray5,
                                              fontSizeDelta: 0,
                                              fontWeightDelta: 0),
                                    )),
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.only(
                              top: AppDimens.dimens_5,
                              bottom: AppDimens.dimens_2),
                        ),
                        AppViews.addDivider(),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Provider',
                                    style:
                                        AppStyle.textViewStyleNormalBodyText2(
                                            context: context,
                                            color: AppColors.colorGray5,
                                            fontSizeDelta: 0,
                                            fontWeightDelta: 0),
                                  )),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.transactionModel.metadata.provider ==
                                            null
                                        ? Get.find<HomeScreenController>()
                                            .fullName
                                        : widget.transactionModel.metadata
                                            .provider!.firstName,
                                    style:
                                        AppStyle.textViewStyleNormalBodyText2(
                                            context: context,
                                            color: AppColors.colorGray5,
                                            fontSizeDelta: 0,
                                            fontWeightDelta: 0),
                                  )),
                            ],
                          ),
                          margin: const EdgeInsets.only(
                              top: AppDimens.dimens_5,
                              bottom: AppDimens.dimens_2),
                        ),
                        AppViews.addDivider(),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Payment Status",
                                      style:
                                          AppStyle.textViewStyleNormalBodyText2(
                                              context: context,
                                              color: AppColors.colorGray5,
                                              fontSizeDelta: 0,
                                              fontWeightDelta: 0),
                                    )),
                              ),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.transactionModel.metadata.type
                                        .toString(),
                                    style:
                                        AppStyle.textViewStyleNormalBodyText2(
                                            context: context,
                                            color: AppColors.colorGreen,
                                            fontSizeDelta: 0,
                                            fontWeightDelta: 0),
                                  )),
                            ],
                          ),
                          margin: const EdgeInsets.only(
                              top: AppDimens.dimens_5,
                              bottom: AppDimens.dimens_2),
                        ),
                        AppViews.addDivider(),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Transection Date",
                                    style:
                                        AppStyle.textViewStyleNormalBodyText2(
                                            context: context,
                                            color: AppColors.colorGray5,
                                            fontSizeDelta: 0,
                                            fontWeightDelta: 0),
                                  )),
                              Expanded(
                                child: Container(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      widget.transactionModel.createdAt
                                          .toString()
                                          .split('T')[0],
                                      style:
                                          AppStyle.textViewStyleNormalBodyText2(
                                              context: context,
                                              color: AppColors.colorGray5,
                                              fontSizeDelta: 0,
                                              fontWeightDelta: 0),
                                    )),
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.only(
                              top: AppDimens.dimens_5,
                              bottom: AppDimens.dimens_2),
                        ),
                      ],
                    ),
                  )),
            ),
            CustomButton(
                isGradient: true,
                isRoundBorder: true,
                height: height + AppDimens.dimens_4,
                fontSize: 0,
                fontColor: AppColors.colorWhite,
                width: size.width / 2.2,
                onPressed: () {},
                strTitle: Constants.TXT_DOWNLOAD),
          ],
        ))
      ],
    );
    widgetM = AppViews.getSetData(context, mShowData, mShowWidget);

    return Scaffold(
        appBar: AppViews.initAppBar(
          mContext: context,
          centerTitle: false,
          strTitle: Constants.TXT_TRANSACTION_DETAIL,
          isShowNotification: false,
          isShowSOS: false,
          menuTap: null,
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
            widgetM,
            AppViews.showLoadingWithStatus(isShowLoader)
          ],
        ));
  }

  selectProfilePic() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return ImageSelection(
            isCropImage: true,
            mImagePath: (String strPath) {},
            mMaxHeight: 1024,
            mMaxWidth: 1024,
            mRatioX: 1.0,
            mRatioY: 1.0,
          );
        });
  }
}
