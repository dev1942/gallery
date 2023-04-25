// // To parse this JSON data, do
// //
// //     final carsListModel = carsListModelFromMap(jsonString);

// import 'dart:convert';

// CarsListModel carsListModelFromMap(String str) => CarsListModel.fromMap(json.decode(str));

// String carsListModelToMap(CarsListModel data) => json.encode(data.toMap());

// class CarsListModel {
//   CarsListModel({
//     this.status,
//     this.result,
//   });

//   String? status;
//   List<CarsForSell>? result;

//   factory CarsListModel.fromMap(Map<String, dynamic> json) => CarsListModel(
//         status: json["status"],
//         result: json["result"] == null ? [] : List<CarsForSell>.from(json["result"]!.map((x) => CarsForSell.fromMap(x))),
//       );

//   Map<String, dynamic> toMap() => {
//         "status": status,
//         "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toMap())),
//       };
// }

// class CarsForSell {
//   CarsForSell({
//     this.image,
//     this.id,
//     this.title,
//     this.description,
//     this.details,
//     this.resultId,
//   });

//   List<String>? image;
//   String? id;
//   String? title;
//   String? description;
//   Details? details;
//   String? resultId;

//   factory CarsForSell.fromMap(Map<String, dynamic> json) => CarsForSell(
//         image: json["image"] == null ? [] : List<String>.from(json["image"]!.map((x) => x)),
//         id: json["_id"],
//         title: json["title"],
//         description: json["description"],
//         details: json["details"] == null ? null : Details.fromMap(json["details"]),
//         resultId: json["id"],
//       );

//   Map<String, dynamic> toMap() => {
//         "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
//         "_id": id,
//         "title": title,
//         "description": description,
//         "details": details?.toMap(),
//         "id": resultId,
//       };
// }

// class Details {
//   Details({
//     this.newOrUsed,
//     this.model,
//     this.modelYear,
//     this.price,
//     this.bodyType,
//     this.transmissionType,
//     this.fuelRange,
//     this.color,
//     this.usage,
//     this.type,
//     this.sellerType,
//     this.badges,
//     this.mileage,
//     this.engine,
//     this.numberOfSeats,
//     this.airBags,
//     this.fuelType,
//   });

//   String? newOrUsed;
//   String? model;
//   String? modelYear;
//   String? price;
//   String? bodyType;
//   String? transmissionType;
//   String? fuelRange;
//   String? color;
//   String? usage;
//   String? type;
//   String? sellerType;
//   List<dynamic>? badges;
//   String? mileage;
//   String? engine;
//   String? numberOfSeats;
//   bool? airBags;
//   String? fuelType;

//   factory Details.fromMap(Map<String, dynamic> json) => Details(
//         newOrUsed: json["newOrUsed"],
//         model: json["model"],
//         modelYear: json["modelYear"],
//         price: json["price"],
//         bodyType: json["bodyType"],
//         transmissionType: json["transmissionType"],
//         fuelRange: json["fuelRange"],
//         color: json["color"],
//         usage: json["usage"],
//         type: json["type"],
//         sellerType: json["sellerType"],
//         badges: json["badges"] == null ? [] : List<dynamic>.from(json["badges"]!.map((x) => x)),
//         mileage: json["mileage"],
//         engine: json["engine"],
//         numberOfSeats: json["numberOfSeats"],
//         airBags: json["airBags"],
//         fuelType: json["fuelType"],
//       );

//   Map<String, dynamic> toMap() => {
//         "newOrUsed": newOrUsed,
//         "model": model,
//         "modelYear": modelYear,
//         "price": price,
//         "bodyType": bodyType,
//         "transmissionType": transmissionType,
//         "fuelRange": fuelRange,
//         "color": color,
//         "usage": usage,
//         "type": type,
//         "sellerType": sellerType,
//         "badges": badges == null ? [] : List<dynamic>.from(badges!.map((x) => x)),
//         "mileage": mileage,
//         "engine": engine,
//         "numberOfSeats": numberOfSeats,
//         "airBags": airBags,
//         "fuelType": fuelType,
//       };
// }

// To parse this JSON data, do
//
//     final carsListModel = carsListModelFromMap(jsonString);

import 'dart:convert';

