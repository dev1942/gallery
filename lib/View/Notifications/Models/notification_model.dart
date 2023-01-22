import 'dart:developer';

import 'package:intl/intl.dart';

import '../../../global/constants.dart';
import '../../../global/global.dart';

class NotificationModel {
  String id;
  String title;
  String type;
  String description;
  String? productId;
  String? promotionId;
  String? estimateId;

  String image;
  String from;
  String createdAt;
  NotificationModel(
      {required this.id,
      required this.title,
      required this.type,
      required this.productId,
      required this.promotionId,
      required this.estimateId,
      required this.from,
      required this.description,
      required this.image,
      required this.createdAt});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    String strImage = "";
    String strProviderName = "";
    String from = "";

    try {
      from = json["from"]['firstName'] + ' ' + json["from"]['lastName'];
      strImage = json["from"]['image'];
    } catch (e) {
      log(e.toString());
    }
    try {
      var from = json["from"];
      String fName = from["firstName"].toString();
      String lName = from["lastName"].toString();

      strProviderName = fName + " " + lName;
    } catch (e) {
      log(e.toString());
    }

    return NotificationModel(
      id: json['_id'].toString(),
      type: json['type'].toString(),
      estimateId: json['estimateId'] == null ? null : json['estimateId']['_id'].toString(),
      promotionId: json['promotionId'].toString(),
      productId: json['productId'].toString(),
      title: json['title'].toString(),
      description: "",
      from: from,
      image: strImage,
      createdAt: json['createdAt'].toString(),
    );
  }

  getDate() {
    if (Global.checkNull(createdAt)) {
      DateTime parseDate = DateFormat(Constants.STRING_DB_DATE_FORMATE).parse(createdAt);
      DateTime local = DateTime.utc(parseDate.year, parseDate.month, parseDate.day, parseDate.hour, parseDate.minute);
      var inputDate = DateTime.parse(local.toLocal().toString());
      var outputFormat = DateFormat(Constants.STRING_DD_MMM_YYYY);
      var outputDate = outputFormat.format(inputDate);
      return outputDate.toString();
    } else {
      return "";
    }
  }

  getDateInFormate() {
    if (Global.checkNull(createdAt)) {
      DateTime parseDate = DateFormat(Constants.STRING_DB_DATE_FORMATE).parse(createdAt);
      DateTime local = DateTime.utc(parseDate.year, parseDate.month, parseDate.day, parseDate.hour, parseDate.minute);

      return local.toLocal();
    } else {
      return DateTime.now();
    }
  }
}
