import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/CheckOut/Views/checkout_screen.dart';
import 'package:otobucks/View/MyBookings/controller/estimation_list_controller.dart';
import 'package:otobucks/widgets/Alert_dialog_box.dart';
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
import '../../../services/repository/estimates_repo.dart';
import '../../../widgets/custom_button.dart';
import '../../MyBookings/Models/view_booking_model.dart';

class EstimationDetailsPDFScreen extends StatefulWidget {
  final Function? callback;
final bool isCompleted;
  const EstimationDetailsPDFScreen(
      {Key? key, this.callback, required this.allBookingsModel,this.isCompleted=false})
      : super(key: key);
  // final AllBookingsModel allBookingsModel;
  final Result allBookingsModel;

  @override
  EstimationDetailsPDFScreenState createState() =>
      EstimationDetailsPDFScreenState();
}

class EstimationDetailsPDFScreenState
    extends State<EstimationDetailsPDFScreen> {
  ShowData mShowData = ShowData.showLoading;
  bool connectionStatus = false;
  bool isShowLoader = false;
  late Result allBookingsModel;
  int indexM = 0;
  final EstimationListController _estimationListController =
      Get.put(EstimationListController());
  final TextEditingController _textOffercontroller = TextEditingController();
  final TextEditingController _textOfferNotecontroller = TextEditingController();
  @override
  void initState() {
    getEstimationDetails();
    super.initState();
    //getLocation();
    allBookingsModel = widget.allBookingsModel;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var mBorderColor = AppColors.colorBorder;
    // Widget mShowWidget = Container();
    List<TableRow> alTableRow = [];
    alTableRow.add(TableRow(
        decoration: BoxDecoration(color: AppColors.colorBlack3),
        children: [
          /*-------------------------------Invoice Title----------------------------- */
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
          /*-------------------------------Invoice Description--------------------------- */
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                margin: const EdgeInsets.only(left: AppDimens.dimens_3),
                alignment: Alignment.centerLeft,
                child: Text(Constants.TXT_DISCRIPTION.tr,
                    style: AppStyle.textViewStyleSmall(
                        context: context,
                        color: AppColors.colorBlack2,
                        fontWeightDelta: 0,
                        fontSizeDelta: -2)),
                height: AppDimens.dimens_25,
              )),
          /*-------------------------------Invoice Qty--------------------------- */

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
          /*-------------------------------Invoice price--------------------------- */

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
          /*-------------------------------Invoice Amount--------------------------- */

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

    /*
    if (mShowData == ShowData.showData) {
      for (var element in allBookingsModel.result![0].estimation!.items!) {
        alTableRow.add(TableRow(
            decoration: BoxDecoration(color: AppColors.colorWhite),
            children: [
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                    margin: const EdgeInsets.only(left: AppDimens.dimens_3),
                    alignment: Alignment.centerLeft,
                    child: Text(element.title!,
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
                    child: Text(element.description!,
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
                    child: Text(element.quantity!,
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
                    child: Text(element.price!,
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
                    child: Text(element.amount!,
                        style: AppStyle.textViewStyleSmall(
                            context: context,
                            color: AppColors.colorBlack2,
                            fontWeightDelta: 0,
                            fontSizeDelta: -2)),
                  )),
            ]));
      }
    }*/
    return Scaffold(
      appBar: AppViews.initAppBar(
        mContext: context,
        centerTitle: false,
        strTitle: "Estimation".tr,
        isShowNotification: false,
        isShowSOS: false,
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.getMainBgColor(),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start//,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // profile pic and name
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              Constants.TXT_CUSTOMER_ESTIMATION.tr.toUpperCase(),
                              style: AppStyle.textViewStyleNormalBodyText2(
                                  context: context,
                                  color: AppColors.colorBlack,
                                  fontWeightDelta: 1,
                                  fontSizeDelta: 2)),
                          Text(Constants.TXT_TAX_INVOICE.tr,
                              style: AppStyle.textViewStyleSmall(
                                  context: context,
                                  color: AppColors.colorBlack,
                                  fontWeightDelta: 0,
                                  fontSizeDelta: -1)),
                        ],
                      ),
                      Row(
                        children: [
                      const Icon(Icons.download_rounded,
                          size: AppDimens.dimens_17),
                      const SizedBox(
                        width: AppDimens.dimens_3,
                      ),
                      InkWell(
                        child: Text(Constants.TXT_DOWNLOAD_INVOICE.tr,
                            style: AppStyle.textViewStyleSmall(
                                context: context,
                                color: AppColors.colorBlack,
                                fontWeightDelta: 0,
                                fontSizeDelta: 0)),
                        onTap: () {},
                      )
                        ],
                      ),
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

                const SizedBox(height: 10.0),
                //-----------invoice id ,invoice date ,
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(Constants.TXT_CUSTOMER_NAME.tr,
                          style: AppStyle.textViewStyleSmall(
                              context: context,
                              color: AppColors.colorBlack,
                              fontWeightDelta: 1,
                              fontSizeDelta: 1)),
                      Text(
                          "${allBookingsModel.customer!.firstName}  ${allBookingsModel.customer!.lastName}",
                          style: AppStyle.textViewStyleSmall(
                              context: context,
                              color: AppColors.colorBlack2,
                              fontWeightDelta: -1,
                              fontSizeDelta: -1)),
                    ],
                  ),
                ),
                const SizedBox(height: 5.0),
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Text("Invoice Number :".tr,
                          style: AppStyle.textViewStyleSmall(
                              context: context,
                              color: AppColors.colorBlack,
                              fontWeightDelta: 0,
                              fontSizeDelta: -2)),
                      Text(
                          allBookingsModel.estimation!.invoiceNumber
                              .toString(),
                          style: AppStyle.textViewStyleSmall(
                              context: context,
                              color: AppColors.colorBlack2,
                              fontWeightDelta: 0,
                              fontSizeDelta: -2)),
                    ],
                  ),
                ),
                const SizedBox(height: 5.0),
                Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(Constants.TXT_INVOICE_DATE.tr,
                            style: AppStyle.textViewStyleSmall(
                                context: context,
                                color: AppColors.colorBlack,
                                fontWeightDelta: 0,
                                fontSizeDelta: -2)),
                        Text(
                            allBookingsModel.estimation!.createdAt!
                                .substring(0, 10),
                            style: AppStyle.textViewStyleSmall(
                                context: context,
                                color: AppColors.colorBlack2,
                                fontWeightDelta: 0,
                                fontSizeDelta: -2)),
                      ],
                    )
                  ],
                ),
                //------------------end------------
              ],
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
                children:
                    //alTableRow,
                    [
                  /*-------------------------------Invoice Title----------------------------- */
                  TableRow(
                    decoration: BoxDecoration(color: AppColors.colorBlack3),
                    children: [
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Container(
                            margin:
                                const EdgeInsets.only(left: AppDimens.dimens_3),
                            alignment: Alignment.centerLeft,
                            child: Text(Constants.TXT_TITLE.tr,
                                style: AppStyle.textViewStyleSmall(
                                    context: context,
                                    color: AppColors.colorBlack2,
                                    fontWeightDelta: 0,
                                    fontSizeDelta: -2)),
                            height: AppDimens.dimens_25,
                          )),

                      /*-------------------------------Invoice Description--------------------------- */
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Container(
                            margin:
                                const EdgeInsets.only(left: AppDimens.dimens_3),
                            alignment: Alignment.centerLeft,
                            child: Text(Constants.TXT_DISCRIPTION,
                                style: AppStyle.textViewStyleSmall(
                                    context: context,
                                    color: AppColors.colorBlack2,
                                    fontWeightDelta: 0,
                                    fontSizeDelta: -2)),
                            height: AppDimens.dimens_25,
                          )),
                      /*-------------------------------Invoice Qty--------------------------- */

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
                      /*-------------------------------Invoice price--------------------------- */

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
                      /*-------------------------------Invoice Amount--------------------------- */

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
                    ],
                  ),

                  /*------------------------------values of Title Description Qty Price Amount--------------------------*/
                  ...List.generate( allBookingsModel.estimation!.items!.length, (index) =>
      TableRow(
                    // decoration: BoxDecoration(color: AppColors.colorBlack3),
                    children: [
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Container(
                            margin: const EdgeInsets.only(left: AppDimens.dimens_3),
                            alignment: Alignment.centerLeft,
                            child: Text(
                                allBookingsModel.estimation!.items![index].title
                                    .toString(),
                                style: AppStyle.textViewStyleSmall(
                                    context: context,
                                    color: AppColors.colorBlack2,
                                    fontWeightDelta: 0,
                                    fontSizeDelta: -2)),
                            //height: AppDimens.dimens_25,
                          )),

                      /*-------------------------------Invoice Description--------------------------- */
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Container(
                            margin:
                                const EdgeInsets.only(left: AppDimens.dimens_3),
                            alignment: Alignment.centerLeft,
                            child: Text(
                                allBookingsModel
                                    .estimation!.items![index].description
                                    .toString(),
                                style: AppStyle.textViewStyleSmall(
                                    context: context,
                                    color: AppColors.colorBlack2,
                                    fontWeightDelta: 0,
                                    fontSizeDelta: -2)),
                            //height: AppDimens.dimens_25,
                          )),
                      /*-------------------------------Invoice Qty--------------------------- */

                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                                allBookingsModel
                                    .estimation!.items![index].quantity
                                    .toString(),
                                style: AppStyle.textViewStyleSmall(
                                    context: context,
                                    color: AppColors.colorBlack2,
                                    fontWeightDelta: 0,
                                    fontSizeDelta: -2)),
                            height: AppDimens.dimens_25,
                          )),
                      /*-------------------------------Invoice price--------------------------- */

                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                                allBookingsModel.estimation!.items![index].price
                                    .toString(),
                                style: AppStyle.textViewStyleSmall(
                                    context: context,
                                    color: AppColors.colorBlack2,
                                    fontWeightDelta: 0,
                                    fontSizeDelta: -2)),
                            height: AppDimens.dimens_25,
                          )),
                      /*-------------------------------Invoice Amount--------------------------- */

                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                                allBookingsModel.estimation!.items![index].amount
                                    .toString(),
                                style: AppStyle.textViewStyleSmall(
                                    context: context,
                                    color: AppColors.colorBlack2,
                                    fontWeightDelta: 0,
                                    fontSizeDelta: -2)),
                            height: AppDimens.dimens_25,
                          )),
                    ],
                  ),
                      )
                ],
                columnWidths: const {
                  //0: FlexColumnWidth(2),
                  1: FlexColumnWidth(2),
                  //2: FlexColumnWidth(2),
                  //3: FlexColumnWidth(2),
                },
              ),
            ),

            /*-----------------------------------------Table-----------------------*/
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
                          child: Text(
                              allBookingsModel.estimation!.subTotal.toString(),
                              style: AppStyle.textViewStyleSmall(
                                  context: context,
                                  color: AppColors.colorBlack2,
                                  fontWeightDelta: 0,
                                  fontSizeDelta: -2)),
                          height: AppDimens.dimens_25,
                        )),
                  ]),
                  /* TableRow(children: [
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
                    // TableCell(
                    //     verticalAlignment: TableCellVerticalAlignment.middle,
                    //     child: Container(
                    //       alignment: Alignment.center,
                    //       child: Text(mEstimationDetailModel!.discount,
                    //           style: AppStyle.textViewStyleSmall(
                    //               context: context,
                    //               color: AppColors.colorBlack2,
                    //               fontWeightDelta: 0,
                    //               fontSizeDelta: -2)),
                    //       height: AppDimens.dimens_25,
                    //     )),
                  ]),
                  */
                  TableRow(children: [
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text("Service Tax ( 5 %)".tr,
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
                          child: Text(
                              allBookingsModel.estimation!.serviceTax!
                                  .roundToDouble()
                                  .toString(),
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
                            child: Text(
                                allBookingsModel.estimation!.grandTotal
                                    .toString(),
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
                  allBookingsModel.estimation!.estimationImage!=null? Container(

                    height:50,
                    width: 100,
                    margin: const EdgeInsets.only(right: AppDimens.dimens_10),
                    child: Image.network(
                      allBookingsModel.estimation!.estimationImage!.first,
                     fit: BoxFit.contain,
                     // height: AppDimens.dimens_50,
                    ),
                  ):Container(
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
                      // Container(
                      //   alignment: Alignment.centerLeft,
                      //   child: Text("Contact information",
                      //       style: AppStyle.textViewStyleSmall(
                      //           context: context,
                      //           color: AppColors.colorBlack,
                      //           fontWeightDelta: 1,
                      //           fontSizeDelta: -2)),
                      // ),
                      // Container(
                      //   alignment: Alignment.centerLeft,
                      //   child: Text("Mobile: +971 1234567890",
                      //       style: AppStyle.textViewStyleSmall(
                      //           context: context,
                      //           color: AppColors.colorBlack,
                      //           fontWeightDelta: 0,
                      //           fontSizeDelta: -4)),
                      // ),
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

            widget.isCompleted ?const SizedBox(): Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                  top: AppDimens.dimens_20,
                  bottom: AppDimens.dimens_20,
                  left: AppDimens.dimens_5,
                  right: AppDimens.dimens_5),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: CustomButton(
                        isGradient: true,
                        isRoundBorder: true,
                        fontColor: AppColors.colorWhite,
                        fontSize: -1,
                        fontWeight: 1,
                        // width: size.width / 1.5,
                        height: AppDimens.dimens_38,
                        onPressed: () {
                          if (widget
                                  .allBookingsModel.estimation?.offerStatus ==
                              "pending") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CheckoutScreen(
                                          isPartialPay: true,
                                          bookingID: allBookingsModel.id,
                                          amount: allBookingsModel
                                              .estimation!.grandTotal
                                              .toString(),
                                          previousAmount: allBookingsModel
                                              .estimation!.subTotal
                                              .toString(),
                                        )));
                          }else{
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CheckoutScreen(
                                      isPartialPay: true,
                                      bookingID: allBookingsModel.id,
                                      amount: allBookingsModel
                                          .estimation!.grandTotal
                                          .toString(),
                                      previousAmount: allBookingsModel
                                          .estimation!.subTotal
                                          .toString(),
                                    )));
                          }
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const CheckoutScreen(
                          //
                          //             // sourceId:
                          //             //     widget.mEstimatesModel.source!.id,
                          //             // estimateId: widget.mEstimatesModel.id,
                          //             // paymentStatus: 'partialPayment',
                          //             )));
                        },
                        strTitle:
                            widget.allBookingsModel.estimation?.offerStatus ==
                                    'pending'
                                ? 'Pay 50%'.tr
                                : "Pay 50%".tr),
                  ),
                  widget.allBookingsModel.estimation?.offerStatus == 'pending'
                      ? Flexible(
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: CustomButton(
                                  isGradient: false,
                                  color: AppColors.colorYellowShade,
                                  isRoundBorder: true,
                                  fontColor: AppColors.colorBlack,
                                  fontSize: -1,
                                  fontWeight: 1,
                                  height: AppDimens.dimens_38,
                                  onPressed: allBookingsModel
                                              .estimation!.isOfferCreated ==
                                          true
                                      ? () {
                                          Global.showToastAlert(
                                              context: context,
                                              strTitle: "",
                                              strMsg: "Offer Already Created".tr,
                                              toastType: TOAST_TYPE.toastError);
                                        }
                                      : () {
                                          showDialog(
                                            context: context,
                                            builder: (_) => LogoutOverlay(
                                              noteController:_textOfferNotecontroller,
                                              textcontroller:
                                                  _textOffercontroller,
                                              onCancelTap: () {
                                                _textOffercontroller.clear();
                                                Navigator.of(context).pop();
                                              },
                                              onSubmitTap: () {
                                                if (_textOffercontroller
                                                    .text.isNotEmpty) {


                                                  _estimationListController
                                                      .createAnOffer(
                                                    offerNote:_textOfferNotecontroller.text ,
                                                          estimateid:
                                                              allBookingsModel
                                                                  .id,
                                                          offerAmount:
                                                              _textOffercontroller
                                                                  .text);
                                                  _textOfferNotecontroller.clear();
                                                  _textOffercontroller.clear();
                                                  Navigator.of(context).pop();
                                                }
// Future.delayed(Duration(seconds: 3),(){
//   Navigator.pu
//   EstimationFragment
//                                 }
//                                 );
                                              },
                                            ),
                                          );
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) => CheckoutScreen(
                                          //           // sourceId:
                                          //           //     widget.mEstimatesModel.source!.id,
                                          //           // estimateId: widget.mEstimatesModel.id,
                                          //           // paymentStatus: 'partialPayment',
                                          //         )));
                                        },
                                  strTitle: 'Make Offer'.tr),
                            ),
                            //width: size.width / 1.8,
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    width: 5,
                  ),
                  //const Spacer(),
                  Flexible(
                    child: SizedBox(
                      child: CustomButton(
                          fontSize: -1,
                          fontWeight: 1,
                          isGradient: true,
                          isRoundBorder: true,
                          // color: AppColors.greyDateBG,
                          fontColor: AppColors.colorWhite,
                          height: AppDimens.dimens_38,
                          onPressed: () => displayTextInputDialog(),
                          strTitle: Constants.TXT_DECLINE.tr),
                      //  width: size.width / 3.2,
                    ),
                  ),
                ],
              ),
            ),

            // Expanded(child: Container()),
          ],
        ),
      ),

      // Stack(
      //   children: [
      //     Container(
      //       color: AppColors.colorBlueStart,
      //       height: 0,
      //     ),
      //
      //     widgetM,
      //     AppViews.showLoadingWithStatus(isShowLoader)
      //   ],
      // ),
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
                declineEstimation(
                    id: allBookingsModel.id.toString(), reason: strReason);
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

    // HashMap<String, Object> requestParams = HashMap();

    // var categories = await EstimatesRepo()
    //     .getEstimatesDetail(requestParams, widget.allBookingsModel.result![0].id.toString());

    // categories.fold((failure) {
    //   Global.showToastAlert(
    //       context: context,
    //       strTitle: "",
    //       strMsg: failure.MESSAGE,
    //       toastType: TOAST_TYPE.toastError);
    //   setState(() {
    //     mShowData = ShowData.showNoDataFound;
    //   });
    // }, (mResult) {
    //   print("Estimation detaisl pdf ---------2---");
    //   print(widget.allBookingsModel.result![0].id);
    //   setState(() {
    //     List<Estimation> alEstimation =
    //     mResult.responseData as List<Estimation>;
    //     if (alEstimation.isNotEmpty) {
    //       estimationDetails = alEstimation.first;
    //       mShowData = ShowData.showData;
    //     } else {
    //       mShowData = ShowData.showNoDataFound;
    //     }
    //   });
    // });
  }

  declineEstimation({required String reason, required String id}) async {
    setState(() {
      mShowData = ShowData.showLoading;
      // isShowLoader = true;
    });

    HashMap<String, Object> requestParams = HashMap();

    requestParams['bookingID'] = id;
    requestParams['declineReason'] = reason;

    var categories = await EstimatesRepo().declineEstimate(
      requestParams,
    );

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
      //Get.find<EstimationListController>().getEstimation('submitted');
    });
  }
}
