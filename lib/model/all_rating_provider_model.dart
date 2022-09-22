// To parse this JSON data, do
//
//     final allProviderRatingModel = allProviderRatingModelFromMap(jsonString);

import 'dart:convert';

class AllProviderRatingModel {
  AllProviderRatingModel({
    required this.customerToProvider,
    required this.id,
    required this.booking,
    required this.customer,
    required this.provider,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.allProviderRatingModelId,
  });

  CustomerToProvider? customerToProvider;
  String id;
  String booking;
  Customer? customer;
  String provider;
  String createdAt;
  String updatedAt;
  int v;
  String allProviderRatingModelId;

  factory AllProviderRatingModel.fromJson(String str) =>
      AllProviderRatingModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllProviderRatingModel.fromMap(Map<String, dynamic> json) =>
      AllProviderRatingModel(
        customerToProvider: json["customer_to_provider"] == null
            ? null
            : CustomerToProvider.fromMap(json["customer_to_provider"]),
        id: json["_id"],
        booking: json["booking"],
        customer: json["customer"] == null
            ? null
            : Customer.fromMap(json["customer"]),
        provider: json["provider"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
        allProviderRatingModelId: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "customer_to_provider": customerToProvider!.toMap(),
        "_id": id,
        "booking": booking,
        "customer": customer!.toMap(),
        "provider": provider,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
        "id": allProviderRatingModelId,
      };
}

class Customer {
  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.customerId,
  });

  String id;
  String firstName;
  String lastName;
  dynamic image;
  String customerId;

  factory Customer.fromJson(String str) => Customer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Customer.fromMap(Map<String, dynamic> json) => Customer(
        id: json["_id"],
        firstName: json["firstName"] ?? '',
        lastName: json["lastName"] ?? '',
        image: json["image"] ?? '',
        customerId: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "image": image,
        "id": customerId,
      };
}

class CustomerToProvider {
  CustomerToProvider({
    required this.review,
    required this.rating,
  });

  String review;
  int rating;

  factory CustomerToProvider.fromJson(String str) =>
      CustomerToProvider.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustomerToProvider.fromMap(Map<String, dynamic> json) =>
      CustomerToProvider(
        review: json["review"],
        rating: json["rating"],
      );

  Map<String, dynamic> toMap() => {
        "review": review,
        "rating": rating,
      };
}
