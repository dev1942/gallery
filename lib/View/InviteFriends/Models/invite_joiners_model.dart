// To parse this JSON data, do
//
//     final inviteJoinersModel = inviteJoinersModelFromMap(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/global.dart';

class InviteJoinersModel {
  InviteJoinersModel({
    required this.id,
    required this.userType,
    required this.createdAt,
    required this.updatedAt,
    required this.code,
    required this.joiner,
  });

  String id;
  String userType;
  String createdAt;
  String updatedAt;
  String code;
  List<Joiner> joiner;

  factory InviteJoinersModel.fromJson(String str) =>
      InviteJoinersModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InviteJoinersModel.fromMap(Map<String, dynamic> json) =>
      InviteJoinersModel(
        id: json["_id"],
        userType: json["userType"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        code: json["code"],
        joiner: List<Joiner>.from(json["joiner"].map((x) => Joiner.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "userType": userType,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "code": code,
        "joiner": List<dynamic>.from(joiner.map((x) => x.toMap())),
      };
}

class Joiner {
  Joiner({
    required this.id,
    required this.firstName,
    required this.image,
    required this.lastName,
    required this.createdAt,
  });

  String id;
  String image;
  String createdAt;
  String firstName;
  String lastName;

  factory Joiner.fromJson(String str) => Joiner.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Joiner.fromMap(Map<String, dynamic> json) => Joiner(
        id: json["_id"],
        createdAt: json["createdAt"],
        firstName: json["firstName"],
        image: json["image"],
        lastName: json["lastName"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "createdAt": createdAt,
        "firstName": firstName,
        "image": image,
        "lastName": lastName,
      };

  getDate() {
    if (Global.checkNull(createdAt)) {
      DateTime parseDate =
          DateFormat(Constants.STRING_DB_DATE_FORMATE).parse(createdAt);
      DateTime local = DateTime.utc(parseDate.year, parseDate.month,
          parseDate.day, parseDate.hour, parseDate.minute);
      var inputDate = DateTime.parse(local.toLocal().toString());
      var outputFormat = DateFormat(Constants.STRING_DD_MMM_YYYY);
      var outputDate = outputFormat.format(inputDate);
      return outputDate.toString();
    } else {
      return "";
    }
  }
}
