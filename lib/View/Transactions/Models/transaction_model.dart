// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromMap(jsonString);

import 'dart:convert';

class TransactionModel {
  TransactionModel({
    required this.metadata,
    required this.serviceTitle,
    required this.id,
    required this.source,
    required this.destination,
    required this.amount,
    required this.currency,
    required this.transactionId,
    required this.itemType,
    required this.createdAt,
    required this.updatedAt,
  });

  Metadata metadata;
  String serviceTitle;
  dynamic id;
  dynamic source;
  dynamic destination;
  dynamic amount;
  dynamic currency;
  dynamic transactionId;
  dynamic itemType;
  dynamic createdAt;
  dynamic updatedAt;

  factory TransactionModel.fromJson(dynamic str) => TransactionModel.fromMap(json.decode(str));

  dynamic toJson() => json.encode(toMap());

  factory TransactionModel.fromMap(Map<dynamic, dynamic> json) => TransactionModel(
        metadata: Metadata.fromMap(json["metadata"]),
        serviceTitle: json["serviceTitle"],
        id: json["_id"],
        source: json["source"],
        destination: json["destination"],
        amount: json["amount"],
        currency: json["currency"],
        transactionId: json["transactionId"],
        itemType: json["itemType"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<dynamic, dynamic> toMap() => {
        "metadata": metadata.toMap(),
        "_id": id,
        "source": source,
        "destination": destination,
        "amount": amount,
        "currency": currency,
        "transactionId": transactionId,
        "itemType": itemType,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

class Metadata {
  Metadata({
    required this.type,
    required this.user,
    required this.service,
    required this.provider,
  });

  String type;
  User user;
  Service? service;
  Provider? provider;

  factory Metadata.fromJson(dynamic str) => Metadata.fromMap(json.decode(str));

  dynamic toJson() => json.encode(toMap());

  factory Metadata.fromMap(Map<dynamic, dynamic> json) => Metadata(
        type: json["type"],
        user: User.fromMap(json["user"]),
        service: json["service"] == null ? null : Service.fromMap(json["service"]),
        provider: json["provider"] == null ? null : Provider.fromMap(json["provider"]),
      );

  Map<dynamic, dynamic> toMap() => {
        "type": type,
        "user": user.toMap(),
        "service": service!.toMap(),
        "provider": provider!.toMap(),
      };
}

class Provider {
  Provider({
    required this.status,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.providerId,
  });
  dynamic status;
  dynamic id;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  dynamic phone;
  dynamic image;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic providerId;

  factory Provider.fromJson(dynamic str) => Provider.fromMap(json.decode(str));

  dynamic toJson() => json.encode(toMap());

  factory Provider.fromMap(Map<dynamic, dynamic> json) => Provider(
        status: json["status"],
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        providerId: json["id"],
      );

  Map<dynamic, dynamic> toMap() => {
        "status": status,
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "image": image,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "id": providerId,
      };
}

class Service {
  Service({
    required this.deleted,
    required this.active,
    required this.id,
    required this.category,
    required this.subcategory,
    required this.title,
    required this.description,
    required this.price,
    required this.provider,
    required this.currency,
    required this.activeByAdmin,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.serviceId,
  });
  bool deleted;
  bool active;
  dynamic id;
  dynamic category;
  dynamic subcategory;
  dynamic title;
  dynamic description;
  dynamic price;
  dynamic provider;
  dynamic currency;
  dynamic activeByAdmin;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic v;
  dynamic serviceId;

  factory Service.fromJson(dynamic str) => Service.fromMap(json.decode(str));

  dynamic toJson() => json.encode(toMap());

  factory Service.fromMap(Map<dynamic, dynamic> json) => Service(
        deleted: json["deleted"],
        active: json["active"],
        id: json["_id"],
        category: json["category"],
        subcategory: json["subcategory"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        provider: json["provider"],
        currency: json["currency"],
        activeByAdmin: json["activeByAdmin"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
        serviceId: json["id"],
      );

  Map<dynamic, dynamic> toMap() => {
        "deleted": deleted,
        "active": active,
        "_id": id,
        "category": category,
        "subcategory": subcategory,
        "title": title,
        "description": description,
        "price": price,
        "provider": provider,
        "currency": currency,
        "activeByAdmin": activeByAdmin,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
        "id": serviceId,
      };
}

class User {
  User({
    required this.id,
    required this.email,
    required this.role,
    required this.country,
    required this.firstName,
    required this.lastName,
  });

  dynamic id;
  dynamic email;
  dynamic role;
  dynamic country;
  dynamic firstName;
  dynamic lastName;

  factory User.fromJson(dynamic str) => User.fromMap(json.decode(str));

  dynamic toJson() => json.encode(toMap());

  factory User.fromMap(Map<dynamic, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        role: json["role"],
        country: json["country"],
        firstName: json["firstName"],
        lastName: json["lastName"],
      );

  Map<dynamic, dynamic> toMap() => {
        "id": id,
        "email": email,
        "role": role,
        "country": country,
        "firstName": firstName,
        "lastName": lastName,
      };
}
