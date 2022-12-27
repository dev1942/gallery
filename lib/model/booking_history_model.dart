// To parse this JSON data, do
//
//     final bookingHistoryModel = bookingHistoryModelFromMap(jsonString);

import 'dart:convert';

List<BookingHistoryModel> bookingHistoryModelFromMap(String str) =>
    List<BookingHistoryModel>.from(
        json.decode(str).map((x) => BookingHistoryModel.fromMap(x)));

String bookingHistoryModelToMap(List<BookingHistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class BookingHistoryModel {
  BookingHistoryModel({
    required this.totalprice,
    required this.status,
    required this.id,
    required this.provider,
    required this.customer,
    required this.estimate,
    required this.address,
    required this.bookingDetails,
    required this.order,
    required this.task,
    required this.itemType,
    required this.items,
    required this.createdAt,
    required this.updatedAt,
  });

  int totalprice;
  String status;
  String id;
  Customer provider;
  Customer customer;
  String estimate;
  String address;
  BookingDetails bookingDetails;
  List<Order> order;
  List<Order> task;
  String itemType;
  List<dynamic> items;
  String createdAt;
  String updatedAt;

  factory BookingHistoryModel.fromMap(Map<String, dynamic> json) =>
      BookingHistoryModel(
        totalprice: json["totalprice"],
        status: json["status"],
        id: json["_id"],
        provider: Customer.fromMap(json["provider"]),
        customer: Customer.fromMap(json["customer"]),
        estimate: json["estimate"] ?? '',
        address: json["address"] ?? "",
        bookingDetails: BookingDetails.fromMap(json["bookingDetails"]),
        order: List<Order>.from(json["order"].map((x) => Order.fromMap(x))),
        task: List<Order>.from(json["task"].map((x) => Order.fromMap(x))),
        itemType: json["itemType"],
        items: List<dynamic>.from(json["items"].map((x) => x)),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toMap() => {
        "totalprice": totalprice,
        "status": status,
        "_id": id,
        "provider": provider.toMap(),
        "customer": customer.toMap(),
        "estimate": estimate,
        "address": address,
        "bookingDetails": bookingDetails.toMap(),
        "order": List<dynamic>.from(order.map((x) => x.toMap())),
        "task": List<dynamic>.from(task.map((x) => x.toMap())),
        "itemType": itemType,
        "items": List<dynamic>.from(items.map((x) => x)),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

class BookingDetails {
  BookingDetails({
    required this.date,
    required this.note,
  });

  String date;
  List<dynamic> note;

  factory BookingDetails.fromMap(Map<String, dynamic> json) => BookingDetails(
        date: json["date"],
        note: List<dynamic>.from(json["note"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "date": date,
        "note": List<dynamic>.from(note.map((x) => x)),
      };
}

class Customer {
  Customer({
    required this.country,
    required this.role,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.customerId,
  });

  List<String> country;
  String role;
  String id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String customerId;

  factory Customer.fromMap(Map<String, dynamic> json) => Customer(
        country: List<String>.from(json["country"].map((x) => x)),
        role: json["role"],
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"],
        customerId: json["id"],
      );

  Map<String, dynamic> toMap() => {
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

class Order {
  Order({
    required this.status,
    required this.date,
  });

  String status;
  String date;
  factory Order.fromMap(Map<String, dynamic> json) => Order(
        status: json["status"],
        date: json["date"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "date": date,
      };
}
