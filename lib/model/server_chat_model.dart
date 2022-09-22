// To parse this JSON data, do
//
//     final serverChatModel = serverChatModelFromMap(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/global.dart';

class ServerChatModel {
  ServerChatModel({
    required this.files,
    required this.status,
    required this.id,
    required this.chatRoom,
    required this.from,
    required this.to,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.serverChatModelId,
  });

  var files;
  var status;
  var id;
  var chatRoom;
  var from;
  var to;
  var message;
  var createdAt;
  var updatedAt;

  var serverChatModelId;

  factory ServerChatModel.fromJson(String str) =>
      ServerChatModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServerChatModel.fromMap(Map<String, dynamic> json) => ServerChatModel(
        files: json["files"] == null
            ? []
            : List<String>.from(json["files"].map((x) => x)),
        status: json["status"],
        id: json["_id"],
        chatRoom: json["chatRoom"],
        from: From.fromMap(json["from"]),
        to: From.fromMap(json["to"]),
        message: json["message"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        serverChatModelId: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "files": List<dynamic>.from(files.map((x) => x)),
        "status": status,
        "_id": id,
        "chatRoom": chatRoom,
        "from": from.toMap(),
        "to": to.toMap(),
        "message": message,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "id": serverChatModelId,
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

class From {
  From({
    required this.role,
    required this.id,
    required this.firstName,
    required this.email,
    required this.lastName,
    required this.image,
    required this.fromId,
  });

  String role;
  String id;
  String firstName;
  String email;
  String lastName;
  String image;
  String fromId;

  factory From.fromJson(String str) => From.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory From.fromMap(Map<String, dynamic> json) => From(
        role: json["role"],
        id: json["_id"],
        firstName: json["firstName"] ?? '',
        email: json["email"] ?? '',
        lastName: json["lastName"] ?? '',
        image: json["image"] ?? '',
        fromId: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "role": role,
        "_id": id,
        "firstName": firstName,
        "email": email,
        "lastName": lastName,
        "image": image,
        "id": fromId,
      };
}
