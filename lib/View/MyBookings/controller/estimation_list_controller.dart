import 'dart:collection';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/services/repository/estimates_repo.dart';
import '../Models/view_booking_model.dart';

class EstimationListController extends GetxController {
  ShowData mShowData = ShowData.showLoading;
  bool connectionStatus = false;
  bool isShowLoader = false;

  int indexM = 0;
  List<Estimation> alEstimates = [];
  //List<AllBookingsModel> alBookings = [];

  //...................Get All Bookings from Repo......................
  // Future getBooking() async {
  //   Logger().e( "Booking method started");
  //
  //   mShowData = ShowData.showLoading;
  //
  //   update();
  //   // isShowLoader = true;
  //   HashMap<String, Object> requestParams = HashMap();
  //   var categories = await EstimatesRepo().getAllBookings(requestParams,);
  //   categories.fold((failure) {
  //     Global.showToastAlert(
  //         context: Get.overlayContext!,
  //         strTitle: "",
  //         strMsg: failure.MESSAGE,
  //         toastType: TOAST_TYPE.toastError);
  //     mShowData = ShowData.showNoDataFound;
  //     update();
  //   }, (mResult) {
  //
  //     alBookings = mResult.responseData as List<AllBookingsModel>;
  //     for(int i=0;i<alBookings.length;i++){
  //       Logger().w(alEstimates[i].address);
  //       Logger().w(alEstimates[i].offerCreated);
  //     }
  //     if (alBookings.isNotEmpty) {
  //       mShowData = ShowData.showData;
  //
  //     } else {
  //       mShowData = ShowData.showNoDataFound;
  //     }
  //     update();
  //   });
  // }
  Future getEstimation(String status) async {
    mShowData = ShowData.showLoading;

    update();
    // isShowLoader = true;

    HashMap<String, Object> requestParams = HashMap();

    var categories = await EstimatesRepo().getEstimates(requestParams, status);

    categories.fold((failure) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);

      mShowData = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      alEstimates = mResult.responseData as List<Estimation>;
      for (int i = 0; i < alEstimates.length; i++) {
        Logger().w(alEstimates[i].offerStatus);
        Logger().w(alEstimates[i].isOfferCreated);
      }
      if (alEstimates.isNotEmpty) {
        mShowData = ShowData.showData;
      } else {
        mShowData = ShowData.showNoDataFound;
      }
      update();
    });
  }

  //----------------------------Create Offer-post Api------------
  createAnOffer({String? estimateid, var offerAmount, String? offerNote}) async {
    mShowData = ShowData.showLoading;
    update(); // isShowLoader = true;

    HashMap<String, Object> requestParams = HashMap();
    requestParams['bookingID'] = estimateid!;
    requestParams['offerAmount'] = offerAmount;
    requestParams['offerNote'] = offerNote ?? "";
    var categories = await EstimatesRepo().createAnOfferEstimate(requestParams);
    categories.fold((failure) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
      mShowData = ShowData.showNoDataFound;

      update();
    }, (mResult) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: "Offer Created Successfully", // mResult.responseMessage,
          toastType: TOAST_TYPE.toastSuccess);
      //getEstimation("submitted");
      update();
    });
  }
}

// //...............test method...............
//   Future<List<AllBookingsModel>> fetchAllRunningShops() async {
//     Logger().w("Method called");
//
//     HashMap<String, String> lHeaders = HashMap();
//     final prefs = await SharedPreferences.getInstance();
//     String? accesToken = prefs.getString(SharedPrefKey.KEY_ACCESS_TOKEN);
//       String accesTokenType = Constants.strTokenType;
//       accesToken = accesTokenType + " " + accesToken!;
//       lHeaders[PARAMS.PARAM_AUTHORIZATION] = accesToken;
//     final response = await http
//         .get(Uri.parse(RequestBuilder.API_GET_ALL_BOOKINGS),
//         headers: lHeaders
//     );
//     List data = jsonDecode(response.body)as List;
//     print(data);
//     if (response.statusCode == 200) {
//       // If the server did return a 200 OK response,
//       // then parse the JSON.
//       for (var i in data) {
//         AllBookingsModel allBookingsModel = AllBookingsModel.fromJson(i);
//         alBookings.add(allBookingsModel);
//       }
//       Logger().w("Status is Ok");
//       print(alBookings);
//       return alBookings;
//     } else {
//       Logger().w("Sresponse not ok");
//
//       // If the server did not return a 200 OK response,
//       // then throw an exception.
//       throw Exception('Failed to load album');
//     }
//     return alBookings;
// }}
