// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/model/estimation_detail_model.dart';
import 'package:otobucks/model/service/service_provider_model.dart';
import 'package:otobucks/model/time_model.dart';

import '../global/global.dart';

class EstimatesModel {
  String id;
  String status;
  String time;
  Source? source;
  String date;
  String cutomerNote;
  bool offerCreated;
  String? offerStatus;
  List<String> image;
  List<String> voiceNote;
  List<String> video;
  List<String> address;
  List<Items> itemModel;
  ServiceProviderModel? mServiceProviderModel;
  String discount;
  String grandTotal;
  String serviceTax;
  String subTotal;

  EstimatesModel({
    required this.id,
    required this.status,
    required this.time,
    required this.source,
    required this.date,
    this.offerCreated=false,
    this.offerStatus,
    required this.cutomerNote,
    required this.image,
    required this.voiceNote,
    required this.video,
    required this.address,
    required this.mServiceProviderModel,
    required this.itemModel,
    required this.discount,
    required this.grandTotal,
    required this.serviceTax,
    required this.subTotal,
  });

  factory EstimatesModel.fromJson(Map<String, dynamic> json) {
    List<String> image = [];
    List<String> voiceNote = [];
    List<String> video = [];
    List<String> address = [];
    List<Items> alItems = [];
    ServiceProviderModel? mProvider;

    Source? mSource;

    String date = json['updatedAt'].toString();
    // try {
    //   if (date.contains("TO")) {
    //     var mDate = date.split("T0");
    //     date = mDate[0].toString();
    //   }
    // } catch (exp) {}

    try {
      var mImage = json['image'];
      for (var imageItem in mImage) {
        image.add(imageItem.toString());
      }
    } catch (exp) {}

    try {
      var mVoiceNote = json['voice_note'];
      for (var imageItem in mVoiceNote) {
        voiceNote.add(imageItem.toString());
      }
    } catch (exp) {}

    try {
      var mVideo = json['video'];
      for (var videoItem in mVideo) {
        video.add(videoItem.toString());
      }
    } catch (exp) {}
    try {
      var mAddress = json['address'];
      for (var addressItem in mAddress) {
        address.add(addressItem.toString());
      }
    } catch (exp) {}
    try {
      mProvider = ServiceProviderModel.fromJson(json['provider']);
    } catch (exp) {}
    try {
      var items_ = json['items'];
      for (var itemsList in items_) {
        Items mItems = Items.fromJson(itemsList);
        alItems.add(mItems);
      }
    } catch (exp) {}
    try {
      mSource = Source.fromJson(json['source']);
    } catch (exp) {}

    return EstimatesModel(
      id: json['_id'].toString(),
      status: json['status'].toString(),
      time: json['time'].toString(),
      source: mSource,
      cutomerNote: json['cutomerNote'].toString(),
      image: image,
      voiceNote: voiceNote,
      video: video,
      address: address,
      date: date,
      mServiceProviderModel: mProvider,
      itemModel: alItems,
      discount: json['discount'].toString(),
      grandTotal: json['grandTotal'].toString(),
      serviceTax: json['serviceTax'].toString(),
      subTotal: json['subTotal'].toString(),
    );
  }

  getEstimateImage() {
    if (image.isNotEmpty) {
      return image.first;
    } else {
      return "";
    }
  }

  getEstimateVoiceNote() {
    if (voiceNote.isNotEmpty) {
      return voiceNote.first;
    } else {
      return "";
    }
  }

  getEstimateVideo() {
    if (video.isNotEmpty) {
      return video.first;
    } else {
      return "";
    }
  }

  getProviderImage() {
    if (mServiceProviderModel != null) {
      return mServiceProviderModel!.image;
    } else {
      return "https://spng.pngfind.com/pngs/s/292-2924933_image-result-for-png-file-user-icon-black.png";
    }
  }

