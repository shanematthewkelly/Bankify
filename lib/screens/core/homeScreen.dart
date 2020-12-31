import 'dart:convert';

import 'package:Bankify/components/navbar.dart';
import 'package:Bankify/screens/auth/loginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum NavigationIcons { Home, Payments, Rewards, Account, Support }

class _HomeScreenState extends State<HomeScreen> {
  NavigationIcons navigationIcons = NavigationIcons.Home;

  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    // Here we make a call to this anonymous function
    isUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //If statement that checks which screen is loaded and reacts to change
          //Home Screen Content
          navigationIcons == NavigationIcons.Home
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.height / 1,
                        height: 250,
                        margin: EdgeInsets.only(left: 15, right: 15, top: 80),
                        padding: EdgeInsets.only(top: 30, left: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset: Offset(0, 0.2)),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "€250",
                                    style: TextStyle(
                                        fontSize: 30, fontFamily: 'MetroBold'),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(left: 8),
                                    child: Icon(
                                      CupertinoIcons.chevron_down,
                                      size: 22,
                                    )),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5, top: 4),
                              child: Text(
                                "B A L A N C E",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await getAccountBalance();
                              },
                              child: Container(
                                color: Colors.blue,
                                margin: EdgeInsets.only(left: 5, top: 20),
                                padding: EdgeInsets.all(18),
                                child: Text(
                                  "FETCH",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),

          //Payments Screen Content
          navigationIcons == NavigationIcons.Payments
              ? Center(
                  child: Text(
                    "Payment Screen",
                    style: TextStyle(fontSize: 17),
                  ),
                )
              : Container(),

          //Rewards Screen Content
          navigationIcons == NavigationIcons.Rewards
              ? Center(
                  child: Text(
                    "Rewards Screen",
                    style: TextStyle(fontSize: 17),
                  ),
                )
              : Container(),

          //Account Screen Content
          navigationIcons == NavigationIcons.Account
              ? Center(
                  child: Text(
                    "Account Screen",
                    style: TextStyle(fontSize: 17),
                  ),
                )
              : Container(),

          //Support Screen Content
          navigationIcons == NavigationIcons.Support
              ? Center(
                  child: Text(
                    "Support Screen",
                    style: TextStyle(fontSize: 17),
                  ),
                )
              : Container(),

          //Navbar
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3.65,
                      blurRadius: 7,
                      offset: Offset(0, 3)),
                ],
              ),
              padding:
                  EdgeInsets.only(left: 25, right: 25, bottom: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //Importing the Navbar Component and everything within its' constructor
                  //MenuItem - Home
                  Navbar(
                      onClickListener: () {
                        setState(() {
                          navigationIcons = NavigationIcons.Home;
                        });
                      },
                      navigationalIcons: navigationIcons == NavigationIcons.Home
                          ? true
                          : false,
                      menuItemIcon: CupertinoIcons.house_alt,
                      menuItemText: "Home"),

                  //MenuItem - Payments
                  Navbar(
                      onClickListener: () {
                        setState(() {
                          navigationIcons = NavigationIcons.Payments;
                        });
                      },
                      navigationalIcons:
                          navigationIcons == NavigationIcons.Payments
                              ? true
                              : false,
                      menuItemIcon:
                          CupertinoIcons.arrow_right_arrow_left_square,
                      menuItemText: "Payments"),

                  //MenuItem - Offers
                  Navbar(
                      onClickListener: () {
                        setState(() {
                          navigationIcons = NavigationIcons.Rewards;
                        });
                      },
                      navigationalIcons:
                          navigationIcons == NavigationIcons.Rewards
                              ? true
                              : false,
                      menuItemIcon: CupertinoIcons.gift,
                      menuItemText: "Rewards"),

                  //MenuItem - Account
                  Navbar(
                      onClickListener: () {
                        setState(() {
                          navigationIcons = NavigationIcons.Account;
                        });
                      },
                      navigationalIcons:
                          navigationIcons == NavigationIcons.Account
                              ? true
                              : false,
                      menuItemIcon: CupertinoIcons.person_alt_circle,
                      menuItemText: "Account"),

                  //MenuItem - Support
                  Navbar(
                      onClickListener: () {
                        setState(() {
                          navigationIcons = NavigationIcons.Support;
                        });
                      },
                      navigationalIcons:
                          navigationIcons == NavigationIcons.Support
                              ? true
                              : false,
                      menuItemIcon: CupertinoIcons.chat_bubble_text,
                      menuItemText: "Support"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future getAccountBalance() async {
    final String url =
        "https://q80qzg1rgh.execute-api.us-east-1.amazonaws.com/dev/api/balance";

    final response =
        await http.get(url, headers: {"Accept": "Application/json"});

    var responseData = jsonDecode(response.body)['accounts'] as List;

    List<Accounts> accountObjects =
        responseData.map((result) => Accounts.fromJson(result)).toList();

    if (response.statusCode == 200) {
      // TODO: Change from printing the values, to adding them together instead, as a 'total' balance.
      print(accountObjects);
    } else {
      print("There was an issue getting the correct response code");
    }
  }

  // Here we are simply checking whether the user has a token assigned to them or not
  void isUserLoggedIn() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      if (sharedPreferences.getString("token") == null) {
        // Redirect to login screen, user has no token
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }
}

class Accounts {
  int currentBalance, availableBalance;

  Accounts(this.currentBalance, this.availableBalance);

  factory Accounts.fromJson(dynamic json) {
    return Accounts(
        // Parsing JSON
        json["balances"]["current"].truncate(),
        json["balances"]["available"] as int);
  }

  @override
  String toString() {
    return '{ ${this.currentBalance}, ${this.availableBalance} }';
  }
}
