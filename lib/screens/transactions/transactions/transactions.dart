import 'dart:convert';
import 'package:Bankify/configs/globals.dart';
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
    return Container(
      height: MediaQuery.of(context).size.height / 1,
      child: Scaffold(
        body: Container(
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height / 1,
                width: MediaQuery.of(context).size.width / 1,
                child: ListView(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(top: 40, left: 23),
                        color: Colors.transparent,
                        child: Text(
                          "Transactions.",
                          style:
                              TextStyle(fontSize: 30, fontFamily: 'MetroBold'),
                        ),
                      ),
                    ),
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.height / 1,
                      margin: EdgeInsets.only(left: 15, right: 15, top: 40),
                      padding: EdgeInsets.only(top: 35),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: <Widget>[
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 18),
                                          child: Text(
                                            "€1850",
                                            style: TextStyle(
                                                fontSize: 34,
                                                fontFamily: 'MetroBold'),
                                          ),
                                        ),
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, top: 4),
                                            child: Text(
                                              "Royal Bank of Scotland",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      191, 191, 191, 1),
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                  height: 58,
                                  width: 58,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 15, bottom: 5),
                                    child: Image.asset(
                                        "assets/images/currency.png",
                                        fit: BoxFit.contain),
                                  )),
                            ],
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () async {
                                    // ToDo: Change Bank Function
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 18, top: 40),
                                    height: 42,
                                    width: 140,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(26, 68, 237, 1),
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Color.fromRGBO(26, 68, 237, .3),
                                            blurRadius: 25.0,
                                            offset: Offset(0, 7))
                                      ],
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 8, bottom: 3),
                                          child: Icon(
                                            CupertinoIcons.info_circle,
                                            color: Colors.white,
                                            size: 28,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(left: 6, top: 2),
                                          child: Text(
                                            "Change",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontFamily: 'MetroBold'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.only(top: 50, left: 25),
                            child: Text(
                              "All Transactions",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 680,
                      width: MediaQuery.of(context).size.height / 1,
                      margin: EdgeInsets.only(
                          left: 15, right: 15, top: 16, bottom: 130),
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
                      child: FutureBuilder(
                          future: getTransactions(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
                              return Container(
                                margin: EdgeInsets.only(top: 50),
                                child: Center(
                                  child: Column(
                                    children: <Widget>[
                                      CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<
                                                  Color>(
                                              Color.fromRGBO(26, 68, 237, 1)))
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          snapshot.data[index]
                                                      .transactionName !=
                                                  null
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 40),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 12),
                                                        child: Container(
                                                          height: 42,
                                                          width: 42,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            color:
                                                                Color.fromRGBO(
                                                                    26,
                                                                    68,
                                                                    237,
                                                                    1),
                                                          ),
                                                          child: Icon(
                                                            Icons
                                                                .repeat_rounded,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 2, left: 8),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Container(
                                                              width: 200,
                                                              child: Text(
                                                                snapshot
                                                                    .data[index]
                                                                    .transactionName,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        15,
                                                                    fontFamily:
                                                                        'MetroBold'),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                                softWrap: false,
                                                              ),
                                                            ),
                                                            Text(
                                                                snapshot
                                                                    .data[index]
                                                                    .transactionDate,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 13,
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 38),
                                                          child: Text(
                                                              "- €" +
                                                                  snapshot
                                                                      .data[
                                                                          index]
                                                                      .transactionPayment
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
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
              )
            ],
          ),
        ),
        floatingActionButton: Stack(
          children: <Widget>[
            Positioned(
              left: 42,
              bottom: 60,
              child: GestureDetector(
                onTap: () async {
                  filterTransactionsModal();
                },
                child: Container(
                  height: 40,
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 0.8)),
                    ],
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/filter.png",
                          width: 25,
                          height: 25,
                          fit: BoxFit.contain,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text("Manage",
                              style: TextStyle(
                                  fontSize: 16, fontFamily: 'MetroBold')),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void filterTransactionsModal() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
            height: MediaQuery.of(context).size.height * .45,
            child: Center(
              child: Text(
                "Filter Modal.",
                style: TextStyle(fontSize: 20, fontFamily: 'MetroBold'),
              ),
            ),
          );
        });
  }

  Future getTransactions() async {
    final String url = baseURL + "/api/transactions";

    final response =
        await http.get(url, headers: {"Accept": "Application/json"});

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
