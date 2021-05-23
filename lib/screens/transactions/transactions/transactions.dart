import 'dart:convert';
import 'package:Bankify/components/appbars/appbar.dart';
import 'package:Bankify/components/widgets/appbar_icon_widget.dart';
import 'package:Bankify/configs/globals.dart';
import 'package:Bankify/configs/screen_sizing.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'components/transaction_info.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: canvasColor,
        appBar: buildAppbar(),
        body: transactionUI(context));
  }

  Container transactionUI(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(
                    top: screenHeightData(30),
                    left: screenWidthData(25),
                  ),
                  child: GestureDetector(
                    onTap: () => filterTransactionsModal(),
                    child: Text(
                      "All Transactions",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height / 1.45,
            width: double.infinity,
            margin: EdgeInsets.only(
              left: 15,
              right: 15,
              top: 16,
            ),
            padding: EdgeInsets.only(top: 25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: shadowBlur,
                  offset: shadowOffset,
                ),
              ],
            ),
            child: FutureBuilder(
                future: getTransactions(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Color.fromRGBO(26, 68, 237, 1)))
                          ],
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                snapshot.data[index].transactionName != null
                                    ? Container(
                                        margin: EdgeInsets.only(bottom: 40),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 12),
                                              child: Container(
                                                height: 42,
                                                width: 42,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: secondaryColor,
                                                ),
                                                child: Icon(
                                                  CupertinoIcons.checkmark_seal,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 2, left: 8),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    width: 200,
                                                    child: Text(
                                                      snapshot.data[index]
                                                          .transactionName,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontFamily:
                                                              'MetroBold'),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      softWrap: false,
                                                    ),
                                                  ),
                                                  Text(
                                                      snapshot.data[index]
                                                          .transactionDate,
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 13,
                                                      ))
                                                ],
                                              ),
                                            ),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(left: 38),
                                                child: Text(
                                                    "- €" +
                                                        snapshot.data[index]
                                                            .transactionPayment
                                                            .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontFamily:
                                                            'MetroBold')))
                                          ],
                                        ),
                                      )
                                    : Container()
                              ]);
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }

  PrimaryAppbar buildAppbar() => PrimaryAppbar(
        title: Text(
          "Transactions",
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontFamily: 'MetroBold',
          ),
        ),
        widgets: <Widget>[
          AppbarRightIcon(
            onPressed: () {
              print("CLICKED");
              filterTransactionsModal();
            },
            icon: CupertinoIcons.list_bullet_indent,
          )
        ],
        backArrow: IconThemeData(
          color: Colors.black,
        ),
      );

  void filterTransactionsModal() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            height: MediaQuery.of(context).size.height * .25,
            child: Center(
              child: Container(
                width: 180,
                height: 40,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      blurRadius: shadowBlur,
                      offset: shadowOffset,
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    "Filter by date.",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'MetroBold',
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future getTransactions() async {
    final Uri endpoint = Uri.parse(baseURL + "/api/transactions");

    final response =
        await http.get(endpoint, headers: {"Accept": "Application/json"});

    var transactionData = jsonDecode(response.body)["transactions"] as List;

    List<TransactionInformation> infoData = transactionData
        .map((result) => TransactionInformation.fromJson(result))
        .toList();

    if (response.statusCode == 200) {
      for (var transactions in transactionData) {
        TransactionInformation accountInfo = TransactionInformation(
            transactions[infoData],
            transactions[infoData],
            transactions[infoData]);

        infoData.add(accountInfo);
      }

      return infoData;
    }
  }
}
