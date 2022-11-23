import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:otobucks/global/connectivity_status.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/global/url_collection.dart';
import 'package:otobucks/model/failure.dart';
import 'package:otobucks/model/result.dart';
import 'package:otobucks/model/success.dart';
import 'package:otobucks/model/user_detail.dart';
import 'package:otobucks/services/rest_api/request_listener.dart';

class LoginRepo {
  Future<Either<Failure, Success>> login(
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
          strUrl: RequestBuilder.API_LOGIN,
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

        Map data = jsonDecode(response);
        String token = data[Constants.RES_TOKEN].toString();

        Global.storeToken(token);

        var objData = data['data'];
        var user = objData['user'];

        String image = user['image'].toString();
        String id = user['id'].toString();
        String firstName = user['firstName'].toString();
        String lastName = user['lastName'].toString();
        String email = user['email'].toString();
        String phone = user['phone'].toString();
        String countryCode = user['countryCode'].toString();
        bool isEmailVerified=user['isEmailVerified'];
        bool isPhoneVerified=user['isPhoneVerified'];

        UserDetail mUserAddressDetail = UserDetail(
            avatar: image,
            firstName: firstName,
            lastName: lastName,
            email: email,
            id: id,
            mobile: countryCode + phone,
            isEmailVerified:isEmailVerified ,
            isPhoneVerified: isPhoneVerified,
            accessToken: token);
        await Global.storeUserDetails(mUserAddressDetail);

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

  Future<Either<Failure, Success>> forgotPassword(
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
          strUrl: RequestBuilder.API_FORGOT_PASSWORD,
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

  Future<Either<Failure, Success>> resetPassword(
    HashMap<String, Object> requestParams,
    String token,
  ) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(
          DATA: "",
          MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION,
          STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          strUrl: RequestBuilder.API_RESET_PASSWORD + token,
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

      return Left(Failure(
          MESSAGE: mResponse.responseMessage,
          STATUS: false,
          DATA: mResponse.responseData != null
              ? mResponse.responseData as Object
              : ""));
    } catch (e) {
      return Left(Failure(
          STATUS: false,
          MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING,
          DATA: ""));
    }
  }
}
