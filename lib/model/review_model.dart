// To parse this JSON data, do
//
//     final reviewModel = reviewModelFromMap(jsonString);

import 'dart:convert';

class ReviewModel {
  ReviewModel({
    required this.customerToProvider,
    required this.providerToCustomer,
    required this.id,
    required this.provider,
    required this.booking,
    required this.customer,
    required this.createdAt,
    required this.updatedAt,
    required this.reviewModelId,
  });

  CustomerToProvider? customerToProvider;
  ProviderToCustomer? providerToCustomer;
  dynamic id;
  Provider? provider;
  Booking? booking;
  ReviewModelCustomer? customer;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic reviewModelId;

  factory ReviewModel.fromJson(dynamic str) =>
      ReviewModel.fromMap(json.decode(str));

  dynamic toJson() => json.encode(toMap());

  factory ReviewModel.fromMap(Map<dynamic, dynamic> json) => ReviewModel(
        customerToProvider: json["customer_to_provider"] == null
            ? null
            : CustomerToProvider.fromMap(json["customer_to_provider"]),
        providerToCustomer: json["provider_to_customer"] == null
            ? null
            : ProviderToCustomer.fromMap(json["provider_to_customer"]),
        id: json["_id"],
        provider: json["provider"] == null
            ? null
            : Provider.fromMap(json["provider"]),
        booking:
            json["booking"] == null ? null : Booking.fromMap(json["booking"]),
        customer: ReviewModelCustomer.fromMap(json["customer"]),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        reviewModelId: json["id"],
      );

  Map<dynamic, dynamic> toMap() => {
        "customer_to_provider": customerToProvider!.toMap(),
        "provider_to_customer": providerToCustomer!.toMap(),
        "_id": id,
        "provider": provider!.toMap(),
        "booking": booking!.toMap(),
        "customer": customer!.toMap(),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "id": reviewModelId,
      };
}

class Booking {
  Booking({
    required this.id,
    required this.provider,
    required this.customer,
    required this.items,
  });

  dynamic id;
  ProviderClass provider;
  ProviderClass customer;
  List<Item> items;

  factory Booking.fromJson(dynamic str) => Booking.fromMap(json.decode(str));

  dynamic toJson() => json.encode(toMap());

  factory Booking.fromMap(Map<dynamic, dynamic> json) => Booking(
        id: json["_id"],
        provider: ProviderClass.fromMap(json["provider"]),
        customer: ProviderClass.fromMap(json["customer"]),
        items: List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
      );

  Map<dynamic, dynamic> toMap() => {
        "_id": id,
        "provider": provider.toMap(),
        "customer": customer.toMap(),
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}

class ProviderClass {
  ProviderClass({
    required this.country,
    required this.role,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.customerId,
  });

  List<dynamic> country;
  dynamic role;
  dynamic id;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  dynamic phone;
  dynamic customerId;

  factory ProviderClass.fromJson(dynamic str) =>
      ProviderClass.fromMap(json.decode(str));

  dynamic toJson() => json.encode(toMap());

  factory ProviderClass.fromMap(Map<dynamic, dynamic> json) => ProviderClass(
        country: List<dynamic>.from(json["country"].map((x) => x)),
        role: json["role"],
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"],
        customerId: json["id"],
      );

  Map<dynamic, dynamic> toMap() => {
        "country": List<dynamic>.from(country.map((x) => x)),
        "role": role,
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "id": customerId,
      };
}

class Item {
  Item({
    required this.source,
  });

  dynamic source;

  factory Item.fromJson(dynamic str) => Item.fromMap(json.decode(str));

  dynamic toJson() => json.encode(toMap());

  factory Item.fromMap(Map<dynamic, dynamic> json) => Item(
        source: json["source"],
      );

  Map<dynamic, dynamic> toMap() => {
        "source": source,
      };
}

class ReviewModelCustomer {
  ReviewModelCustomer({
    required this.country,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.customerId,
  });

  List<dynamic> country;
  dynamic id;
  dynamic firstName;
  dynamic lastName;
  dynamic image;
  dynamic customerId;

  factory ReviewModelCustomer.fromJson(dynamic str) =>
      ReviewModelCustomer.fromMap(json.decode(str));

  dynamic toJson() => json.encode(toMap());

