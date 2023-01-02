import 'dart:developer';

class StoreModel {
  List<String> images;
  String id;
  String name;
  String country;
  String state;
  String city;
  String address;

  StoreModel(
      {required this.id,
      required this.images,
      required this.name,
      required this.country,
      required this.state,
      required this.city,
      required this.address});

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    List<String> alImages = [];

    try {
      var images = json['images'];
      for (var imagesItem in images) {
        alImages.add(imagesItem.toString());
      }
    } catch (e) {
      log(e.toString());
    }

    return StoreModel(
      images: alImages,
      id: json['_id'].toString(),
      name: json['name'].toString(),
      country: json['country'].toString(),
      state: json['state'].toString(),
      city: json['city'].toString(),
      address: json['address'].toString(),
    );
  }
}
