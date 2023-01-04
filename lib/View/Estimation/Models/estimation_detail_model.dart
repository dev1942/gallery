import 'dart:developer';

class EstimationDetailModel {
  String id;

  List<Items> items;

  String discount;
  String grandTotal;
  String serviceTax;
  String subTotal;

  EstimationDetailModel(
      {required this.id,
      required this.items,
      required this.discount,
      required this.grandTotal,
      required this.serviceTax,
      required this.subTotal});

  factory EstimationDetailModel.fromJson(Map<String, dynamic> json) {
    List<Items> alItems = [];

    try {
      var items_ = json['items'];
      for (var itemsList in items_) {
        Items mItems = Items.fromJson(itemsList);
        alItems.add(mItems);
      }
    } catch (exp) {
      log(exp.toString());
    }

    return EstimationDetailModel(
        id: json['_id'].toString(),
        items: alItems,
        discount: json['discount'].toString(),
        grandTotal: json['grandTotal'].toString(),
        serviceTax: json['serviceTax'].toString(),
        subTotal: json['subTotal'].toString());
  }
}

class Items {
  String title;
  String description;
  String quantity;
  String price;
  String tax;
  String amount;

  Items(
      {required this.title,
      required this.description,
      required this.quantity,
      required this.price,
      required this.tax,
      required this.amount});

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
        title: json['title'].toString(),
        description: json['description'].toString(),
        quantity: json['quantity'].toString(),
        price: json['price'].toString(),
        tax: json['tax'].toString(),
        amount: json['amount'].toString());
  }
}
