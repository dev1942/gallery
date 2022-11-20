///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class GetCarModelResult {
/*
{
  "_id": "63795c77b98385152c5380ff",
  "brand": "Honda",
  "color": "Red",
  "modelYear": "2025",
  "mileage": "12400",
  "carCity": "Dubai",
  "carCode": "87",
  "carNumber": "1234"
}
*/

  String? Id;
  String? brand;
  String? color;
  String? modelYear;
  String? mileage;
  String? carCity;
  String? carCode;
  String? carNumber;

  GetCarModelResult({
    this.Id,
    this.brand,
    this.color,
    this.modelYear,
    this.mileage,
    this.carCity,
    this.carCode,
    this.carNumber,
  });
  GetCarModelResult.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    brand = json['brand']?.toString();
    color = json['color']?.toString();
    modelYear = json['modelYear']?.toString();
    mileage = json['mileage']?.toString();
    carCity = json['carCity']?.toString();
    carCode = json['carCode']?.toString();
    carNumber = json['carNumber']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
    data['brand'] = brand;
    data['color'] = color;
    data['modelYear'] = modelYear;
    data['mileage'] = mileage;
    data['carCity'] = carCity;
    data['carCode'] = carCode;
    data['carNumber'] = carNumber;
    return data;
  }
}

class GetCarModel {
/*
{
  "status": "success",
  "message": "Updated Successfully",
  "result": [
    {
      "_id": "63795c77b98385152c5380ff",
      "brand": "Honda",
      "color": "Red",
      "modelYear": "2025",
      "mileage": "12400",
      "carCity": "Dubai",
      "carCode": "87",
      "carNumber": "1234"
    }
  ]
}
*/

  String? status;
  String? message;
  List<GetCarModelResult?>? result;

  GetCarModel({
    this.status,
    this.message,
    this.result,
  });
  GetCarModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    message = json['message']?.toString();
    if (json['result'] != null) {
      final v = json['result'];
      final arr0 = <GetCarModelResult>[];
      v.forEach((v) {
        arr0.add(GetCarModelResult.fromJson(v));
      });
      result = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      final v = result;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['result'] = arr0;
    }
    return data;
  }
}
