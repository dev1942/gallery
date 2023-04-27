import 'dart:collection';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:otobucks/View/Estimation/Models/estimation_detail_model.dart';
import 'package:otobucks/global/Models/failure.dart';
import 'package:otobucks/global/connectivity_status.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/global/url_collection.dart';
import 'package:otobucks/services/rest_api/request_listener.dart';

import '../../View/Estimation/Models/estimates_model.dart';
import '../../global/Models/result.dart';
import '../../global/Models/success.dart';

class GetProviderBooking {
  String providerId;
  String bookingId;

  GetProviderBooking({required this.providerId, required this.bookingId});

  factory GetProviderBooking.fromJson(Map<dynamic, dynamic> json) {
    return GetProviderBooking(providerId: json['provider']['_id'].toString(), bookingId: json['_id'].toString());
  }
}

class BookingRepo {
  Future<Either<Failure, Success>> getBookingByEstimation(HashMap<String, Object> requestParams, String estimateId) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION, STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          strUrl: 'bookings/getBookingByEstimateId/$estimateId', requestParams: requestParams, mReqType: ReqType.get, mParamType: ParamType.simple);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getDataWithValue(response, 'booking');
      } else {
        return Left(Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        Map data = mResponse?.responseData as Map;

        GetProviderBooking getProviderBooking = GetProviderBooking.fromJson(data);
        // if (mEstimatesModel.status == 'pending')
        // }
        Success mSuccess =
            Success(responseStatus: mResponse!.responseStatus, responseData: getProviderBooking, responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      if (!Global.checkNull(mResponse!.responseMessage)) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(
          Failure(MESSAGE: mResponse.responseMessage, STATUS: false, DATA: mResponse.responseData != null ? mResponse.responseData as Object : ""));
    } catch (e) {
      log(e.toString());
      return Left(Failure(STATUS: false, MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING, DATA: ""));
    }
  }

  Future<Either<Failure, Success>> getBookings(HashMap<String, Object> requestParams, String mEstimationStatus) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION, STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          strUrl: 'estimates?status=$mEstimationStatus', requestParams: requestParams, mReqType: ReqType.get, mParamType: ParamType.simple);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        List<EstimatesModel> alEstimates = [];
        List data = mResponse?.responseData as List;
        for (var dataItem in data) {
          EstimatesModel mEstimatesModel = EstimatesModel.fromJson(dataItem);
          // if (mEstimatesModel.status == 'pending') {
          alEstimates.add(mEstimatesModel);
          // }
        }

        Success mSuccess = Success(responseStatus: mResponse!.responseStatus, responseData: alEstimates, responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      if (!Global.checkNull(mResponse!.responseMessage)) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(
          Failure(MESSAGE: mResponse.responseMessage, STATUS: false, DATA: mResponse.responseData != null ? mResponse.responseData as Object : ""));
    } catch (e) {
      log(e.toString());
      return Left(Failure(STATUS: false, MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING, DATA: ""));
    }
  }

  Future<Either<Failure, Success>> cancleBookings(HashMap<String, Object> requestParams, String estimateId) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION, STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          strUrl: 'estimates/cancel/$estimateId', requestParams: requestParams, mReqType: ReqType.patch, mParamType: ParamType.json);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        Success mSuccess = Success(responseStatus: mResponse!.responseStatus, responseData: "", responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      if (!Global.checkNull(mResponse!.responseMessage)) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(Failure(MESSAGE: mResponse.responseMessage, STATUS: false, DATA: ""));
    } catch (e) {
      log(e.toString());
      return Left(Failure(STATUS: false, MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING, DATA: ""));
    }
  }

  Future<Either<Failure, Success>> rescedulePromotions(HashMap<String, Object> requestParams, String promtionID) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION, STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          strUrl: 'promotions/reschedule/$promtionID', requestParams: requestParams, mReqType: ReqType.patch, mParamType: ParamType.json);

      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        Success mSuccess = Success(responseStatus: mResponse!.responseStatus, responseData: "", responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      if (!Global.checkNull(mResponse!.responseMessage)) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(Failure(MESSAGE: mResponse.responseMessage, STATUS: false, DATA: ""));
    } catch (e) {
      log(e.toString());
      return Left(Failure(STATUS: false, MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING, DATA: ""));
    }
  }

  Future<Either<Failure, Success>> getEstimatesDetail(HashMap<String, Object> requestParams, String estimateId) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION, STATUS: false));
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
        return Left(Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        List<EstimationDetailModel> alEstimates = [];
        List data = mResponse?.responseData as List;
        for (var dataItem in data) {
          EstimationDetailModel mEstimationDetailModel = EstimationDetailModel.fromJson(dataItem);
          alEstimates.add(mEstimationDetailModel);
        }

        Success mSuccess = Success(responseStatus: mResponse!.responseStatus, responseData: alEstimates, responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      if (!Global.checkNull(mResponse!.responseMessage)) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(
          Failure(MESSAGE: mResponse.responseMessage, STATUS: false, DATA: mResponse.responseData != null ? mResponse.responseData as Object : ""));
    } catch (e) {
      log(e.toString());
      return Left(Failure(STATUS: false, MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING, DATA: ""));
    }
  }

  //------------------OpenDispute API Call-------------------------------
  Future<Either<Failure, Success>> openDispute(HashMap<String, Object> requestParams) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION, STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          strUrl: RequestBuilder.API_OPEN_DISPUTE, requestParams: requestParams, mReqType: ReqType.post, mParamType: ParamType.json);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        Success mSuccess =
            Success(responseStatus: mResponse!.responseStatus, responseData: "mUserAddressDetail", responseMessage: mResponse.responseMessage);
        return Right(mSuccess);
      }
      return Left(
          Failure(MESSAGE: mResponse!.responseMessage, STATUS: false, DATA: mResponse.responseData != null ? mResponse.responseData as Object : ""));
    } catch (e) {
      return Left(Failure(STATUS: false, MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING, DATA: ""));
    }
  }
}
