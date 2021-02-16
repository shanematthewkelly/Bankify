import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class AccountsDetail extends StatefulWidget {
  @override
  _AccountsDetailState createState() => _AccountsDetailState();
}

class _AccountsDetailState extends State<AccountsDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: FutureBuilder(
          future: getCurrentBanks(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              // Wait for resolve
              return Container(
                height: MediaQuery.of(context).size.height / 1,
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
              );
            } else {
              // Return our data
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      snapshot.data[index].accountName != null
                          ? Container(
                              width: 600,
                              padding: EdgeInsets.all(20),
                              margin: EdgeInsets.only(
                                  left: 16, right: 16, bottom: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: Offset(0, 0.2)),
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        CupertinoIcons.creditcard,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        " A C C O U N T",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 18),
                                    child: Text(
                                      snapshot.data[index].accountName,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'MetroBold',
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  // Retrieves user's list of accounts
  Future getCurrentBanks() async {
    final String url =
        "https://6q8uxgokqf.execute-api.us-east-1.amazonaws.com/dev/api/accounts";

    final response =
        await http.get(url, headers: {"Accept": "Application/json"});

    var responseData = jsonDecode(response.body)['accounts'] as List;

    List<AccountInformation> infoData = responseData
        .map((result) => AccountInformation.fromJson(result))
        .toList();

    for (var accounts in responseData) {
      AccountInformation accountInfo = AccountInformation(accounts[infoData]);

      print(infoData.length);
      infoData.add(accountInfo);
    }

    return infoData;
  }
}

class AccountInformation {
  final String accountName;

  AccountInformation(this.accountName);

  factory AccountInformation.fromJson(dynamic json) {
    return AccountInformation(json["name"] as String);
  }

  @override
  String toString() {
    return '${this.accountName}';
  }
}
