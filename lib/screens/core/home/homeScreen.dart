import 'dart:convert';

import 'package:Bankify/components/navbar.dart';
import 'package:Bankify/screens/auth/loginScreen.dart';
import 'package:Bankify/screens/core/home/tabs/accounts.dart';
import 'package:Bankify/screens/core/home/tabs/balance.dart';
import 'package:Bankify/screens/core/home/tabs/linked.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum NavigationIcons { Home, Transactions, Vaults, Account, Support }

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  SharedPreferences sharedPreferences;
  NavigationIcons navigationIcons = NavigationIcons.Home;

  @override
  void initState() {
    super.initState();
    // isUserLoggedIn();
    _tabController = TabController(vsync: this, length: 3);
  }

  void isUserLoggedIn() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      if (sharedPreferences.getString("token") == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 244, 244, 1),
      body: Container(
        child: Column(
          children: <Widget>[
            navigationIcons == NavigationIcons.Home
                ? Container(
                    height: 50,
                    padding: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.height / 1,
                    margin: EdgeInsets.only(top: 60, left: 20),
                    child: TabBar(
                      controller: _tabController,
                      tabs: [
                        Container(
                          width: 70,
                          child: Tab(
                            text: "Balance",
                          ),
                        ),
                        Container(
                          width: 70,
                          child: Tab(
                            text: "Accounts",
                          ),
                        ),
                        Container(
                          width: 70,
                          child: Tab(
                            text: "Linked",
                          ),
                        ),
                      ],
                      unselectedLabelColor: Colors.grey,
                      labelColor: Colors.black,
                      isScrollable: true,
                      indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  )
                : Container(),

            navigationIcons == NavigationIcons.Home
                ? SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.height / 1,
                      // ISSUE: Change this
                      height: 696,
                      child: Container(
                        child: TabBarView(
                          controller: _tabController,
                          children: [Balance(), AllAccounts(), Linked()],
                        ),
                      ),
                    ),
                  )
                : Container(),

            // Transaction Screen Content
            navigationIcons == NavigationIcons.Transactions
                ? Center(
                    child: Text(
                      "Transaction Screen",
                      style: TextStyle(fontSize: 17),
                    ),
                  )
                : Container(),

            // Vaults Screen Content
            navigationIcons == NavigationIcons.Vaults
                ? Center(
                    child: Text(
                      "Vaults Screen",
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
                        navigationalIcons:
                            navigationIcons == NavigationIcons.Home
                                ? true
                                : false,
                        menuItemIcon: CupertinoIcons.house_alt,
                        menuItemText: "Home"),

                    //MenuItem - Payments
                    Navbar(
                        onClickListener: () {
                          setState(() {
                            navigationIcons = NavigationIcons.Transactions;
                          });
                        },
                        navigationalIcons:
                            navigationIcons == NavigationIcons.Transactions
                                ? true
                                : false,
                        menuItemIcon:
                            CupertinoIcons.arrow_right_arrow_left_square,
                        menuItemText: "Transactions"),

                    //MenuItem - Offers
                    Navbar(
                        onClickListener: () {
                          setState(() {
                            navigationIcons = NavigationIcons.Vaults;
                          });
                        },
                        navigationalIcons:
                            navigationIcons == NavigationIcons.Vaults
                                ? true
                                : false,
                        menuItemIcon: CupertinoIcons.lock_shield,
                        menuItemText: "Vaults"),

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
      ),
    );
  }

  // Retrieves 'Available' & 'Current' balances
  Future getAccountBalance() async {
    final String url =
        "https://q80qzg1rgh.execute-api.us-east-1.amazonaws.com/dev/api/balance";

    final response =
        await http.get(url, headers: {"Accept": "Application/json"});

    var responseData = jsonDecode(response.body)['accounts'] as List;

    List<Accounts> accountObjects =
        responseData.map((result) => Accounts.fromJson(result)).toList();

    if (response.statusCode == 200) {
      getCurrentFundsSum(accountObjects);
    }
  }

  // Retrieves the sum of all account 'current' funds
  Future getCurrentFundsSum(List accountObjects) async {
    var sum = 0;
    print(accountObjects);

    // Error: Unhandled Exception: type 'Accounts' is not a subtype of type 'num'
    accountObjects.forEach((e) => sum += e);
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
}
