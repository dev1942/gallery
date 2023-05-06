

class FilterListModel {
  String? status;
  Result? result;

  FilterListModel({this.status, this.result});

  FilterListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
    json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  List<String>? carCompanyList;
  List<String>? carModalList;
  List<String>? carModelYearList;
  List<String>? bodyTypeList;
  List<String>? carColorList;
  PriceRange? priceRange;
  MilageRange? milageRange;

  Result(
      {this.carCompanyList,
        this.carModalList,
        this.carModelYearList,
        this.bodyTypeList,
        this.carColorList,
        this.priceRange,
        this.milageRange});

  Result.fromJson(Map<String, dynamic> json) {
    carCompanyList = json['carCompanyList'].cast<String>();
    carModalList = json['carModalList'].cast<String>();
    carModelYearList = json['carModelYearList'].cast<String>();
    bodyTypeList = json['bodyTypeList'].cast<String>();
    carColorList = json['carColorList'].cast<String>();
    priceRange = json['priceRange'] != null
        ? new PriceRange.fromJson(json['priceRange'])
        : null;
    milageRange =/* json['milageRange'] != null
        ? new MilageRange.fromJson(json['milageRange'])
        :*/ null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carCompanyList'] = this.carCompanyList;
    data['carModalList'] = this.carModalList;
    data['carModelYearList'] = this.carModelYearList;
    data['bodyTypeList'] = this.bodyTypeList;
    data['carColorList'] = this.carColorList;
    if (this.priceRange != null) {
      data['priceRange'] = this.priceRange!.toJson();
    }
    if (this.milageRange != null) {
      data['milageRange'] = this.milageRange!.toJson();
    }
    return data;
  }
}

class PriceRange {
  String? min;
  String? max;

  PriceRange({this.min, this.max});

  PriceRange.fromJson(Map<String, dynamic> json) {
    min = json['min'];
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min'] = this.min;
    data['max'] = this.max;
    return data;
  }
}

class MilageRange {
  int? min;
  int? max;

  MilageRange({this.min, this.max});

  MilageRange.fromJson(Map<String, dynamic> json) {
    min = int.tryParse(json['min'])??0;
    max = int.tryParse(json['max']??100);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min'] = this.min;
    data['max'] = this.max;
    return data;
  }
}
