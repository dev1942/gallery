// To parse this JSON data, do
//
//     final autoLoanModel = autoLoanModelFromMap(jsonString);

import 'dart:convert';

class AutoLoanModel {
  AutoLoanModel({
    required this.parent,
    required this.activeByAdmin,
    required this.countries,
    required this.deleted,
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.type,
    required this.fields,
    required this.createdAt,
    required this.updatedAt,
    required this.slug,
  });

  dynamic parent;
  dynamic activeByAdmin;
  List<dynamic> countries;
  dynamic deleted;
  dynamic id;
  dynamic image;
  dynamic title;
  dynamic description;
  dynamic type;
  List<dynamic> fields;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic slug;

  factory AutoLoanModel.fromJson(dynamic str) =>
      AutoLoanModel.fromMap(json.decode(str));

  dynamic toJson() => json.encode(toMap());

  factory AutoLoanModel.fromMap(Map<dynamic, dynamic> json) => AutoLoanModel(
        parent: json["parent"],
        activeByAdmin: json["activeByAdmin"],
        countries: List<dynamic>.from(json["countries"].map((x) => x)),
        deleted: json["deleted"],
        id: json["_id"],
        image: json["image"],
        title: json["title"],
        description: json["description"],
        type: json["type"],
        fields: List<dynamic>.from(json["fields"].map((x) => x)),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        slug: json["slug"],
      );

  Map<dynamic, dynamic> toMap() => {
        "parent": parent,
        "activeByAdmin": activeByAdmin,
        "countries": List<dynamic>.from(countries.map((x) => x)),
        "deleted": deleted,
        "_id": id,
        "image": image,
        "title": title,
        "description": description,
        "type": type,
        "fields": List<dynamic>.from(fields.map((x) => x)),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "slug": slug,
      };
}
