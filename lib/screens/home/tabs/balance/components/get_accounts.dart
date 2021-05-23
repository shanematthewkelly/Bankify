class Accounts {
  int currentBalance;

  Accounts(this.currentBalance);

  factory Accounts.fromJson(dynamic json) {
    return Accounts(json["balances"]["current"].truncate());
  }

  int getOverallCurrentBalance() {
    return this.currentBalance;
  }
}
