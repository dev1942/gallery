import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:otobucks/View/Home/Controllers/home_screen_controller.dart';
import 'package:otobucks/View/Transactions/Controllers/transaction_controller.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/View/Transactions/Models/transaction_model.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/widgets/fade_in_image.dart';
import 'package:otobucks/widgets/image_selection_bottom_sheet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../PurchaseHistory/Widgets/InvoiceDetailsClipper.dart';

class TransactionDetailScreen extends StatefulWidget {
  final TransactionModel transactionModel;

  const TransactionDetailScreen({Key? key, required this.transactionModel})
      : super(key: key);

  @override
  TransactionDetailScreenState createState() => TransactionDetailScreenState();
}

class TransactionDetailScreenState extends State<TransactionDetailScreen> {
  ShowData mShowData = ShowData.showData;

  // ShowData mShowData = ShowData.showLoading;
  ScreenshotController screenshotController = ScreenshotController();
  bool connectionStatus = false;
  bool isShowLoader = false;

  sharePhoto() async {
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((Uint8List? image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath =
            await File('${directory.path}/Otobucks-Receipt.png').create();
        await imagePath.writeAsBytes(image);
//..............................................Save to gallery...................................
//         final result = await ImageGallerySaver.saveImage(
//             image,
//             quality: 60,
//             name: "hello");
//         print(result);
        /// Share Plugin
        await Share.shareFiles([imagePath.path]);
      }
    });
  }

  saveAsPhoto() async {
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((Uint8List? image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath =
            await File('${directory.path}/Otobucks-Receipt.png').create();
        await imagePath.writeAsBytes(image);
//...................sav to gallery
        final result = await ImageGallerySaver.saveImage(image,
            quality: 60, name: "hello");
        Global.showToastAlert(
            context: context,
            strTitle: "Success",
            strMsg: "Receipt Saved to Gallery",
            toastType: TOAST_TYPE.toastSuccess);
        //-----------------------------------------------Share Plugin-------------------------------
        // await Share.shareFiles([imagePath.path]);
      }
    });
  }

  @override
  void initState() {
    // print( widget.transactionModel.metadata
    //     .service);
    // print( widget.transactionModel.metadata
    //     .service!.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = AppDimens.dimens_36;
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
            // Container(height: size.height, child: widgetM),
            Column(
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
                      //...................Main Container for profile pictures.....................................
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
                        margin:
                            const EdgeInsets.only(right: AppDimens.dimens_10),
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
                                        .capitalize ??
                                    "",
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
                                    color:
                                        AppColors.colorWhite.withOpacity(0.7),
                                    fontSizeDelta: -2,
                                    fontWeightDelta: 0),
                              )),
                        ],
                      )),
                    ],
                  ),
                ),
                addVerticleSpace(20),
                Screenshot(
                  controller: screenshotController,
                  child: Column(
                    children: [
                      //........Profile container...................................

                      //--------------Container 1 --------------------------------------
                      //..............Container 2 ..................................................
                      ClipPath(
                        clipper: InvoiceContetntClipper(),
                        child: Container(
                          width: Get.width,
                          height: 400,
                          decoration:
                              BoxDecoration(color: AppColors.grayDashboardItem),
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              addVerticleSpace(10),
                              CircleAvatar(
                                backgroundColor: AppColors.colorGreen,
                                child:
                                    const Icon(Icons.done, color: Colors.white),
                              ),
                              Text(
                                "OtoBucks",
                                style: TextStyle(
                                    color: AppColors.colorBlueEnd,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700),
                              ),
                              addVerticleSpace(5),
                              Text(
                                "Transaction Successful",
                                style: TextStyle(
                                    color: AppColors.colorGreen,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                              const Text("Money has been sent to :"),
                              AppViews.addDivider(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.transactionModel.createdAt
                                            .toString()
                                            .split('T')[0],
                                        style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                          "ID#${widget.transactionModel.transactionId}",
                                          style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  addVerticleSpace(17),
                                  const Text(
                                    "Service Details",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "Title : ${widget.transactionModel.metadata.service?.title}",
                                    style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "Provider : ${widget.transactionModel.metadata.provider?.firstName + " " + widget.transactionModel.metadata.provider?.lastName}",
                                    style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  addVerticleSpace(17),
                                  const Text(
                                    "Transaction Details",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Type : ",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "${widget.transactionModel.itemType}",
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Currency : ",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "${widget.transactionModel.currency}",
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Amount : ",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "AED ${widget.transactionModel.amount} /-",
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.colorGreen),
                                      ),
                                    ],
                                  ),
                                  addVerticleSpace(22),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                    //...................................
                  ),
                ),
              ],
            ),

            AppViews.showLoadingWithStatus(isShowLoader),
            Positioned(
              top: 460,
              left: 30,
              right: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      sharePhoto();
                    },
                    child: Column(
                      children: [
                        const Icon(
                          Icons.share_outlined,
                          size: 20,
                        ),
                        const Text(
                          "Share",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      saveAsPhoto();
                    },
                    child: Column(
                      children: [
                        const Icon(
                          Icons.image_outlined,
                          size: 20,
                        ),
                        const Text(
                          "Save to Gallery",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _createPDF();
                    },
                    child: Column(
                      children: [
                        const Icon(
                          Icons.file_open_outlined,
                          size: 20,
                        ),
                        const Text(
                          "Save to PDF",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Column(
                      children: [
                        const Icon(
                          Icons.cancel_presentation,
                          size: 20,
                        ),
                        const Text(
                          "Go Back",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
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

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();
    // final page = document.pages.add();
    // page.graphics.drawString(
    //     'OtoBucks Transaction Receipt',
    //     PdfStandardFont(
    //       PdfFontFamily.helvetica,
    //       30,
    //     ));

    // page.graphics.drawImage(PdfBitmap(await _readImageData("autofix.png")),
    //Rect.fromLTWH(0, 100, 440, 200));
    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 24),
        cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));
    grid.columns.add(count: 2);
    //...........................................ID ROW..............................................................
    grid.headers.add(1);
    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'ID';
    header.cells[1].value = widget.transactionModel.transactionId ?? "";
    //................ransaction type..............................................................
    PdfGridRow row = grid.rows.add();
    //................Service title..............................................................
    row.cells[0].value = "Transaction Type";
    row.cells[1].value = widget.transactionModel.itemType.toString();
    //.......................Service Title.....................................................
    row = grid.rows.add();
    row.cells[0].value = "Service Title";
    row.cells[1].value =
        widget.transactionModel.metadata.service?.title.toString();
    //................Provider row..............................................................
    row = grid.rows.add();
    row.cells[0].value = 'Service Provider';
    row.cells[1].value = widget.transactionModel.metadata.provider == null
        ? Get.find<HomeScreenController>().fullName
        : widget.transactionModel.metadata.provider?.firstName;
    //.......................................Payment Status...........................
    row = grid.rows.add();
    row.cells[0].value = 'Payment Status';
    row.cells[1].value = widget.transactionModel.metadata.type.toString();
    //..................Transaction date row.............................................
    row = grid.rows.add();
    row.cells[0].value = 'Transaction Date';
    row.cells[1].value =
        widget.transactionModel.createdAt.toString().split('T')[0];
    //..................Transaction Amount.............................................
    row = grid.rows.add();
    row.cells[0].value = 'Transaction Amount';
    row.cells[1].value =
        "AED${widget.transactionModel.amount.toString()} /-".split('T')[0];
    grid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));
    List<int> bytes = await document.save();
    document.dispose();
    Get.put(TransactionController()).saveAndLaunchFile(bytes, 'OtoBucks.pdf');
  }

  Future<Uint8List> _readImageData(String name) async {
    final data = await rootBundle.load('assets/images/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
}
