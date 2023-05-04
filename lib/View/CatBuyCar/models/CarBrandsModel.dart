// To parse this JSON data, do
//
//     final carBrandsModel = carBrandsModelFromMap(jsonString);

import 'dart:convert';

CarBrandsModel carBrandsModelFromMap(String str) => CarBrandsModel.fromMap(json.decode(str));

// String carBrandsModelToMap(CarBrandsModel data) => json.encode(data.toMap());

class CarBrandsModel {
  CarBrandsModel({
    required this.status,
    required this.message,
    required this.countOnPage,
    required this.totalCount,
    required this.data,
  });

  String status;
  String message;
  int countOnPage;
  int totalCount;
  List<CarBrandDetails> data;

  factory CarBrandsModel.fromMap(Map<String, dynamic> json) => CarBrandsModel(
        status: json["status"],
        message: json["message"],
        countOnPage: json["countOnPage"],
        totalCount: json["totalCount"],
        data: List<CarBrandDetails>.from(json["result"].map((x) => CarBrandDetails.fromMap(x))),
      );

  // Map<String, dynamic> toMap() => {
  //     "status": status,
  //     "message": message,
  //     "countOnPage": countOnPage,
  //     "totalCount": totalCount,
  //     "data": List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x.toMap())))),
  // };
}

class CarBrandDetails {
  CarBrandDetails({
    required this.ssn,
    required this.country,
    required this.id,
    required this.countries,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  String ssn;
  List<dynamic> country;
  String id;
  List<String> countries;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  factory CarBrandDetails.fromMap(Map<String, dynamic> json) => CarBrandDetails(
        ssn: json["ssn"],
        country: List<dynamic>.from(json["country"].map((x) => x)),
        id: json["_id"],
        countries: List<String>.from(json["countries"].map((x) => x)),
        name: json["name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "ssn": ssn,
        "country": List<dynamic>.from(country.map((x) => x)),
        "_id": id,
        "countries": List<dynamic>.from(countries.map((x) => x)),
        "name": name,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
