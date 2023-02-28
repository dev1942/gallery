// ignore_for_file: unnecessary_null_comparison

import 'dart:collection';
import 'dart:developer';
import '../../global/Models/failure.dart';
import '../../global/Models/result.dart';
import '../../global/Models/success.dart';
import 'package:dartz/dartz.dart';
import 'package:otobucks/global/connectivity_status.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/global/url_collection.dart';
import 'package:otobucks/View/InviteFriends/Models/invite_joiners_model.dart';
import 'package:otobucks/View/Auth/Models/user_detail.dart';
import 'package:otobucks/services/rest_api/request_listener.dart';
import '../../View/Auth/Models/user_model.dart';
import '../rest_api/request_listener_multipart.dart';

class UserRepo {
  Future<Either<Failure, Success>> getUser(HashMap<String, Object> requestParams) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION, STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          strUrl: RequestBuilder.API_CURRENT_USER, requestParams: requestParams, mReqType: ReqType.get, mParamType: ParamType.simple);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        Map<String, dynamic>? data = mResponse?.responseData as Map<String, dynamic>;
        if (data != null) {
          UserModel mUserModel = UserModel.fromJson(data);

          UserDetail mUserAddressDetail = UserDetail(
              avatar: mUserModel.image,
              firstName: mUserModel.firstName,
              lastName: mUserModel.lastName,
              email: mUserModel.email,
              id: mUserModel.id,
              isEmailVerified: mUserModel.isEmailVerified,
              isPhoneVerified: mUserModel.isPhoneVerified,
              mobile: mUserModel.countryCode + mUserModel.phone,
              accessToken: "");
          await Global.storeUserDetails(mUserAddressDetail);

          Success mSuccess = Success(responseStatus: mResponse!.responseStatus, responseData: mUserModel, responseMessage: mResponse.responseMessage);

          return Right(mSuccess);
        } else {
          if (mResponse!.responseMessage == null) {
            mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
          }
          return Left(Failure(MESSAGE: mResponse.responseMessage, STATUS: false, DATA: ""));
        }
      }

      if (mResponse!.responseMessage == null) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(
          Failure(MESSAGE: mResponse.responseMessage, STATUS: false, DATA: mResponse.responseData != null ? mResponse.responseData as Object : ""));
    } catch (e) {
      log(e.toString());
      return Left(Failure(STATUS: false, MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING, DATA: ""));
    }
  }

  Future<Either<Failure, Success>> updateUser(
      HashMap<String, String> requestParams, HashMap<String, String> requestParamsImages, ReqType mReqType) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION, STATUS: false));
    }

    try {
      log(RequestBuilder.API_UPDATE_USER);
      String response = await ReqListenerMultiPart.fetchPost(
          strUrl: RequestBuilder.API_UPDATE_USER, requestParams: requestParams, requestParamsImages: requestParamsImages, mReqType: mReqType);
      Result? mResponse;

      if (Global.equalsIgnoreCase(response, "413")) {
        return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_FILE_SIZE_ALL, STATUS: false));
      }

      if (response != null && response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        Success mSuccess = Success(responseStatus: mResponse!.responseStatus, responseData: "alServices", responseMessage: mResponse.responseMessage);
        return Right(mSuccess);
      }

      if (mResponse!.responseMessage == null) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(
          Failure(MESSAGE: mResponse.responseMessage, STATUS: false, DATA: mResponse.responseData != null ? mResponse.responseData as Object : ""));
    } catch (e) {
      log(e.toString());
      return Left(Failure(STATUS: false, MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING, DATA: ""));
    }
  }

  Future<Either<Failure, Success>> getInviteCode(HashMap<String, Object> requestParams) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION, STATUS: false));
    }
    try {
      String response =
          await ReqListener.fetchPost(strUrl: 'invites', requestParams: requestParams, mReqType: ReqType.post, mParamType: ParamType.json);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        String code = '';
        Map map = mResponse?.responseData as Map;
        if (map.containsKey('code')) {
          code = map['code'];
        }
        Success mSuccess = Success(responseStatus: mResponse!.responseStatus, responseData: code, responseMessage: mResponse.responseMessage);
        return Right(mSuccess);
      }

      if (mResponse!.responseMessage == null) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(
          Failure(MESSAGE: mResponse.responseMessage, STATUS: false, DATA: mResponse.responseData != null ? mResponse.responseData as Object : ""));
    } catch (e) {
      log(e.toString());
      return Left(Failure(STATUS: false, MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING, DATA: ""));
    }
  }

  Future<Either<Failure, Success>> getMyInvites(HashMap<String, Object> requestParams) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION, STATUS: false));
    }
    try {
      String response =
          await ReqListener.fetchPost(strUrl: 'invites/mine', requestParams: requestParams, mReqType: ReqType.get, mParamType: ParamType.simple);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        List<InviteJoinersModel> inviteJoiners = [];

        List data = mResponse?.responseData as List;

        for (var joiner in data) {
          inviteJoiners.add(InviteJoinersModel.fromMap(joiner));
        }

        Success mSuccess =
            Success(responseStatus: mResponse!.responseStatus, responseData: inviteJoiners, responseMessage: mResponse.responseMessage);
        return Right(mSuccess);
      }

      if (mResponse!.responseMessage == null) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(
          Failure(MESSAGE: mResponse.responseMessage, STATUS: false, DATA: mResponse.responseData != null ? mResponse.responseData as Object : ""));
    } catch (e) {
      log(e.toString());
      return Left(Failure(STATUS: false, MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING, DATA: ""));
    }
  }
}
