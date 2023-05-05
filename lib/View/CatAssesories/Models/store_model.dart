class AccessoriesStoreModel {
  String? sId;
  String? ssn;
  bool? deliver;
  List<String>? images;
  String? name;
  String? country;
  String? city;
  String? state;
  String? address;
  String? description;
  String? serviceRadius;
  DeliveryDetails? deliveryDetails;
  GeoLocation? geoLocation;
  String? provider;
  String? type;
  String? createdAt;
  String? updatedAt;
  int? iV;
  List<Products>? products;

  AccessoriesStoreModel(
      {this.sId,
        this.ssn,
        this.deliver,
        this.images,
        this.name,
        this.country,
        this.city,
        this.state,
        this.address,
        this.description,
        this.serviceRadius,
        this.deliveryDetails,
        this.geoLocation,
        this.provider,
        this.type,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.products});

  AccessoriesStoreModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    ssn = json['ssn'];
    deliver = json['deliver'];
    images = json['images'].cast<String>();
    name = json['name'];
    country = json['country'];
    city = json['city'];
    state = json['state'];
    address = json['address'];
    description = json['description'];
    serviceRadius = json['serviceRadius'];
    deliveryDetails = json['deliveryDetails'] != null
        ? new DeliveryDetails.fromJson(json['deliveryDetails'])
        : null;
    geoLocation = json['geoLocation'] != null
        ? new GeoLocation.fromJson(json['geoLocation'])
        : null;
    provider = json['provider'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['ssn'] = this.ssn;
    data['deliver'] = this.deliver;
    data['images'] = this.images;
    data['name'] = this.name;
    data['country'] = this.country;
    data['city'] = this.city;
    data['state'] = this.state;
    data['address'] = this.address;
    data['description'] = this.description;
    data['serviceRadius'] = this.serviceRadius;
    if (this.deliveryDetails != null) {
      data['deliveryDetails'] = this.deliveryDetails!.toJson();
    }
    if (this.geoLocation != null) {
      data['geoLocation'] = this.geoLocation!.toJson();
    }
    data['provider'] = this.provider;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeliveryDetails {
  int? charge;
  int? range;
  int? days;

  DeliveryDetails({this.charge, this.range, this.days});

  DeliveryDetails.fromJson(Map<String, dynamic> json) {
    charge = json['charge'];
    range = json['range'];
    days = json['days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['charge'] = this.charge;
    data['range'] = this.range;
    data['days'] = this.days;
    return data;
  }
}

class GeoLocation {
  double? latitude;
  double? longitude;

  GeoLocation({this.latitude, this.longitude});

  GeoLocation.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class Products {
  String? sId;
  List<String>? image;

  Products({this.sId, this.image});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    image = json['image'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['image'] = this.image;
    return data;
  }
}
