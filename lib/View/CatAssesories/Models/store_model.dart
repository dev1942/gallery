// To parse this JSON data, do
//
//     final storeModel = storeModelFromMap(jsonString);
import 'dart:convert';

class AccessoriesStoreModel {
  AccessoriesStoreModel({
    required this.deliver,
    required this.images,
    required this.id,
    required this.name,
    required this.country,
    required this.state,
    required this.city,
    required this.address,
    required this.description,
    required this.provider,
    required this.type,
  });

  bool deliver;
  List<String> images;
  String id;
  String name;
  String country;
  String state;
  String city;
  String address;
  String description;
  String provider;
  String type;

  factory AccessoriesStoreModel.fromJson(String str) =>
      AccessoriesStoreModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AccessoriesStoreModel.fromMap(Map<String, dynamic> json) =>
      AccessoriesStoreModel(
        deliver: json["deliver"],
        images: List<String>.from(json["images"].map((x) => x)),
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        country: json["country"] ?? '',
        state: json["state"] ?? '',
        city: json["city"] ?? '',
        address: json["address"] ?? '',
        description: json["description"] ?? '',
        provider: json["provider"] ?? '',
        type: json["type"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "deliver": deliver,
        "images": List<dynamic>.from(images.map((x) => x)),
        "_id": id,
        "name": name,
        "country": country,
        "state": state,
        "city": city,
        "address": address,
        "description": description,
        "provider": provider,
        "type": type,
      };
}

class DeliveryDetails {
  DeliveryDetails({
    required this.charge,
    required this.range,
    required this.days,
  });

  int charge;
  int range;
  int days;

  factory DeliveryDetails.fromJson(String str) =>
      DeliveryDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeliveryDetails.fromMap(Map<String, dynamic> json) => DeliveryDetails(
        charge: json["charge"],
        range: json["range"],
        days: json["days"],
      );

  Map<String, dynamic> toMap() => {
        "charge": charge,
        "range": range,
        "days": days,
      };
}
