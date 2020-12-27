import 'dart:convert';

import 'package:Bankify/screens/core/homeScreen.dart';
import 'package:Bankify/screens/utils/bankSuccessful.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:http/http.dart' as http;

class ConnectBank extends StatefulWidget {
  @override
  _ConnectBankState createState() => _ConnectBankState();
}

class _ConnectBankState extends State<ConnectBank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: TopBackgroundClipper(),
              child: Container(
                height: 280,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xFF3383CD), Color(0xFF11249F)]),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 90, left: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome, Shane.',
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'MetroBold',
                            color: Colors.white),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40),
                  height: 180,
                  child: Lottie.asset(
                    'assets/lottie/connect.json',
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    'Link with us.',
                    style: TextStyle(
                        fontSize: 26,
                        fontFamily: 'MetroBold',
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Text(
                    'We will ask you to link your primary bank account now. Not to worry, you can always link more later.',
                    style: TextStyle(fontSize: 16, color: Colors.black26),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          await initializePlaidLink();
        },
        child: Container(
          margin: EdgeInsets.all(15),
          height: 50,
          decoration: BoxDecoration(
            color: Color.fromRGBO(36, 97, 227, .8),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(143, 148, 251, .3),
                  blurRadius: 25.0,
                  offset: Offset(0, 7))
            ],
          ),
          child: Center(
            child: Text(
              "L I N K",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
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
        onSuccess: _onSuccessCallback,
      );

      _plaidLink.open();
    } else {
      // TODO: Handle the error accordingly
    }
  }

  //Callbacks
  void _onSuccessCallback(String publicToken, LinkSuccessMetadata metadata) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => BankSuccessful()),
        (Route<dynamic> route) => false);
  }
}

class TopBackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var customPath = Path();
    customPath.lineTo(0.0, size.height - 80);
    customPath.lineTo(size.width, size.height);
    customPath.lineTo(size.width, 0.0);
    customPath.close();

    return customPath;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
