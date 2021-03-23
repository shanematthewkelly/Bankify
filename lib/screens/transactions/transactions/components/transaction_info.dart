class TransactionInformation {
  final String transactionName;
  final String transactionDate;
  final int transactionPayment;

  TransactionInformation(
      this.transactionName, this.transactionDate, this.transactionPayment);

  factory TransactionInformation.fromJson(dynamic json) {
    return TransactionInformation(json["name"] as String,
        json["date"] as String, json["amount"].truncate());
  }

  @override
  String toString() {
    return '${this.transactionName}, ${this.transactionDate}';
  }

  int getTransactionPayments() {
    return this.transactionPayment;
  }
}
