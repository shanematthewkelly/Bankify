import 'package:Bankify/components/appbars/tabs_appbar.dart';
import 'package:Bankify/components/widgets/appbar_icon_widget.dart';
import 'package:Bankify/configs/globals.dart';
import 'package:Bankify/configs/screen_sizing.dart';
import 'package:Bankify/screens/auth/login/login.dart';
import 'package:Bankify/screens/home/tabs/accounts/accounts.dart';
import 'package:Bankify/screens/home/tabs/balance/balance.dart';
import 'package:Bankify/screens/home/tabs/linked/linked.dart';
import 'package:Bankify/screens/profile/body.dart';
import 'package:Bankify/screens/transactions/transactions/transactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int _currentTab = 0;
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    isUserLoggedIn();
  }

  // Auth Check
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

  // Tabs
  final navigationTabs = [
    Container(
      child: TabBarView(
        children: <Widget>[
          Balance(),
          Accounts(),
          Linked(),
        ],
      ),
    ),
    Transactions(),
    ProfileBody(),
  ];

  // Body
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: canvasColor,
      statusBarColor: canvasColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: canvasColor,
        extendBody: true,
        appBar: _currentTab == 0 ? buildAppBar() : defaultAppbar(),
        body: navigationTabs[_currentTab],
        bottomNavigationBar: bottomNav(),
      ),
    );
  }

  AppBar defaultAppbar() => AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
        elevation: 0,
      );

  Container bottomNav() => Container(
        margin: EdgeInsets.only(
          left: screenWidthData(60),
          right: screenWidthData(60),
          bottom: screenHeightData(12),
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: shadowOffset,
              blurRadius: shadowBlur,
              color: shadowColor,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(80),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
            showSelectedLabels: false,
            elevation: 0,
            showUnselectedLabels: false,
            onTap: (index) {
              setState(() {
                _currentTab = index;
              });
            },
            currentIndex: _currentTab,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.house_alt,
                    color: Colors.black,
                  ),
                  activeIcon: Icon(
                    CupertinoIcons.house_alt,
                    color: Color.fromRGBO(26, 68, 237, 1),
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.arrow_right_arrow_left_square,
                    color: Colors.black,
                  ),
                  activeIcon: Icon(
                    CupertinoIcons.arrow_right_arrow_left_square,
                    color: Color.fromRGBO(26, 68, 237, 1),
                  ),
                  label: "Transactions"),
              BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.person_alt_circle,
                    color: Colors.black,
                  ),
                  activeIcon: Icon(
                    CupertinoIcons.person_alt_circle,
                    color: Color.fromRGBO(26, 68, 237, 1),
                  ),
                  label: "Profile"),
            ],
          ),
        ),
      );

  // Custom Appbar - Home
  TabsAppbar buildAppBar() => TabsAppbar(
        profile: Padding(
          padding: EdgeInsets.only(left: screenWidthData(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/profile.png",
                fit: BoxFit.contain,
                width: screenWidthData(56),
                height: screenHeightData(56),
              ),
            ],
          ),
        ),
        widgets: <Widget>[
          AppbarRightIcon(
            onPressed: () async {
              // Do Something
            },
            icon: CupertinoIcons.bell,
          )
        ],
        bottomTabs: PreferredSize(
            child: Container(
              color: Colors.transparent,
              height: screenHeightData(50.0),
              padding: EdgeInsets.only(
                  bottom: screenHeightData(8),
                  top: screenHeightData(8),
                  left: screenWidthData(15)),
              width: double.infinity,
              child: TabBar(
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
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 7,
                        offset: Offset(0, 0.5)),
                  ],
                ),
              ),
            ),
            preferredSize: Size.fromHeight(50.0)),
      );
}
