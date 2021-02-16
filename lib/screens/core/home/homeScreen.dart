import 'package:Bankify/components/navbar.dart';
import 'package:Bankify/screens/auth/loginScreen.dart';
import 'package:Bankify/screens/core/home/tabs/accounts.dart';
import 'package:Bankify/screens/core/home/tabs/balance.dart';
import 'package:Bankify/screens/core/home/tabs/linked.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              color: Colors.white,
              child: Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  navigationIcons == NavigationIcons.Home
                      ? ClipPath(
                          clipper: TopBackgroundClipper(),
                          child: Container(
                            height: 350,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(26, 68, 237, 1),
                            ),
                          ),
                        )
                      : Container(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      navigationIcons == NavigationIcons.Home
                          ? Container(
                              margin: EdgeInsets.only(top: 55, left: 30),
                              child: Image.asset(
                                "assets/images/profile.png",
                                width: 50,
                                height: 50,
                                fit: BoxFit.contain,
                              ),
                            )
                          : Container(),
                      Container(
                        // height: MediaQuery.of(context).size.height / 1,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              navigationIcons == NavigationIcons.Home
                                  ? Container(
                                      height: 50,
                                      padding: EdgeInsets.only(bottom: 20),
                                      width:
                                          MediaQuery.of(context).size.height /
                                              1,
                                      margin:
                                          EdgeInsets.only(top: 25, left: 20),
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
                                        unselectedLabelColor: Colors.white,
                                        labelColor: Colors.black,
                                        isScrollable: true,
                                        indicator: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                      ),
                                    )
                                  : Container(),
                              Center(
                                child: Column(
                                  children: <Widget>[
                                    navigationIcons == NavigationIcons.Home
                                        ? Container(
                                            color: Colors.transparent,
                                            // ISSUE: Change this
                                            height: 686,
                                            child: TabBarView(
                                              controller: _tabController,
                                              children: <Widget>[
                                                // Fragments - Tabs
                                                BalanceFragment(),
                                                AccountsFragment(),
                                                LinkedFragement()
                                              ],
                                            ),
                                          )
                                        : Container(),

                                    // // Transaction Screen Content
                                    navigationIcons ==
                                            NavigationIcons.Transactions
                                        ? Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                1,
                                            child: Center(
                                              child: Text(
                                                "Transaction Screen",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontFamily: 'MetroBold'),
                                              ),
                                            ),
                                          )
                                        : Container(),

                                    // Vaults Screen Content
                                    navigationIcons == NavigationIcons.Vaults
                                        ? Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                1,
                                            child: Center(
                                              child: Text(
                                                "Vaults Screen",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontFamily: 'MetroBold'),
                                              ),
                                            ),
                                          )
                                        : Container(),

                                    //Account Screen Content
                                    navigationIcons == NavigationIcons.Account
                                        ? Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                1,
                                            child: Center(
                                              child: Text(
                                                "Account Screen",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontFamily: 'MetroBold'),
                                              ),
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Bottom Stuff
                  Positioned(
                    bottom: 0,
                    right: 0,
                    width: MediaQuery.of(context).size.width / 1,
                    child: Container(
                      color: Colors.transparent,
                      //Navbar
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
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
                          padding: EdgeInsets.only(
                              left: 25, right: 25, bottom: 10, top: 10),
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
                                      navigationIcons =
                                          NavigationIcons.Transactions;
                                    });
                                  },
                                  navigationalIcons: navigationIcons ==
                                          NavigationIcons.Transactions
                                      ? true
                                      : false,
                                  menuItemIcon: CupertinoIcons
                                      .arrow_right_arrow_left_square,
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
                                  menuItemIcon:
                                      CupertinoIcons.person_alt_circle,
                                  menuItemText: "Account"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
