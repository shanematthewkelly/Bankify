import 'package:Bankify/components/navbar.dart';
import 'package:Bankify/screens/auth/loginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    //Here we make a call to this anonymous function
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
              ? Container(
                  margin: const EdgeInsets.only(top: 50),

                  //Content in here will later be changed to a component
                  child: Container(
                    height: 250,
                    margin: EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 1.8)),
                      ],
                    ),
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

  //Here we are simply checking whether the user has a token assigned to them or not
  void isUserLoggedIn() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      //Redirect to login screen, user has no token
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }
}
