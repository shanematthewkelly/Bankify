import 'dart:convert';

import 'package:Bankify/components/buttons/primary_button.dart';
import 'package:Bankify/configs/globals.dart';
import 'package:Bankify/configs/screen_sizing.dart';
import 'package:Bankify/screens/auth/login/login.dart';
import 'package:Bankify/screens/home/home.dart';
import 'package:Bankify/screens/plaid/bankSuccessful.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'components/requirements.dart';

class ConnectBank extends StatefulWidget {
  @override
  _ConnectBankState createState() => _ConnectBankState();
}

class _ConnectBankState extends State<ConnectBank> {
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    // hasLinkedBank();
    isUserLoggedIn();
    accountName();
    super.initState();
  }

  // Check if bank has been linked prior
  Future hasLinkedBank() async {
    sharedPreferences = await SharedPreferences.getInstance();
    bool hasLinked = (sharedPreferences.getBool('linked') ?? false);

    if (hasLinked) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Home()));
    } else {
      await sharedPreferences.setBool('linked', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new ConnectBank()));
    }
  }

  // Token Check For App Auth
  Future isUserLoggedIn() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var userToken = sharedPreferences.getString("token");

    setState(() {
      if (userToken == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  // Retrieving the value of our accountName() Future
  // and set its' state
  String username = "";

  _ConnectBankState() {
    accountName().then((value) => setState(() {
          username = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: body(),
      ),
      bottomNavigationBar: bottomButton(),
    );
  }

  Column body() {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidthData(20),
                vertical: screenHeightData(60),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: screenHeightData(100),
                    width: screenWidthData(100),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "SK",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidthData(35),
                            fontFamily: 'MetroBold',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeightData(20),
                    ),
                    child: Text(
                      'Welcome, ' + username + '.',
                      style: TextStyle(
                          fontSize: screenWidthData(36),
                          fontFamily: 'MetroBold',
                          color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Text(
                    "👋",
                    style: TextStyle(
                      fontSize: screenWidthData(35),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenHeightData(50),
                      bottom: screenHeightData(30),
                    ),
                    child: Text(
                        "We will need to request the following permissions from your bank.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: screenWidthData(16),
                            fontFamily: 'MetroMedium',
                            height: 1.3)),
                  ),
                  Requirements(
                    icon: CupertinoIcons.person,
                    title: "Account Details",
                  ),
                  Requirements(
                    icon: CupertinoIcons.cart,
                    title: "Transactions",
                  ),
                  Requirements(
                    icon: CupertinoIcons.checkmark_seal,
                    title: "Account Features",
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container bottomButton() {
    return Container(
      margin: EdgeInsets.only(
        bottom: screenHeightData(25),
        left: screenWidthData(15),
        right: screenWidthData(15),
      ),
      child: PrimaryButton(
        onPress: () {
          initializePlaidLink();
        },
        buttonText: "Link my bank",
      ),
    );
  }

  Future accountName() async {
    sharedPreferences = await SharedPreferences.getInstance();

    // Retrieve the currently logged in user's ID
    final String userId = sharedPreferences.getString("userId");

    final Uri endpoint = Uri.parse(baseURL + "/retrieve/users/" + userId);

    final response =
        await http.get(endpoint, headers: {"Accept": "Application/json"});

    var responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      var username = responseData["userRetrieved"]["name"];

      return await username;
    }
  }

  // Connect to Plaid Backend
  Future initializePlaidLink() async {
    final Uri endpoint = Uri.parse(baseURL + "/api/create_link_token");

    final response =
        await http.post(endpoint, headers: {"Accept": "Application/json"});

    var responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      LinkConfiguration configuration = new LinkTokenConfiguration(
        token: responseData['link_token'],
      );

      PlaidLink _plaidLink = PlaidLink(
        configuration: configuration,
        onSuccess: _onSuccessCallback,
      );

      _plaidLink.open();
    } else {
      return;
    }
  }

  // Bank linked
  Future _onSuccessCallback(
    String publicToken,
    LinkSuccessMetadata metadata,
  ) async {
    final Uri endpoint = Uri.parse(baseURL + "/api/set_access_token");
    sharedPreferences = await SharedPreferences.getInstance();

    // Our public token is sent in the POST request body in order to exchange it
    // For an access token on the server.
    final response = await http.post(endpoint,
        headers: {"Accept": "Application/json"},
        body: {"public_token": publicToken});

    var responseData = jsonDecode(response.body);
    sharedPreferences.setString("access_token", responseData["access_token"]);

    if (response.statusCode == 200) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => BankSuccessful()),
          (Route<dynamic> route) => false);
    }
  }
}