CarsListModel carsListModelFromMap(String str) => CarsListModel.fromMap(json.decode(str));

String carsListModelToMap(CarsListModel data) => json.encode(data.toMap());

class CarsListModel {
  CarsListModel({
    this.status,
    this.result,
  });

  String? status;
  List<CarsForSell>? result;

  factory CarsListModel.fromMap(Map<String, dynamic> json) => CarsListModel(
        status: json["status"],
        result: json["result"] == null ? [] : List<CarsForSell>.from(json["result"]!.map((x) => CarsForSell.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toMap())),
      };
}

class CarsForSell {
  CarsForSell({
    this.image,
    this.id,
    this.title,
    this.description,
    this.details,
    this.resultId,
  });

  List<String>? image;
  String? id;
  String? title;
  String? description;
  Details? details;
  String? resultId;

  factory CarsForSell.fromMap(Map<String, dynamic> json) => CarsForSell(
        image: json["image"] == null || json["image"] == [] ? [] : List<String>.from(json["image"]!.map((x) => x)),
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        details: json["details"] == null ? null : Details.fromMap(json["details"]),
        resultId: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
        "_id": id,
        "title": title,
        "description": description,
        "details": details?.toMap(),
        "id": resultId,
      };
}

class Details {
  Details({
    this.newOrUsed,
    this.model,
    this.modelYear,
    this.price,
    this.bodyType,
    this.transmissionType,
    this.fuelRange,
    this.color,
    this.usage,
    this.type,
    this.sellerType,
    this.badges,
    this.mileage,
    this.topSpeed,
    this.engine,
    this.numberOfSeats,
    this.airBags,
    this.fuelType,
    this.numberOfseats,
  });

  String? newOrUsed;
  String? model;
  String? modelYear;
  String? price;
  String? bodyType;
  String? transmissionType;
  String? fuelRange;
  String? color;
  String? usage;
  String? type;
  String? sellerType;
  dynamic badges;
  String? mileage;
  String? topSpeed;
  String? engine;
  String? numberOfSeats;
  bool? airBags;
  String? fuelType;
  String? numberOfseats;

  factory Details.fromMap(Map<String, dynamic> json) => Details(
        newOrUsed: json["newOrUsed"] ?? "New",
        model: json.containsKey("model") ? json["model"] : "",
        modelYear: json.containsKey("modelYear") ? json["modelYear"] : "",
        price: json.containsKey("price") ? json["price"] : "",
        bodyType: json.containsKey("bodyType") ? json["bodyType"] : "",
        transmissionType: json.containsKey("transmissionType") ? json["transmissionType"] : "",
        fuelRange: json.containsKey("fuelRange") ? json["fuelRange"] : "",
        color: json.containsKey("color") ? json["color"] : "",
        usage: json.containsKey("usage") ? json["usage"] : "",
        type: json.containsKey("type") ? json["type"] : "",
        sellerType: json.containsKey("sellerType") ? json["sellerType"] : "",
        badges: json.containsKey("badges") ? json["badges"] : "",
        mileage: json.containsKey("mileage") ? json["mileage"] : "",
        topSpeed: json.containsKey("topSpeed") ? json["topSpeed"] : "",
        engine: json.containsKey("engine") ? json["engine"] : "",
        numberOfSeats: json.containsKey("numberOfSeats") ? json["numberOfSeats"] : "",
        airBags: json.containsKey("airBags") ? json["airBags"] : false,
        fuelType: json.containsKey("fuelType") ? json["fuelType"] : "",
        numberOfseats: json.containsKey("numberOfseats") ? json["numberOfseats"] : "",
      );

  Map<String, dynamic> toMap() => {
        "newOrUsed": newOrUsed,
        "model": model,
        "modelYear": modelYear,
        "price": price,
        "bodyType": bodyType,
        "transmissionType": transmissionType,
        "fuelRange": fuelRange,
        "color": color,
        "usage": usage,
        "type": type,
        "sellerType": sellerType,
        "badges": badges,
        "mileage": mileage,
        "topSpeed": topSpeed,
        "engine": engine,
        "numberOfSeats": numberOfSeats,
        "airBags": airBags,
        "fuelType": fuelType,
        "numberOfseats": numberOfseats,
      };
}
