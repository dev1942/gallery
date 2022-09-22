import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/controllers/estimation_sidebar_controllers/estimation_list_controller.dart';
import 'package:otobucks/widgets/cancel_booking_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../global/app_colors.dart';
import '../../../../global/app_dimens.dart';
import '../../../../global/app_style.dart';
import '../../../../global/app_views.dart';
import '../../../../global/constants.dart';
import '../../../../global/enum.dart';
import '../../../../global/global.dart';
import '../../../global/app_images.dart';
import '../../../model/estimates_model.dart';
import '../../../model/estimation_detail_model.dart';
import '../../../services/repository/estimates_repo.dart';
import '../../../widgets/custom_button.dart';
import 'checkout_screen.dart';

class EstimationDetailsPDFScreen extends StatefulWidget {
  final Function? callback;
  final EstimatesModel mEstimatesModel;

  const EstimationDetailsPDFScreen(
      {Key? key, this.callback, required this.mEstimatesModel})
      : super(key: key);

  @override
  EstimationDetailsPDFScreenState createState() =>
      EstimationDetailsPDFScreenState();
}

class EstimationDetailsPDFScreenState
    extends State<EstimationDetailsPDFScreen> {
  ShowData mShowData = ShowData.showLoading;

  bool connectionStatus = false;
  bool isShowLoader = false;
  late EstimatesModel mEstimatesModel;
  late EstimationDetailModel? mEstimationDetailModel;

  int indexM = 0;

  @override
  void initState() {
    getEstimationDetails();
    super.initState();
    //getLocation();
    mEstimatesModel = widget.mEstimatesModel;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var mBorderColor = AppColors.colorBorder;

    Widget widgetM = Container();
    Widget mShowWidget = Container();
    List<TableRow> alTableRow = [];
    alTableRow.add(TableRow(
        decoration: BoxDecoration(color: AppColors.colorBlack3),
        children: [
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                margin: const EdgeInsets.only(left: AppDimens.dimens_3),
                alignment: Alignment.centerLeft,
                child: Text(Constants.TXT_TITLE,
                    style: AppStyle.textViewStyleSmall(
                        context: context,
                        color: AppColors.colorBlack2,
                        fontWeightDelta: 0,
                        fontSizeDelta: -2)),
                height: AppDimens.dimens_25,
              )),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                margin: const EdgeInsets.only(left: AppDimens.dimens_3),
                alignment: Alignment.centerLeft,
                child: Text(Constants.TXT_DISCRIPTION,
                    style: AppStyle.textViewStyleSmall(
                        context: context,
                        color: AppColors.colorBlack2,
                        fontWeightDelta: 0,
                        fontSizeDelta: -2)),
                height: AppDimens.dimens_25,
              )),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                alignment: Alignment.center,
                child: Text(Constants.TXT_QTY,
                    style: AppStyle.textViewStyleSmall(
                        context: context,
                        color: AppColors.colorBlack2,
                        fontWeightDelta: 0,
                        fontSizeDelta: -2)),
                height: AppDimens.dimens_25,
              )),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                alignment: Alignment.center,
                child: Text(Constants.TXT_PRICE,
                    style: AppStyle.textViewStyleSmall(
                        context: context,
                        color: AppColors.colorBlack2,
                        fontWeightDelta: 0,
                        fontSizeDelta: -2)),
                height: AppDimens.dimens_25,
              )),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                alignment: Alignment.center,
                child: Text(Constants.TXT_AMOUNT,
                    style: AppStyle.textViewStyleSmall(
                        context: context,
                        color: AppColors.colorBlack2,
                        fontWeightDelta: 0,
                        fontSizeDelta: -2)),
                height: AppDimens.dimens_25,
              )),
        ]));
    if (mShowData == ShowData.showData) {
      for (var element in mEstimationDetailModel!.items) {
        alTableRow.add(TableRow(
            decoration: BoxDecoration(color: AppColors.colorWhite),
            children: [
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                    margin: const EdgeInsets.only(left: AppDimens.dimens_3),
                    alignment: Alignment.centerLeft,
                    child: Text(element.title,
                        style: AppStyle.textViewStyleSmall(
                            context: context,
                            color: AppColors.colorBlack2,
                            fontWeightDelta: 0,
                            fontSizeDelta: -2)),
                  )),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                    margin: const EdgeInsets.only(left: AppDimens.dimens_3),
                    alignment: Alignment.centerLeft,
                    child: Text(element.description,
                        style: AppStyle.textViewStyleSmall(
                            context: context,
                            color: AppColors.colorBlack2,
                            fontWeightDelta: 0,
                            fontSizeDelta: -2)),
                  )),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(element.quantity,
                        style: AppStyle.textViewStyleSmall(
                            context: context,
                            color: AppColors.colorBlack2,
                            fontWeightDelta: 0,
                            fontSizeDelta: -2)),
                  )),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(element.price,
                        style: AppStyle.textViewStyleSmall(
                            context: context,
                            color: AppColors.colorBlack2,
                            fontWeightDelta: 0,
                            fontSizeDelta: -2)),
                  )),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(element.amount,
                        style: AppStyle.textViewStyleSmall(
                            context: context,
                            color: AppColors.colorBlack2,
                            fontWeightDelta: 0,
                            fontSizeDelta: -2)),
                  )),
            ]));
      }

      mShowWidget = ListView(
        children: [
          // profile pic and name
          Container(
              margin: const EdgeInsets.only(
                  right: AppDimens.dimens_10, top: AppDimens.dimens_10),
              width: AppDimens.dimens_190,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.download_rounded, size: AppDimens.dimens_17),
                  const SizedBox(
                    width: AppDimens.dimens_3,
                  ),
                  InkWell(
                    child: Text(Constants.TXT_DOWNLOAD_INVOICE,
                        style: AppStyle.textViewStyleSmall(
                            context: context,
                            color: AppColors.colorBlack,
                            fontWeightDelta: 0,
                            fontSizeDelta: 0)),
                    onTap: () {},
                  )
                ],
              )),

          Container(
            margin: const EdgeInsets.only(
                left: AppDimens.dimens_10, top: AppDimens.dimens_10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(Constants.TXT_CUSTOMER_ESTIMATION.toUpperCase(),
                    style: AppStyle.textViewStyleNormalBodyText2(
                        context: context,
                        color: AppColors.colorBlack,
                        fontWeightDelta: 1,
                        fontSizeDelta: 2)),
                Text(Constants.TXT_TAX_INVOICE,
                    style: AppStyle.textViewStyleSmall(
                        context: context,
                        color: AppColors.colorBlack,
                        fontWeightDelta: 0,
                        fontSizeDelta: -1))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: AppDimens.dimens_5,
              bottom: AppDimens.dimens_5,
            ),
            height: AppDimens.dimens_30,
            color: AppColors.colorBlue2,
          ),
          Container(
              margin: const EdgeInsets.only(
                  left: AppDimens.dimens_10, top: AppDimens.dimens_10),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(Constants.TXT_CUSTOMER_NAME,
                      style: AppStyle.textViewStyleSmall(
                          context: context,
                          color: AppColors.colorBlack,
                          fontWeightDelta: 1,
                          fontSizeDelta: 1)),
                  Text("Willow Anderson",
                      style: AppStyle.textViewStyleSmall(
                          context: context,
                          color: AppColors.colorBlack2,
                          fontWeightDelta: -1,
                          fontSizeDelta: -1)),
                ],
              )),
          Container(
              margin: const EdgeInsets.only(
                  right: AppDimens.dimens_10, top: AppDimens.dimens_10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(Constants.TXT_INVOICE_ID,
                      style: AppStyle.textViewStyleSmall(
                          context: context,
                          color: AppColors.colorBlack,
                          fontWeightDelta: 0,
                          fontSizeDelta: -2)),
                  Text("0123456789",
                      style: AppStyle.textViewStyleSmall(
                          context: context,
                          color: AppColors.colorBlack2,
                          fontWeightDelta: 0,
                          fontSizeDelta: -2)),
                ],
              )),
          Container(
              margin: const EdgeInsets.only(
                  right: AppDimens.dimens_10, left: AppDimens.dimens_10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(Constants.TXT_DISCRIPTION,
                        style: AppStyle.textViewStyleSmall(
                            context: context,
                            color: AppColors.colorBlack,
                            fontWeightDelta: 1,
                            fontSizeDelta: 1)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(Constants.TXT_INVOICE_DATE,
                          style: AppStyle.textViewStyleSmall(
                              context: context,
                              color: AppColors.colorBlack,
                              fontWeightDelta: 0,
                              fontSizeDelta: -2)),
                      Text("08/04/2022",
                          style: AppStyle.textViewStyleSmall(
                              context: context,
                              color: AppColors.colorBlack2,
                              fontWeightDelta: 0,
                              fontSizeDelta: -2)),
                    ],
                  )
                ],
              )),
          Container(
            margin: EdgeInsets.only(
                right: size.width / 3, left: AppDimens.dimens_10),
            child: SizedBox(
              width: 190,
              child: Text(
                  "Duis odio neque, pretium a massa eget, consectetur venenatis nisl. In sollicitudin tempus quam, quis dignissim ex eleifend eu.",
                  style: AppStyle.textViewStyleSmall(
                      context: context,
                      color: AppColors.colorBlack2,
                      fontWeightDelta: 0,
                      fontSizeDelta: -3)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: AppDimens.dimens_14),
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1, color: AppColors.colorBlack.withOpacity(0.2)),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppDimens.dimens_5),
                  topRight: Radius.circular(AppDimens.dimens_5)),
            ),
            child: Table(
              border: TableBorder.symmetric(
                inside: BorderSide(width: 1, color: mBorderColor),
              ),
              children: alTableRow,
              columnWidths: const {
                //0: FlexColumnWidth(2),
                1: FlexColumnWidth(2),
                //2: FlexColumnWidth(2),
                //3: FlexColumnWidth(2),
              },
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(left: size.width / 4),
            child: Table(
              border: TableBorder(
                left: BorderSide(width: 1, color: mBorderColor),
                right: BorderSide(width: 1, color: mBorderColor),
                bottom: BorderSide(width: 1, color: mBorderColor),
                horizontalInside: BorderSide(width: 1, color: mBorderColor),
                verticalInside: BorderSide(width: 1, color: mBorderColor),
              ),
              children: [
                TableRow(children: [
                  TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(Constants.TXT_SUB_TOTAL,
                            style: AppStyle.textViewStyleSmall(
                                context: context,
                                color: AppColors.colorBlack2,
                                fontWeightDelta: 0,
                                fontSizeDelta: -2)),
                        height: AppDimens.dimens_25,
                      )),
                  TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(mEstimationDetailModel!.subTotal,
                            style: AppStyle.textViewStyleSmall(
                                context: context,
                                color: AppColors.colorBlack2,
                                fontWeightDelta: 0,
                                fontSizeDelta: -2)),
                        height: AppDimens.dimens_25,
                      )),
                ]),
                TableRow(children: [
                  TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(Constants.TXT_DISCOUNT,
                            style: AppStyle.textViewStyleSmall(
                                context: context,
                                color: AppColors.colorBlack2,
                                fontWeightDelta: 0,
                                fontSizeDelta: -2)),
                        height: AppDimens.dimens_25,
                      )),
                  TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(mEstimationDetailModel!.discount,
                            style: AppStyle.textViewStyleSmall(
                                context: context,
                                color: AppColors.colorBlack2,
                                fontWeightDelta: 0,
                                fontSizeDelta: -2)),
                        height: AppDimens.dimens_25,
                      )),
                ]),
                TableRow(children: [
                  TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                            "Service Tax (" +
                                mEstimationDetailModel!.serviceTax +
                                "%)",
                            style: AppStyle.textViewStyleSmall(
                                context: context,
                                color: AppColors.colorBlack2,
                                fontWeightDelta: 0,
                                fontSizeDelta: -2)),
                        height: AppDimens.dimens_25,
                      )),
                  TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text("0",
                            style: AppStyle.textViewStyleSmall(
                                context: context,
                                color: AppColors.colorBlack2,
                                fontWeightDelta: 0,
                                fontSizeDelta: -2)),
                        height: AppDimens.dimens_25,
                      )),
                ]),
                TableRow(
                  decoration: BoxDecoration(color: AppColors.colorBlue2),
                  children: [
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(Constants.TXT_TOTAL,
                              style: AppStyle.textViewStyleSmall(
                                  context: context,
                                  color: AppColors.colorWhite,
                                  fontWeightDelta: 1,
                                  fontSizeDelta: -2)),
                          height: AppDimens.dimens_25,
                        )),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(mEstimationDetailModel!.grandTotal,
                              style: AppStyle.textViewStyleSmall(
                                  context: context,
                                  color: AppColors.colorWhite,
                                  fontWeightDelta: 1,
                                  fontSizeDelta: -2)),
                          height: AppDimens.dimens_25,
                        )),
                  ],
                ),
              ],
              columnWidths: const {
                0: FlexColumnWidth(3.5),
                1: FlexColumnWidth(1),
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: AppDimens.dimens_20),
            child: Text(Constants.TXT_THANKS_CONNECTING,
                style: AppStyle.textViewStyleNormalBodyText2(
                    context: context,
                    color: AppColors.colorBlack,
                    fontWeightDelta: 0,
                    fontSizeDelta: 0)),
            height: AppDimens.dimens_25,
          ),
          Container(
            margin: const EdgeInsets.only(
                top: AppDimens.dimens_20, bottom: AppDimens.dimens_20),
            height: AppDimens.dimens_1,
            color: AppColors.colorBorder,
          ),
          Container(
            margin: const EdgeInsets.only(
                bottom: AppDimens.dimens_20,
                left: AppDimens.dimens_20,
                right: AppDimens.dimens_20),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: AppDimens.dimens_10),
                  child: Image.asset(
                    AppImages.icSplashScreenIcon,
                    height: AppDimens.dimens_50,
                  ),
                ),
                // Expanded(
                //     child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Container(
                //       alignment: Alignment.centerLeft,
                //       child: Text("Otobucks",
                //           style: AppStyle.textViewStyleSmall(
                //               context: context,
                //               color: AppColors.colorBlack,
                //               fontWeightDelta: 1,
                //               fontSizeDelta: -2)),
                //     ),
                //     Container(
                //       alignment: Alignment.centerLeft,
                //       child: Text("David anderson",
                //           style: AppStyle.textViewStyleSmall(
                //               context: context,
                //               color: AppColors.colorBlack,
                //               fontWeightDelta: 0,
                //               fontSizeDelta: -4)),
                //     ),
                //     Container(
                //       margin: const EdgeInsets.only(top: AppDimens.dimens_2),
                //       alignment: Alignment.centerLeft,
                //       child: Text("united arab emirates",
                //           style: AppStyle.textViewStyleSmall(
                //               context: context,
                //               color: AppColors.colorBlack,
                //               fontWeightDelta: 0,
                //               fontSizeDelta: -4)),
                //     )
                //   ],
                // )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Contact information",
                          style: AppStyle.textViewStyleSmall(
                              context: context,
                              color: AppColors.colorBlack,
                              fontWeightDelta: 1,
                              fontSizeDelta: -2)),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Mobile: +971 1234567890",
                          style: AppStyle.textViewStyleSmall(
                              context: context,
                              color: AppColors.colorBlack,
                              fontWeightDelta: 0,
                              fontSizeDelta: -4)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: AppDimens.dimens_2),
                      alignment: Alignment.centerLeft,
                      child: Text("www.otobucks.com",
                          style: AppStyle.textViewStyleSmall(
                              context: context,
                              color: AppColors.colorBlack,
                              fontWeightDelta: 0,
                              fontSizeDelta: -4)),
                    )
                  ],
                ),
              ],
            ),
          ),

          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(
                top: AppDimens.dimens_20,
                bottom: AppDimens.dimens_20,
                left: AppDimens.dimens_10,
                right: AppDimens.dimens_10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: CustomButton(
                      isGradient: true,
                      isRoundBorder: true,
                      fontColor: AppColors.colorWhite,
                      fontSize: 0,
                      // width: size.width / 1.5,
                      height: AppDimens.dimens_38,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckoutScreen(
                                      sourceId:
                                          widget.mEstimatesModel.source!.id,
                                      estimateId: widget.mEstimatesModel.id,
                                      paymentStatus: 'partialPayment',
                                    )));
                      },
                      strTitle: widget.mEstimatesModel.status == 'submitted'
                          ? 'Make partial Payment'
                          : "Make full Payment"),
                  width: size.width / 1.8,
                ),
                const Spacer(),
                SizedBox(
                  child: CustomButton(
                      fontSize: 0,
                      isGradient: false,
                      isRoundBorder: true,
                      color: AppColors.greyDateBG,
                      fontColor: AppColors.colorBlack,
                      width: size.width / 1.5,
                      height: AppDimens.dimens_38,
                      onPressed: () => displayTextInputDialog(),
                      strTitle: Constants.TXT_DECLINE),
                  width: size.width / 3.2,
                ),
              ],
            ),
          ),

          // Expanded(child: Container()),
        ],
      );
    }

    widgetM = AppViews.getSetData(context, mShowData, mShowWidget);

    return Scaffold(
      appBar: AppViews.initAppBar(
        mContext: context,
        centerTitle: false,
        strTitle: "Estimation",
        isShowNotification: false,
        isShowSOS: false,
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
      ),
    );
  }

  displayTextInputDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return CancelBookingDialogBox(
            isDecline: true,
            onTap: (String strReason) {
              if (Global.checkNull(strReason)) {
                declineEstimation(strReason);

                // cancelEstimation(strReason);
              } else {
                Global.showToastAlert(
                    context: context,
                    strTitle: "",
                    strMsg: AppAlert.ALERT_ENTER_FN,
                    toastType: TOAST_TYPE.toastError);
              }
            },
          );
        });
  }

  checkPermission() async {
    var requestPermission = await Permission.location.status;

    if (requestPermission.isDenied) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.STRING_ALLOW_LOCATION_ACCESS,
          toastType: TOAST_TYPE.toastWarning);
    } else if (requestPermission.isGranted) {}
  }

  getEstimationDetails() async {
    setState(() {
      mShowData = ShowData.showLoading;
      // isShowLoader = true;
    });

    HashMap<String, Object> requestParams = HashMap();

    var categories = await EstimatesRepo()
        .getEstimatesDetail(requestParams, widget.mEstimatesModel.id);

    categories.fold((failure) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
      setState(() {
        mShowData = ShowData.showNoDataFound;
      });
    }, (mResult) {
      setState(() {
        List<EstimationDetailModel> alEstimation =
            mResult.responseData as List<EstimationDetailModel>;
        if (alEstimation.isNotEmpty) {
          mEstimationDetailModel = alEstimation.first;
          mShowData = ShowData.showData;
        } else {
          mShowData = ShowData.showNoDataFound;
        }
      });
    });
  }

  declineEstimation(String reason) async {
    setState(() {
      mShowData = ShowData.showLoading;
      // isShowLoader = true;
    });

    HashMap<String, Object> requestParams = HashMap();

    requestParams['declineReason'] = reason;

    var categories = await EstimatesRepo()
        .declineEstimate(requestParams, widget.mEstimatesModel.id);

    categories.fold((failure) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
      setState(() {
        mShowData = ShowData.showNoDataFound;
      });
    }, (mResult) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: mResult.responseMessage,
          toastType: TOAST_TYPE.toastSuccess);
      setState(() {
        mShowData = ShowData.showNoDataFound;
      });
      Get.back();
      Get.find<EstimationListController>().getEstimation('submitted');
    });
  }
}