  getService() {
    if (source != null) {
      return source!.title.toString();
    } else {
      return "";
    }
  }

  getProviderName() {
    if (mServiceProviderModel != null) {
      return mServiceProviderModel!.firstName +
          " " +
          mServiceProviderModel!.lastName;
    } else {
      return "";
    }
  }

  getDate() {
    if (Global.checkNull(date)) {
      DateTime parseDate =
          DateFormat(Constants.STRING_DB_DATE_FORMATE).parse(date);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat(Constants.STRING_DD_MMM_YYYY);
      var outputDate = outputFormat.format(inputDate);
      return outputDate.toString();
    } else {
      return "";
    }
  }

  getDateInFormate() {
    if (Global.checkNull(date)) {
      DateTime parseDate =
          DateFormat(Constants.STRING_DB_DATE_FORMATE).parse(date);
      DateTime local = DateTime.utc(parseDate.year, parseDate.month,
          parseDate.day, parseDate.hour, parseDate.minute);

      return local.toLocal();
    } else {
      return DateTime.now();
    }
  }

  TimeModel getTimeModel() {
    DateTime parseDate = DateFormat("hh:00").parse(time.split(":")[0] + ":00");

    String time12HR = DateFormat('hh:00 aa').format(parseDate);
    String time24HR = DateFormat('HH:00').format(parseDate);

    TimeModel mTimeModel = TimeModel(
        isSelected: true,
        isEnable: true,
        t24hr: parseDate.hour,
        time_24hr: time24HR,
        time_12hr: time12HR);
    return mTimeModel;
  }
}

class Source {
  String id;
  String category;
  String subcategory;
  String title;
  String description;
  String price;
  String provider;
  String currency;

  List<String> stores;
  List<String> image;
  List<String> video;
  List<String> features;

  Source(
      {required this.id,
      required this.category,
      required this.subcategory,
      required this.title,
      required this.description,
      required this.price,
      required this.provider,
      required this.currency,
      required this.stores,
      required this.image,
      required this.video,
      required this.features});

  factory Source.fromJson(Map<String, dynamic> json) {
    List<String> image = [];
    List<String> video = [];
    List<String> stores = [];
    List<String> features = [];

    try {
      var mImage = json['image'];
      for (var imageItem in mImage) {
        image.add(imageItem.toString());
      }
    } catch (exp) {}

    try {
      var mVideo = json['video'];
      for (var videoItem in mVideo) {
        video.add(videoItem.toString());
      }
    } catch (exp) {}
    try {
      var mAddress = json['stores'];
      for (var addressItem in mAddress) {
        stores.add(addressItem.toString());
      }
    } catch (exp) {}
    try {
      var mAddress = json['features'];
      for (var addressItem in mAddress) {
        features.add(addressItem.toString());
      }
    } catch (exp) {}

    return Source(
        id: json['_id'].toString(),
        category: json['category'].toString(),
        subcategory: json['subcategory'].toString(),
        title: json['title'].toString(),
        description: json['description'].toString(),
        price: json['price'].toString(),
        provider: json['provider'].toString(),
        currency: json['currency'].toString(),
        image: image,
        video: video,
        stores: stores,
        features: features);
  }
}

// To parse this JSON data, do
//
//     final itemModel = itemModelFromMap(jsonString);

class ItemModel {
  ItemModel({
    required this.title,
    required this.description,
    required this.quantity,
    required this.price,
    required this.tax,
    required this.amount,
  });

  String title;
  String description;
  String quantity;
  String price;
  String tax;
  double amount;

  factory ItemModel.fromJson(String str) => ItemModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemModel.fromMap(Map<String, dynamic> json) => ItemModel(
        title: json["title"],
        description: json["description"],
        quantity: json["quantity"],
        price: json["price"],
        tax: json["tax"],
        amount: json["amount"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
        "quantity": quantity,
        "price": price,
        "tax": tax,
        "amount": amount,
      };
}
