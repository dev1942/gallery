// To parse this JSON data, do
//
//     final storeProductModel = storeProductModelFromMap(jsonString);

import 'dart:convert';

class StoreProductModel {
  StoreProductModel({
    required this.pId,
    required this.image,
    required this.video,
    required this.features,
    required this.active,
    required this.deleted,
    required this.id,
    required this.category,
    required this.subcategory,
    required this.title,
    required this.description,
    required this.details,
    required this.wholesalePrice,
    required this.retailPrice,
    required this.warranty,
    required this.brand,
    required this.stores,
    required this.provider,
    required this.currency,
    required this.activeByAdmin,
    required this.createdAt,
    required this.updatedAt,
    required this.promotion,
    required this.storeProductModelId,
  });

  String pId;
  List<String> image;
  List<String> video;
  List<String> features;
  bool active;
  bool deleted;
  String id;
  Category? category;
  Category? subcategory;
  String title;
  String description;
  Details? details;
  int wholesalePrice;
  int retailPrice;
  int warranty;
  String brand;
  List<StoreElement> stores;
  Provider? provider;
  String currency;
  String activeByAdmin;
  String createdAt;
  String updatedAt;
  dynamic promotion;
  String storeProductModelId;

  factory StoreProductModel.fromJson(String str) =>
      StoreProductModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StoreProductModel.fromMap(Map<String, dynamic> json) =>
      StoreProductModel(
        pId: json["p_id"],
        image: json["image"] == null
            ? []
            : List<String>.from(json["image"].map((x) => x)),
        video: json["video"] == null
            ? []
            : List<String>.from(json["video"].map((x) => x)),
        features: json["features"] == null
            ? []
            : List<String>.from(json["features"].map((x) => x)),
        active: json["active"],
        deleted: json["deleted"],
        id: json["_id"],
        category: json["category"] == null
            ? null
            : Category.fromMap(json["category"]),
        subcategory: json["subcategory"] == null
            ? null
            : Category.fromMap(json["subcategory"]),
        title: json["title"],
        description: json["description"],
        details: Details.fromMap(json["details"]),
        wholesalePrice: json["wholesalePrice"],
        retailPrice: json["retailPrice"],
        warranty: json["warranty"],
        brand: json["brand"],
        stores: json["stores"] == null
            ? []
            : List<StoreElement>.from(
                json["stores"].map((x) => StoreElement.fromMap(x))),
        provider: json["provider"] == null
            ? null
            : Provider.fromMap(json["provider"]),
        currency: json["currency"],
        activeByAdmin: json["activeByAdmin"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        promotion: json["promotion"],
        storeProductModelId: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "p_id": pId,
        "image": List<dynamic>.from(image.map((x) => x)),
        "video": List<dynamic>.from(video.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x)),
        "active": active,
        "deleted": deleted,
        "_id": id,
        "category": category != null ? category!.toMap() : null,
        "subcategory": subcategory != null ? subcategory!.toMap() : null,
        "title": title,
        "description": description,
        "details": details != null ? details!.toMap() : null,
        "wholesalePrice": wholesalePrice,
        "retailPrice": retailPrice,
        "warranty": warranty,
        "brand": brand,
        "stores": List<dynamic>.from(stores.map((x) => x.toMap())),
        "provider": provider != null ? provider!.toMap() : null,
        "currency": currency,
        "activeByAdmin": activeByAdmin,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "promotion": promotion,
        "id": storeProductModelId,
      };
}

class Category {
  Category({
    required this.parent,
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.image,
    required this.slug,
  });

  String? parent;
  String id;
  String type;
  String title;
  String description;
  String image;
  String slug;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        parent: json["parent"],
        id: json["_id"],
        type: json["type"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        slug: json["slug"],
      );

  Map<String, dynamic> toMap() => {
        "parent": parent,
        "_id": id,
        "type": type,
        "title": title,
        "description": description,
        "image": image,
        "slug": slug,
      };
}

class Details {
  Details({
    required this.newOrOld,
    required this.usage,
    required this.condition,
  });

  String newOrOld;
  String usage;
  String condition;

  factory Details.fromJson(String str) => Details.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Details.fromMap(Map<String, dynamic> json) => Details(
        newOrOld: json["newOrOld"],
        usage: json["usage"],
        condition: json["condition"],
      );

  Map<String, dynamic> toMap() => {
        "newOrOld": newOrOld,
        "usage": usage,
        "condition": condition,
      };
}

class Provider {
  Provider({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.providerId,
  });

  String id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String providerId;

  factory Provider.fromJson(String str) => Provider.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Provider.fromMap(Map<String, dynamic> json) => Provider(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"],
        providerId: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "id": providerId,
      };
}

class StoreElement {
  StoreElement({
    required this.soldQty,
    required this.store,
    required this.stockQty,
    required this.createdAt,
    required this.updatedAt,
    required this.inStock,
    required this.id,
  });

  int soldQty;
  StoreStore store;
  int stockQty;
  String createdAt;
  String updatedAt;
  int inStock;
  dynamic id;

  factory StoreElement.fromJson(String str) =>
      StoreElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StoreElement.fromMap(Map<String, dynamic> json) => StoreElement(
        soldQty: json["soldQty"],
        store: StoreStore.fromMap(json["store"]),
        stockQty: json["stockQty"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        inStock: json["inStock"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "soldQty": soldQty,
        "store": store.toMap(),
        "stockQty": stockQty,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "inStock": inStock,
        "id": id,
      };
}

class StoreStore {
  StoreStore({
    required this.id,
    required this.name,
    required this.country,
    required this.state,
    required this.city,
    required this.address,
  });

  String id;
  String name;
  String country;
  String state;
  String city;
  String address;

  factory StoreStore.fromJson(String str) =>
      StoreStore.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StoreStore.fromMap(Map<String, dynamic> json) => StoreStore(
        id: json["_id"],
        name: json["name"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        address: json["address"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "country": country,
        "state": state,
        "city": city,
        "address": address,
      };
}
