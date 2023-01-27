import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:otobucks/global/connectivity_status.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/View/Chat/Models/my_rooms_model.dart';
import 'package:otobucks/View/Chat/Models/server_chat_model.dart';
import 'package:otobucks/services/rest_api/request_listener.dart';
import 'package:otobucks/services/rest_api/request_listener_multipart.dart';
import '../../global/Models/failure.dart';
import '../../global/Models/result.dart';
import '../../global/Models/success.dart';

class ChatRepo {
  Future<Either<Failure, Success>> getMyRooms(HashMap<String, Object> requestParams) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION, STATUS: false));
    }
    try {
      String response =
          await ReqListener.fetchPost(strUrl: "chat/myRooms", requestParams: requestParams, mReqType: ReqType.get, mParamType: ParamType.simple);
      Result? mResponse;

      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
        debugPrint("mapData: ${mResponse?.responseData}");
      } else {
        return Left(Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        List<MyRoomModel> rooms = [];
        List data = mResponse?.responseData as List;
        // ignore: unnecessary_null_comparison
        if (data != null) {
          for (var dataItem in data) {
            MyRoomModel room = MyRoomModel.fromMap(dataItem);
            rooms.add(room);
          }

          Success mSuccess = Success(responseStatus: mResponse!.responseStatus, responseData: rooms, responseMessage: mResponse.responseMessage);

          return Right(mSuccess);
        } else {
          if (!Global.checkNull(mResponse!.responseMessage)) {
            mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
          }
          return Left(Failure(MESSAGE: mResponse.responseMessage, STATUS: false, DATA: ""));
        }
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

  Future<Either<Failure, Success>> createRoom(HashMap<String, Object> requestParams, String userId) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION, STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          strUrl: "chat/getRoomId/" + userId, requestParams: requestParams, mReqType: ReqType.get, mParamType: ParamType.simple);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        Map data = mResponse?.responseData as Map;

        Success mSuccess = Success(responseStatus: mResponse!.responseStatus, responseData: data['id'], responseMessage: mResponse.responseMessage);

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

  Future<Either<Failure, Success>> getMyMessages(HashMap<String, Object> requestParams, String roomId) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION, STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          strUrl: "chat/roomMessages/$roomId", requestParams: requestParams, mReqType: ReqType.get, mParamType: ParamType.simple);

      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }
      if (mResponse?.responseStatus == true) {
        List<ServerChatModel> chats = [];
        Map mapData = mResponse?.responseData as Map;
        List data = mapData['chat'] as List;
        // ignore: unnecessary_null_comparison
        if (data != null) {
          for (var dataItem in data) {
            ServerChatModel room = ServerChatModel.fromMap(dataItem);
            chats.add(room);
          }

          Success mSuccess = Success(responseStatus: mResponse!.responseStatus, responseData: chats, responseMessage: mResponse.responseMessage);

          return Right(mSuccess);
        } else {
          if (!Global.checkNull(mResponse!.responseMessage)) {
            mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
          }
          return Left(Failure(MESSAGE: mResponse.responseMessage, STATUS: false, DATA: ""));
        }
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

  Future<Either<Failure, Success>> getMyRoom(HashMap<String, Object> requestParams, String roomId) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION, STATUS: false));
    }
    try {
      debugPrint("-----------------start----$requestParams-------------------");
      String? response = await ReqListener.fetchPost(
          strUrl: "chat/roomMessages/$roomId", requestParams: requestParams, mReqType: ReqType.get, mParamType: ParamType.simple);
      debugPrint("------------------end----------------------");

      Result? mResponse;

      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }
      debugPrint("CheckDataSTep $response");

      Map<String, dynamic> mapData = mResponse?.responseData as Map<String, dynamic>;
      debugPrint("mapData: $mapData");

      if (mResponse?.responseStatus == true) {
        Map<String, dynamic> mapData = mResponse?.responseData as Map<String, dynamic>;
        var decode = (json.decode((response))['result']);
        MyRoomModel myRoomModel = MyRoomModel.fromMap(decode);

        // ignore: unnecessary_null_comparison
        if (mapData != null) {
          Success mSuccess =
              Success(responseStatus: mResponse!.responseStatus, responseData: myRoomModel, responseMessage: mResponse.responseMessage);

          return Right(mSuccess);
        } else {
          if (!Global.checkNull(mResponse!.responseMessage)) {
            mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
          }
          return Left(Failure(MESSAGE: mResponse.responseMessage, STATUS: false, DATA: ""));
        }
      }

      if (!Global.checkNull(mResponse!.responseMessage)) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(
          Failure(MESSAGE: mResponse.responseMessage, STATUS: false, DATA: mResponse.responseData != null ? mResponse.responseData as Object : ""));
    } catch (e) {
      log("chat/roomMessages/$roomId Error: ${e.toString()}");
      return Left(Failure(STATUS: false, MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING, DATA: ""));
    }
  }

  Future<Either<Failure, Success>> readRoomMessages(HashMap<String, Object> requestParams, String roomId) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION, STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          strUrl: "chat/readMessage/$roomId", requestParams: requestParams, mReqType: ReqType.patch, mParamType: ParamType.simple);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        // ignore: unnecessary_null_comparison
        Success mSuccess = Success(responseStatus: mResponse!.responseStatus, responseData: '', responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      return Left(
          Failure(MESSAGE: mResponse!.responseMessage, STATUS: false, DATA: mResponse.responseData != null ? mResponse.responseData as Object : ""));
    } catch (e) {
      log(e.toString());
      return Left(Failure(STATUS: false, MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING, DATA: ""));
    }
  }

  Future<Either<Failure, Success>> uploadFile(HashMap<String, String> requestParams, HashMap<String, String> requestParamsImage) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION, STATUS: false));
    }
    try {
      String response = await ReqListenerMultiPart.fetchPost(
          strUrl: 'chat/sendFile', requestParams: requestParams, requestParamsImages: requestParamsImage, mReqType: ReqType.post);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        List<String> urls = [];
        Map data = mResponse?.responseData as Map;
        List images = data['imageUrl'] as List;

        for (var element in images) {
          urls.add(element);
        }
        // ignore: unnecessary_null_comparison
        Success mSuccess = Success(responseStatus: mResponse!.responseStatus, responseData: urls, responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      return Left(
          Failure(MESSAGE: mResponse!.responseMessage, STATUS: false, DATA: mResponse.responseData != null ? mResponse.responseData as Object : ""));
    } catch (e) {
      log(e.toString());
      return Left(Failure(STATUS: false, MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING, DATA: ""));
    }
  }
}
