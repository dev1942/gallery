class UserDetail {
  String id;
  String firstName;
  String lastName;
  String avatar;
  String mobile;
  String email;
  bool? isEmailVerified;
  bool? isPhoneVerified;
  String accessToken;

  UserDetail(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.avatar,
      required this.mobile,
      required this.email,
        this.isEmailVerified,
        this.isPhoneVerified,
      required this.accessToken});
}