  factory ReviewModelCustomer.fromMap(Map<dynamic, dynamic> json) =>
      ReviewModelCustomer(
        country: List<dynamic>.from(json["country"].map((x) => x)),
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        image: json["image"],
        customerId: json["id"],
      );

  Map<dynamic, dynamic> toMap() => {
        "country": List<dynamic>.from(country.map((x) => x)),
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

  dynamic review;
  int rating;

  factory CustomerToProvider.fromJson(dynamic str) =>
      CustomerToProvider.fromMap(json.decode(str));

  dynamic toJson() => json.encode(toMap());

  factory CustomerToProvider.fromMap(Map<dynamic, dynamic> json) =>
      CustomerToProvider(
        review: json["review"],
        rating: json["rating"],
      );

  Map<dynamic, dynamic> toMap() => {
        "review": review,
        "rating": rating,
      };
}

class ProviderToCustomer {
  ProviderToCustomer({
    required this.review,
    required this.rating,
  });

  dynamic review;
  int rating;

  factory ProviderToCustomer.fromJson(dynamic str) =>
      ProviderToCustomer.fromMap(json.decode(str));

  dynamic toJson() => json.encode(toMap());

  factory ProviderToCustomer.fromMap(Map<dynamic, dynamic> json) =>
      ProviderToCustomer(
        review: json["review"],
        rating: json["rating"],
      );

  Map<dynamic, dynamic> toMap() => {
        "review": review,
        "rating": rating,
      };
}

class Provider {
  Provider({
    required this.country,
    required this.states,
    required this.cities,
    required this.banned,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    required this.role,
    required this.experienceLevel,
    required this.about,
    required this.status,
    required this.approvedBy,
    required this.firebaseToken,
    required this.emergency,
    required this.car,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.refrence,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.stripeId,
    required this.coverImage,
    required this.providerId,
  });

  List<dynamic> country;
  List<dynamic> states;
  List<dynamic> cities;
  bool banned;
  bool isEmailVerified;
  bool isPhoneVerified;
  dynamic role;
  dynamic experienceLevel;
  dynamic about;
  dynamic status;
  dynamic approvedBy;
  dynamic firebaseToken;
  List<dynamic> emergency;
  List<dynamic> car;
  dynamic id;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  dynamic phone;
  dynamic refrence;
  dynamic image;
  dynamic createdAt;
  dynamic updatedAt;
  int v;
  dynamic stripeId;
  dynamic coverImage;
  dynamic providerId;

  factory Provider.fromJson(dynamic str) => Provider.fromMap(json.decode(str));

  dynamic toJson() => json.encode(toMap());

  factory Provider.fromMap(Map<dynamic, dynamic> json) => Provider(
        country: List<dynamic>.from(json["country"].map((x) => x)),
        states: List<dynamic>.from(json["states"].map((x) => x)),
        cities: List<dynamic>.from(json["cities"].map((x) => x)),
        banned: json["banned"],
        isEmailVerified: json["isEmailVerified"],
        isPhoneVerified: json["isPhoneVerified"],
        role: json["role"],
        experienceLevel: json["experienceLevel"],
        about: json["about"],
        status: json["status"],
        approvedBy: json["approvedBy"],
        firebaseToken: json["firebaseToken"],
        emergency: List<dynamic>.from(json["emergency"].map((x) => x)),
        car: List<dynamic>.from(json["car"].map((x) => x)),
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"],
        refrence: json["refrence"],
        image: json["image"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
        stripeId: json["stripeId"],
        coverImage: json["coverImage"],
        providerId: json["id"],
      );

  Map<dynamic, dynamic> toMap() => {
        "country": List<dynamic>.from(country.map((x) => x)),
        "states": List<dynamic>.from(states.map((x) => x)),
        "cities": List<dynamic>.from(cities.map((x) => x)),
        "banned": banned,
        "isEmailVerified": isEmailVerified,
        "isPhoneVerified": isPhoneVerified,
        "role": role,
        "experienceLevel": experienceLevel,
        "about": about,
        "status": status,
        "approvedBy": approvedBy,
        "firebaseToken": firebaseToken,
        "emergency": List<dynamic>.from(emergency.map((x) => x)),
        "car": List<dynamic>.from(car.map((x) => x)),
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "refrence": refrence,
        "image": image,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
        "stripeId": stripeId,
        "coverImage": coverImage,
        "id": providerId,
      };
}
