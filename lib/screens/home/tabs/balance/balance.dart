import 'dart:convert';

import 'package:Bankify/configs/globals.dart';
import 'package:Bankify/configs/screen_sizing.dart';
import 'package:Bankify/screens/profile/body.dart';
import 'package:Bankify/screens/transactions/transactions/components/transaction_info.dart';
import 'package:Bankify/screens/transactions/transactions/transactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'components/get_accounts.dart';
import 'components/recommended.dart';

class Balance extends StatefulWidget {
  @override
  _BalanceState createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  @override
  void initState() {
    super.initState();
    getAccountBalance();
  }

  int currentBalance = 0;
  String recentTransactionName = "";
  String recentTransactionDate = "";
  String recentTransactionPayment = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: canvasColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: screenHeightData(25),
            ),
            Container(
                height: screenHeightData(260),
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  horizontal: screenWidthData(15),
                ),
                padding: EdgeInsets.only(top: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: shadowColor,
                        blurRadius: shadowBlur,
                        offset: shadowOffset),
                  ],
                ),
                child: balanceCard(context)),
            Container(
              height: screenHeightData(50),
            ),
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: screenWidthData(25)),
                    child: Text(
                      "What is there to do?",
                      style: TextStyle(
                          color: Colors.grey, fontSize: screenWidthData(16)),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  Recommended(
                    images: "assets/images/recommended3.png",
                    title: "Account Settings",
                    pressedRecommended: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileBody()),
                      );
                    },
                  ),
                  Recommended(
                    images: "assets/images/recommended1.png",
                    title: "View Transactions",
                    pressedRecommended: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Transactions()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column balanceCard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: screenWidthData(20)),
                        child: Text(
                          "€" + "$currentBalance",
                          style: TextStyle(
                              fontSize: screenWidthData(35),
                              fontFamily: 'MetroBold'),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: screenWidthData(20)),
                          child: Text(
                            "A V A I L A B L E",
                            style: TextStyle(fontSize: screenWidthData(13)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
                height: screenHeightData(60),
                width: screenWidthData(60),
                child: Padding(
                  padding: EdgeInsets.only(right: screenWidthData(20)),
                  child: Image.asset("assets/images/currency.png",
                      fit: BoxFit.contain),
                )),
          ],
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(
              top: screenHeightData(16),
              left: screenWidthData(16),
              right: screenWidthData(16),
            ),
            child: Divider(
              color: Colors.grey,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidthData(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Transactions",
                style: TextStyle(
                    color: Colors.grey, fontSize: screenWidthData(16)),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Transactions()),
                  );
                },
                child: Text(
                  "See More",
                  style: TextStyle(
                      color: Color.fromRGBO(26, 68, 237, 1),
                      fontSize: screenWidthData(15)),
                ),
              )
            ],
          ),
        ),
        Container(
          height: screenHeightData(30),
        ),
        Container(
          margin: EdgeInsets.only(left: screenWidthData(16)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: screenHeightData(40),
                width: screenWidthData(40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: secondaryColor,
                ),
                child: Icon(
                  CupertinoIcons.checkmark_seal,
                  color: Colors.white,
                ),
              ),
              Container(
                width: 150,
                margin: EdgeInsets.only(
                  left: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "$recentTransactionName",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidthData(17),
                        fontFamily: 'MetroBold',
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: true,
                    ),
                    Text("$recentTransactionDate",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: screenWidthData(15),
                        ))
                  ],
                ),
              ),
              Container(
                  // Non-Responsive
                  margin: EdgeInsets.only(left: 70),
                  child: Text("- €" + "$recentTransactionPayment",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'MetroBold')))
            ],
          ),
        ),
      ],
    );
  }

  // Retrieves 'Available' & 'Current' balances
  Future getAccountBalance() async {
    final Uri endpoint = Uri.parse(baseURL + "/api/balance");

    final response =
        await http.get(endpoint, headers: {"Accept": "Application/json"});

    var responseData = jsonDecode(response.body)['accounts'] as List;

    List<Accounts> accountObjects =
        responseData.map((result) => Accounts.fromJson(result)).toList();

    if (response.statusCode == 200) {
      getCurrentFundsSum(accountObjects).then((value) => {
            setState(() {
              currentBalance = value;
            }),
            getRecentTransaction()
          });
    }
  }

  // Retrieves the sum of all account 'current' funds
  Future<int> getCurrentFundsSum(List accountObjects) async {
    return accountObjects.fold<int>(
        0, (sum, account) => sum + account.getOverallCurrentBalance());
  }

  // Recent Transactions
  Future getRecentTransaction() async {
    final Uri endpoint = Uri.parse(baseURL + "/api/transactions");

    final response =
        await http.get(endpoint, headers: {"Accept": "Application/json"});

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
