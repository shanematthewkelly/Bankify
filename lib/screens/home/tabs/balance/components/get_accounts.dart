class Accounts {
  int currentBalance;

  Accounts(this.currentBalance);

  factory Accounts.fromJson(dynamic json) {
    return Accounts(json["balances"]["current"].truncate());
  }

  @override
  String toString() {
    return '${this.currentBalance}';
  }

  int getOverallCurrentBalance() {
    return this.currentBalance;
  }
}
