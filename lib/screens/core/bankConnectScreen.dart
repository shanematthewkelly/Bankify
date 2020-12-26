import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ConnectBank extends StatefulWidget {
  @override
  _ConnectBankState createState() => _ConnectBankState();
}

class _ConnectBankState extends State<ConnectBank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: 50,
                  left: 25,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  // Run function responsible for initializing Plaid Link
                  initializePlaidLink();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(14, 135, 235, 1),
                  ),
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "LINK YOUR BANK",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            letterSpacing: 5),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Icon(
                          CupertinoIcons.arrowshape_turn_up_right,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Connect to Plaid Backend
  Future initializePlaidLink() async {
    final String url =
        "https://q80qzg1rgh.execute-api.us-east-1.amazonaws.com/dev/api/create_link_token";

    final response =
        await http.post(url, headers: {"Accept": "Application/json"});

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      LinkConfiguration configuration = LinkConfiguration(
        linkToken: responseData['link_token'],
      );

      PlaidLink _plaidLink = PlaidLink(
        configuration: configuration,
      );

      _plaidLink.open();
    } else {
      // TODO: Handle the error accordingly
    }
  }
}
