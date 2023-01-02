// To parse this JSON data, do
//
//     final empty = emptyFromMap(jsonString);

import 'dart:convert';

class CartModel {
  CartModel({
    required this.id,
    required this.object,
    required this.brand,
    required this.country,
    required this.customer,
    required this.cvcCheck,
    required this.expMonth,
    required this.expYear,
    required this.fingerprint,
    required this.last4,
    required this.name,
  });

  String id;
  String object;
  String brand;
  String country;
  String customer;
  String cvcCheck;
  int expMonth;
  int expYear;
  String fingerprint;
  String last4;
  String name;

  factory CartModel.fromJson(String str) => CartModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CartModel.fromMap(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        object: json["object"],
        brand: json["brand"],
        country: json["country"],
        customer: json["customer"],
        cvcCheck: json["cvc_check"],
        expMonth: json["exp_month"],
        expYear: json["exp_year"],
        fingerprint: json["fingerprint"],
        last4: json["last4"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "object": object,
        "brand": brand,
        "country": country,
        "customer": customer,
        "cvc_check": cvcCheck,
        "exp_month": expMonth,
        "exp_year": expYear,
        "fingerprint": fingerprint,
        "last4": last4,
        "name": name,
      };
}
