import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllAccounts extends StatefulWidget {
  @override
  _AllAccountsState createState() => _AllAccountsState();
}

class _AllAccountsState extends State<AllAccounts> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 244, 244, 1),
      body: Container(
        child: FutureBuilder(
          future: getCurrentBanks(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              // Wait for resolve
              return Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Text("Loading...")],
                  ),
                ),
              );
            } else {
              // Return our data
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshot.data[index].accountName ?? ''),
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
        "https://q80qzg1rgh.execute-api.us-east-1.amazonaws.com/dev/api/accounts";

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
    return AccountInformation(json["official_name"] as String);
  }

  @override
  String toString() {
    return '${this.accountName}';
  }
}
