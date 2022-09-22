// To parse this JSON data, do
//
//     final myRoomModel = myRoomModelFromMap(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/model/server_chat_model.dart';

class MyRoomModel {
  MyRoomModel({
    required this.users,
    required this.createdAt,
    required this.updatedAt,
    required this.unReadMessages,
    required this.myRoomModelId,
    required this.serverChatModel,
  });

  List<RoomUser> users;
  var createdAt;
  var updatedAt;
  var myRoomModelId;
  int unReadMessages;
  ServerChatModel? serverChatModel;

  factory MyRoomModel.fromJson(String str) =>
      MyRoomModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyRoomModel.fromMap(Map<String, dynamic> json) {
    List data = json['chat'] as List;
    return MyRoomModel(
      users: List<RoomUser>.from(json["users"].map((x) => RoomUser.fromMap(x))),
      createdAt: "",
      // json["createdAt"],
      updatedAt: "",
      // json["updatedAt"],
      serverChatModel:
          data.isNotEmpty ? ServerChatModel.fromMap(data[0]) : null,
      unReadMessages: json["unReadMessages"] ?? 0,
      myRoomModelId: json["id"],
    );
  }

  Map<String, dynamic> toMap() => {
        "users": List<dynamic>.from(users.map((x) => x.toMap())),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "unReadMessages": unReadMessages,
        "chat": serverChatModel,
        "id": myRoomModelId,
      };

  getDateInFormate() {
    if (Global.checkNull(updatedAt)) {
      DateTime parseDate =
          DateFormat(Constants.STRING_DB_DATE_FORMATE).parse(updatedAt);
      DateTime local = DateTime.utc(parseDate.year, parseDate.month,
          parseDate.day, parseDate.hour, parseDate.minute);

      return local.toLocal();
    } else {
      return DateTime.now();
    }
  }
}

class RoomUser {
  RoomUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.userId,
  });

  var id;
  var firstName;
  var lastName;
  var image;
  var userId;

  factory RoomUser.fromJson(String str) => RoomUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RoomUser.fromMap(Map<String, dynamic> json) => RoomUser(
        id: json["_id"] ?? '',
        firstName: json["firstName"] ?? '',
        lastName: json["lastName"] ?? '',
        image: json["image"] ??
            'https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png',
        userId: json["id"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "image": image,
        "id": userId,
      };
}
