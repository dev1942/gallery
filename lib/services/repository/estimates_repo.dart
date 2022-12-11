import 'dart:collection';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:otobucks/global/connectivity_status.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/global/url_collection.dart';
import 'package:otobucks/model/failure.dart';
import 'package:otobucks/model/result.dart';
import 'package:otobucks/model/success.dart';
import 'package:otobucks/services/rest_api/request_listener.dart';
import '../../model/category_model.dart';
import '../../model/estimates_model.dart';
import '../../model/estimation_detail_model.dart';
import '../rest_api/request_listener_multipart.dart';
class EstimatesRepo {
  //....................create estimation new API done......................
  Future<Either<Failure, Success>> createEstimates(
      HashMap<String, String> requestParams,
      HashMap<String, String> requestParamsImages,
      ReqType mReqType) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(
          DATA: "",
          MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION,
          STATUS: false));
    }

    try {
      String response = await ReqListenerMultiPart.fetchPost(
          strUrl: RequestBuilder.API_CREATE_ESTIMATES,
          requestParams: requestParams,
          requestParamsImages: requestParamsImages,
          mReqType: mReqType);
      Result? mResponse;
      if (Global.equalsIgnoreCase(response, "413")) {
        return Left(Failure(
            DATA: "", MESSAGE: AppAlert.ALERT_FILE_SIZE_ALL, STATUS: false));
      }

      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(
            Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        Success mSuccess = Success(
            responseStatus: mResponse!.responseStatus,
            responseData: "alServices",
            responseMessage: mResponse.responseMessage);
Logger().i(mResponse.responseStatus);
        return Right(mSuccess);
      }

      if (!Global.checkNull(mResponse!.responseMessage)) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(Failure(
          MESSAGE: mResponse.responseMessage,
          STATUS: false,
          DATA: mResponse.responseData != null
              ? mResponse.responseData as Object
              : ""));
    } catch (e) {

      Logger().e(e.toString());
      return Left(Failure(
          STATUS: false,
          MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING,
          DATA: ""));
    }
  }
