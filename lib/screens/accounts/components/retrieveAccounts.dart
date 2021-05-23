class AccountInformation {
  final String accountName, accountType;
  // int currentBalance;

  AccountInformation(this.accountName, this.accountType);

  factory AccountInformation.fromJson(dynamic json) {
    return AccountInformation(json["name"] as String, json["type"] as String);
  }

  @override
  String toString() {
    return '${this.accountName}, ${this.accountType}';
  }

  // int singleAccountBalances() {
  //   return this.currentBalance;
  // }
}
