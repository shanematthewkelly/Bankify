import 'dart:convert';
import 'package:Bankify/models/balanceCards.dart';
import 'package:Bankify/screens/core/transactions/transactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BalanceFragment extends StatefulWidget {
  @override
  _BalanceFragmentState createState() => _BalanceFragmentState();
}

class _BalanceFragmentState extends State<BalanceFragment> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getAccountBalance();
    getRecentTransaction();
  }

  int currentBalance = 0;
  String recentTransactionName = "";
  String recentTransactionDate = "";
  String recentTransactionPayment = "";

  Color tileColor(int selector) {
    if (selector % 3 == 0) {
      return Color.fromRGBO(26, 68, 237, 1);
    }
    if (selector % 3 == 1) {
      return Color.fromRGBO(219, 0, 161, 1);
    }
    if (selector % 3 == 2) {
      return Colors.red;
    }
    return Colors.white;
  }

  Color shadowColor(int selector) {
    if (selector % 3 == 0) {
      return Color.fromRGBO(26, 68, 237, .3);
    }
    if (selector % 3 == 1) {
      return Color.fromRGBO(219, 0, 161, .3);
    }
    if (selector % 3 == 2) {
      return Colors.red;
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _isLoading != true
              ? Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 250,
                          width: MediaQuery.of(context).size.height / 1,
                          margin: EdgeInsets.only(
                              left: 15, right: 15, top: 0, bottom: 24),
                          padding: EdgeInsets.only(top: 25),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: Offset(0, 0.5)),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 18),
                                              child: Text(
                                                "€" + "$currentBalance",
                                                style: TextStyle(
                                                    fontSize: 34,
                                                    fontFamily: 'MetroBold'),
                                              ),
                                            ),
                                            Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 18),
                                                child: Text(
                                                  "A V A I L A B L E",
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      height: 55,
                                      width: 55,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Image.asset(
                                            "assets/images/currency.png",
                                            fit: BoxFit.contain),
                                      )),
                                ],
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, left: 15, right: 15),
                                  child: Divider(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 18, right: 18),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Transactions",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Transactions()),
                                        );
                                      },
                                      child: Text(
                                        "See More",
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(26, 68, 237, 1),
                                            fontSize: 14),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 35, left: 14),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 42,
                                      width: 42,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Color.fromRGBO(26, 68, 237, 1),
                                      ),
                                      child: Icon(
                                        Icons.repeat_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 4, left: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "$recentTransactionName",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontFamily: 'MetroBold'),
                                          ),
                                          Text("$recentTransactionDate",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13,
                                              ))
                                        ],
                                      ),
                                    ),
                                    Container(
                                        // Non-Responsive
                                        margin: EdgeInsets.only(left: 150),
                                        child: Text(
                                            "- €" + "$recentTransactionPayment",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontFamily: 'MetroBold')))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: EdgeInsets.only(top: 30, left: 20),
                                child: Text(
                                  "Recommended",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              height: 250,
                              child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: balanceCardUI.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: 250,
                                      margin: EdgeInsets.only(
                                          left: 15,
                                          right: 10,
                                          top: 10,
                                          bottom: 10),
                                      padding:
                                          EdgeInsets.only(top: 10, left: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: tileColor(index),
                                        boxShadow: [
                                          BoxShadow(
                                              color: shadowColor(index),
                                              spreadRadius: 1,
                                              blurRadius: 4,
                                              offset: Offset(0, 0.5)),
                                        ],
                                      ),
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                width: 130,
                                                height: 130,
                                                child: Image.asset(
                                                    balanceCardUI[index].image,
                                                    fit: BoxFit.contain),
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 20,
                                                            left: 14),
                                                    child: Text(
                                                      balanceCardUI[index]
                                                          .title,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'MetroBold',
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height * .50,
                  margin: EdgeInsets.only(top: 50),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color.fromRGBO(26, 68, 237, 1)))
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  // Retrieves 'Available' & 'Current' balances
  Future getAccountBalance() async {
    _isLoading = true;

    final String url =
        "https://6q8uxgokqf.execute-api.us-east-1.amazonaws.com/dev/api/balance";

    final response =
        await http.get(url, headers: {"Accept": "Application/json"});

    var responseData = jsonDecode(response.body)['accounts'] as List;

    List<Accounts> accountObjects =
        responseData.map((result) => Accounts.fromJson(result)).toList();

    if (response.statusCode == 200) {
      getCurrentFundsSum(accountObjects).then((value) => setState(() {
            currentBalance = value;
            _isLoading = false;
          }));
    }
  }

  // Retrieves the sum of all account 'current' funds
  Future<int> getCurrentFundsSum(List accountObjects) async {
    return accountObjects.fold<int>(
        0, (sum, account) => sum + account.getOverallCurrentBalance());
  }

  // Recent Transactions
  Future getRecentTransaction() async {
    final String url =
        "https://6q8uxgokqf.execute-api.us-east-1.amazonaws.com/dev/api/transactions";

    final response =
        await http.get(url, headers: {"Accept": "Application/json"});

    var transactionData = jsonDecode(response.body)["transactions"] as List;

    List<TransactionInformation> infoData = transactionData
        .map((result) => TransactionInformation.fromJson(result))
        .toList();

    if (response.statusCode == 200) {
      setState(() {
        recentTransactionName = infoData[0].transactionName;
        recentTransactionDate = infoData[0].transactionDate;
        recentTransactionPayment = infoData[0].transactionPayment.toString();
      });
    }
  }
}

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