//...............Reschedual estimates.........................
  Future<Either<Failure, Success>> rescheduleEstimates(
      HashMap<String, String> requestParams,
      HashMap<String, String> requestParamsImages,
      ReqType mReqType,
      String serviceId) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(
          DATA: "",
          MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION,
          STATUS: false));
    }

    try {
      String response = await ReqListenerMultiPart.fetchPost(
          strUrl: RequestBuilder.API_CREATE_ESTIMATES + serviceId,
          requestParams: requestParams,
          requestParamsImages: requestParamsImages,
          mReqType: mReqType);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(
            Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        Success mSuccess = Success(
            responseStatus: mResponse!.responseStatus,
            responseData: "alServices",
            responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      // ignore: unnecessary_null_comparison
      if (!Global.checkNull(mResponse!.responseMessage)) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(Failure(
          MESSAGE: mResponse.responseMessage,
          STATUS: false,
          DATA: mResponse.responseData != null
              ? mResponse.responseData as Object
              : ""));
    } catch (e) {
      log(e.toString());
      return Left(Failure(
          STATUS: false,
          MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING,
          DATA: ""));
    }
  }
//...................service details...................................
  Future<Either<Failure, Success>> getServiceDetails(
      HashMap<String, Object> requestParams,
      {required String serviceId}) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(
          DATA: "",
          MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION,
          STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          strUrl: RequestBuilder.API_GET_SERVICES + serviceId,
          requestParams: requestParams,
          mReqType: ReqType.get,
          mParamType: ParamType.simple);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(
            Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        List<CategoryModel> alCategory = [];
        List data = mResponse?.responseData as List;
        for (var dataItem in data) {
          CategoryModel mCategoryModel = CategoryModel.fromJson(dataItem);
          alCategory.add(mCategoryModel);
        }

        Success mSuccess = Success(
            responseStatus: mResponse!.responseStatus,
            responseData: alCategory,
            responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      if (!Global.checkNull(mResponse!.responseMessage)) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(Failure(
          MESSAGE: mResponse.responseMessage,
          STATUS: false,
          DATA: mResponse.responseData != null
              ? mResponse.responseData as Object
              : ""));
    } catch (e) {
      log(e.toString());
      return Left(Failure(
          STATUS: false,
          MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING,
          DATA: ""));
    }
  }
//....................all estimates old API......................
  Future<Either<Failure, Success>> getEstimates(
      HashMap<String, Object> requestParams, String mEstimationStatus) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(
          DATA: "",
          MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION,
          STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          //strUrl:'estimates',
        strUrl: 'estimates/?status=$mEstimationStatus',
          requestParams: requestParams,
          mReqType: ReqType.get,
          mParamType: ParamType.simple);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(
            Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        List<EstimatesModel> alEstimates = [];
        List data = mResponse?.responseData as List;
        for (var dataItem in data) {
          EstimatesModel mEstimatesModel = EstimatesModel.fromJson(dataItem);

          alEstimates.add(mEstimatesModel);
        }

        Success mSuccess = Success(
            responseStatus: mResponse!.responseStatus,
            responseData: alEstimates,
            responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      if (!Global.checkNull(mResponse!.responseMessage)) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(Failure(
          MESSAGE: mResponse.responseMessage,
          STATUS: false,
          DATA: mResponse.responseData != null
              ? mResponse.responseData as Object
              : ""));
    } catch (e) {
      Logger().e("from Create estimation request${e.toString()}");
      return Left(Failure(
          STATUS: false,
          MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING,
          DATA: ""));
    }
  }
//-----------------cancel estimate old API................
  Future<Either<Failure, Success>> getCancelEstimates(
      HashMap<String, Object> requestParams) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(
          DATA: "",
          MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION,
          STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          strUrl: RequestBuilder.API_CANCEL_BOOKING_REQUESTS,
          requestParams: requestParams,
          mReqType: ReqType.post,
          mParamType: ParamType.json);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(
            Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        Success mSuccess = Success(
            responseStatus: mResponse!.responseStatus,
            responseData: "",
            responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      if (!Global.checkNull(mResponse!.responseMessage)) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(Failure(
          MESSAGE: mResponse.responseMessage,
          STATUS: false,
          DATA: mResponse.responseData != null
              ? mResponse.responseData as Object
              : ""));
    } catch (e) {
      log(e.toString());
      return Left(Failure(
          STATUS: false,
          MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING,
          DATA: ""));
    }
  }
//.......................Get all cancelled old API..........
  Future<Either<Failure, Success>> declineEstimate(
      HashMap<String, Object> requestParams, String estimateId) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(
          DATA: "",
          MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION,
          STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          strUrl: 'estimates/decline/$estimateId',
          requestParams: requestParams,
          mReqType: ReqType.patch,
          mParamType: ParamType.json);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(
            Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        Success mSuccess = Success(
            responseStatus: mResponse!.responseStatus,
            responseData: "",
            responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      if (!Global.checkNull(mResponse!.responseMessage)) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(
          Failure(MESSAGE: mResponse.responseMessage, STATUS: false, DATA: ""));
    } catch (e) {
      log(e.toString());
      return Left(Failure(
          STATUS: false,
          MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING,
          DATA: ""));
    }
  }
//........booking estimation ........................
  Future<Either<Failure, Success>> bookingEstimation(
      HashMap<String, Object> requestParams) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(
          DATA: "",
          MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION,
          STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          // strUrl: 'bookings/serviceBooking',
           strUrl: 'promotions/book',
          requestParams: requestParams,
          mReqType: ReqType.post,
          mParamType: ParamType.json);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(
            Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        Success mSuccess = Success(
            responseStatus: mResponse!.responseStatus,
            responseData: "",
            responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      if (!Global.checkNull(mResponse!.responseMessage)) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(
          Failure(MESSAGE: mResponse.responseMessage, STATUS: false, DATA: ""));
    } catch (e) {
      Logger().e("From Promotion Book Estimation ${e.toString()}");

      return Left(Failure(
          STATUS: false,
          MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING,
          DATA: ""));
    }
  }
// estimationDetails..................................
  Future<Either<Failure, Success>> getEstimatesDetail(
      HashMap<String, Object> requestParams, String estimateId) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(
          DATA: "",
          MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION,
          STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          strUrl: RequestBuilder.API_GET_ESTIMATES + "/getOne?id=$estimateId",
          requestParams: requestParams,
          mReqType: ReqType.get,
          mParamType: ParamType.simple);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(
            Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        List<EstimationDetailModel> alEstimates = [];
        List data = mResponse?.responseData as List;
        for (var dataItem in data) {
          EstimationDetailModel mEstimationDetailModel =
              EstimationDetailModel.fromJson(dataItem);
          alEstimates.add(mEstimationDetailModel);
        }

        Success mSuccess = Success(
            responseStatus: mResponse!.responseStatus,
            responseData: alEstimates,
            responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      if (!Global.checkNull(mResponse!.responseMessage)) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(Failure(
          MESSAGE: mResponse.responseMessage,
          STATUS: false,
          DATA: mResponse.responseData != null
              ? mResponse.responseData as Object
              : ""));
    } catch (e) {
      log(e.toString());
      return Left(Failure(
          STATUS: false,
          MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING,
          DATA: ""));
    }
  }

  //-------------------------------Create An Offer---------------
  Future<Either<Failure, Success>> CreateAnOfferEstimate(
      HashMap<String, Object> requestParams) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(
          DATA: "",
          MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION,
          STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          strUrl:'estimates/createOffer',
          requestParams: requestParams,
          mReqType: ReqType.post,
          mParamType: ParamType.json);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(
            Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        Success mSuccess = Success(
            responseStatus: mResponse!.responseStatus,
            responseData: {},
            responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      if (!Global.checkNull(mResponse!.responseMessage)) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(Failure(
          MESSAGE: mResponse.responseMessage,
          STATUS: false,
          DATA: mResponse.responseData != null
              ? mResponse.responseData as Object
              : ""));
    } catch (e) {
      log(e.toString());
      return Left(Failure(
          STATUS: false,
          MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING,
          DATA: ""));
    }
  }
  //.....................Get All Booking by inzimam....................
  // Future<Either<Failure, Success>> getAllBookings(
  //     HashMap<String, Object> requestParams,) async {
  //   bool connectionStatus = await ConnectivityStatus.isConnected();
  //   if (!connectionStatus) {
  //     return Left(Failure(
  //         DATA: "",
  //         MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION,
  //         STATUS: false));
  //   }
  //   try {
  //     String response = await ReqListener.fetchPost(
  //       //strUrl:'estimates',
  //         strUrl: 'bookings/bookService/',
  //         requestParams: requestParams,
  //         mReqType: ReqType.get,
  //         mParamType: ParamType.simple);
  //     Result? mResponse;
  //     if (response.isNotEmpty) {
  //       mResponse = Global.getData(response);
  //     } else {
  //       return Left(
  //           Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
  //     }
  //     if (mResponse?.responseStatus == true) {
  //       List<AllBookingsModel> alBookings = [];
  //       List data = mResponse?.responseData as List;
  //       Logger().e("Data from response is ${data}");
  //       for (var dataItem in data) {
  //         AllBookingsModel allBookingsModel = AllBookingsModel.fromJson(dataItem);
  //         alBookings.add(allBookingsModel);
  //         alBookings=alBooking;
  //         Logger().e( "Status of a booking from list===============>>${alBookings[0].status}");
  //
  //       }
  //       Success mSuccess = Success(
  //           responseStatus: mResponse!.responseStatus,
  //           responseData: alBookings,
  //           responseMessage: mResponse.responseMessage);
  //       return Right(mSuccess);
  //     }
  //     if (!Global.checkNull(mResponse!.responseMessage)) {
  //       mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
  //     }
  //
  //     return Left(Failure(
  //         MESSAGE: mResponse.responseMessage,
  //         STATUS: false,
  //         DATA: mResponse.responseData != null
  //             ? mResponse.responseData as Object
  //             : ""));
  //   } catch (e) {
  //     Logger().e("FromMy Booking Repo ${e.toString()}");
  //
  //     return Left(Failure(
  //         STATUS: false,
  //         MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING,
  //         DATA: ""));
  //   }
  // }


}
