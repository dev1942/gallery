import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:otobucks/View/Services_All/Models/service_provider_model.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/global.dart';

class PromotionsModel {
  String id;
  List<String> promoImg;
  String active;
  String deleted;
  String paymentStatus;
  Source source;
  String title;
  String location;
  String description;
  String previousPrice;
  String discount;
  String priceAfterDiscount;
  String startDate;
  String endDate;
  String country;
  String sourceType;
  ServiceProviderModel? provider;

  PromotionsModel(
      {required this.id,
      required this.promoImg,
      required this.active,
      required this.deleted,
      required this.paymentStatus,
      required this.source,
      required this.title,
      required this.location,
      required this.description,
      required this.previousPrice,
      required this.discount,
      required this.priceAfterDiscount,
      required this.startDate,
      required this.endDate,
      required this.country,
      required this.sourceType,
      required this.provider});

  factory PromotionsModel.fromJson(Map<String, dynamic> json) {
    List<String> promoImg = [];
    Source mSource = Source(id: "", title: "");
    ServiceProviderModel? mServiceProviderModel;

    try {
      var _promoImg = json['promoImg'];
      for (var itemImage in _promoImg) {
        promoImg.add(itemImage.toString());
      }
    } catch (e) {
      log(e.toString());
    }

    try {
      // from user
      var customer = json['source'];
      mSource = Source.fromJson(customer);
    } catch (e) {
      log(e.toString());
    }

    try {
      var provider = json['provider'];
      mServiceProviderModel = ServiceProviderModel.fromJson(provider);
    } catch (e) {
      log(e.toString());
    }

    return PromotionsModel(
        id: json['_id'].toString(),
        promoImg: promoImg,
        active: json['active'].toString(),
        deleted: json['deleted'].toString(),
        paymentStatus: json['paymentStatus'].toString(),
        source: mSource,
        title: json['title'].toString(),
        location: json['location'].toString(),
        description: json['description'].toString(),
        previousPrice: json['previousPrice'].toString(),
        discount: json['discount'].toString(),
        priceAfterDiscount: json['priceAfterDiscount'].toString(),
        startDate: json['startDate'].toString(),
        endDate: json['endDate'].toString(),
        country: json['country'].toString(),
        sourceType: json['sourceType'].toString(),
        provider: mServiceProviderModel);
  }

  String getPromoImage() {
    if (promoImg.isNotEmpty) {
      return promoImg.first;
    }

    return "";
  }

  getEndDate() {
    if (Global.checkNull(endDate)) {
      DateTime parseDate = DateFormat(Constants.STRING_DB_DATE_FORMATE).parse(endDate);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat(Constants.STRING_DD_MMM_YYYY);
      var outputDate = outputFormat.format(inputDate);
      return outputDate.toString();
    } else {
      return "";
    }
  }

  getDaysLeft() {
    if (Global.checkNull(endDate)) {
      DateTime parseDate = DateFormat(Constants.STRING_DB_DATE_FORMATE).parse(endDate);
      var inputDate = DateTime.parse(parseDate.toString());
      final date2 = DateTime.now();

      return inputDate.difference(date2).inDays.toString();
    } else {
      return "";
    }
  }

  getStartDate() {
    if (Global.checkNull(startDate)) {
      DateTime parseDate = DateFormat(Constants.STRING_DB_DATE_FORMATE).parse(startDate);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat(Constants.STRING_DD_MMM_YYYY);
      var outputDate = outputFormat.format(inputDate);
      return outputDate.toString();
    } else {
      return "";
    }
  }
}

class Source {
  String id;
  String title;

  Source({required this.id, required this.title});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(id: json['_id'].toString(), title: json['title'].toString());
  }
}
