class CountryCode {
  String dialCode;
  String name;
  String code;

  CountryCode({required this.dialCode, required this.name, required this.code});

  factory CountryCode.fromJson(Map<String, dynamic> json) {
    return CountryCode(
        dialCode: json['dial_code'].toString(),
        code: json['code'].toString(),
        name: json['name'].toString());
  }
}
