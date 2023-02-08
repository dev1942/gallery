class WalletModel {
  String id;
  String balance;
  String earning;
  String totalWithdraw;
  String currency;
  String user;
  String userType;
  String stripeWallet;

  // String "createdAt": "2022-07-11T19:15:49.363Z",
  // String "updatedAt": "2022-07-11T19:15:49.363Z",

  WalletModel(
      {required this.id,
      required this.balance,
      required this.earning,
      required this.totalWithdraw,
      required this.currency,
      required this.user,
      required this.userType,
      required this.stripeWallet});

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      return WalletModel(
        id: json['_id'].toString(),
        totalWithdraw: json['totalWithdraw'].toString(),
        earning: json['totalEarning'].toString(),
        balance: json['balance'].toString(),
        currency: json['currency'].toString(),
        user: json['user'].toString(),
        userType: json['userType'].toString(),
        stripeWallet: json['stripeWallet'].toString(),
      );
    } else {
      return WalletModel(
        id: "0",
        totalWithdraw: "0",
        earning: "0",
        balance: "0",
        currency: "0",
        user: "0",
        userType: "0",
        stripeWallet: "0",
      );
    }
  }
}
