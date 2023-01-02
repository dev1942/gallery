import 'package:flutter/cupertino.dart';

import '../../../global/enum.dart';

class LocalChatModel {
  String id;
  String name;
  String image;
  String message;
  String time;
  List<String> images;
  MsgType mMsgType;
  bool isRead;

  LocalChatModel(
      {Key? key,
      required this.id,
      required this.name,
      required this.image,
      required this.time,
      required this.message,
      required this.images,
      required this.mMsgType,
      required this.isRead});

  // factory BannerModel.fromJson(Map<String, dynamic> json) {
  //   return BannerModel(
  //       id: json['id'].toString(),
  //       name: json['name'].toString(),
  //       image: json['image'].toString(),
  //       type: json['type'].toString(),
  //       type_id: json['type_id'].toString());
  // }
}
