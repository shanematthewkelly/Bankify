import 'package:Bankify/components/appbars/tabs_appbar.dart';
import 'package:Bankify/configs/screen_sizing.dart';
import 'package:Bankify/screens/auth/login/login.dart';
import 'package:Bankify/screens/home/tabs/accounts/accounts.dart';
import 'package:Bankify/screens/home/tabs/balance/balance.dart';
import 'package:Bankify/screens/home/tabs/linked/linked.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

enum NavigationIcons { Home, Transactions, Vaults, Support }

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int _currentTab = 0;
  NavigationIcons navigationIcons = NavigationIcons.Home;
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
    Center(child: Text("Transactions")),
    Center(child: Text("Vaults")),
    Center(child: Text("Support")),
  ];

  // Body
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: buildAppBar(),
        body: navigationTabs[_currentTab],
        bottomNavigationBar: bottomNav(),
      ),
    );
  }

  // Bottom Navigation
  BottomNavigationBar bottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      showSelectedLabels: false,
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
              CupertinoIcons.lock_shield,
              color: Colors.black,
            ),
            activeIcon: Icon(
              CupertinoIcons.lock_shield,
              color: Color.fromRGBO(26, 68, 237, 1),
            ),
            label: "Vaults"),
        BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.person_alt_circle,
              color: Colors.black,
            ),
            activeIcon: Icon(
              CupertinoIcons.person_alt_circle,
              color: Color.fromRGBO(26, 68, 237, 1),
            ),
            label: "Support"),
      ],
    );
  }

  // Custom Appbar - Home
  TabsAppbar buildAppBar() {
    return TabsAppbar(
      profile: Padding(
        padding: EdgeInsets.only(left: screenWidthData(15)),
        child: Image.asset(
          "assets/images/profile.png",
          fit: BoxFit.contain,
          width: screenWidthData(40),
          height: screenHeightData(40),
        ),
      ),
      widgets: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: screenWidthData(15)),
          child: Icon(
            CupertinoIcons.bell,
            size: 28,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: screenWidthData(15)),
          child: Icon(
            CupertinoIcons.info_circle,
            size: 28,
            color: Colors.black,
          ),
        ),
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
}
