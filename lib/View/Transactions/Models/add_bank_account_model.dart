class AddBankAccountModel {
  String bankName;
  String ibanNumber;
  String swiftCode;
  String branchName;
  String country;
  String currency;
  String accHolderName;
  String accHolderType;
  String routingNumber;
  String accountNumber;

  AddBankAccountModel({
    required this.ibanNumber,
    required this.accHolderName,
    required this.accHolderType,
    required this.accountNumber,
    required this.bankName,
    required this.branchName,
    required this.country,
    required this.currency,
    required this.routingNumber,
    required this.swiftCode,
  });
}
