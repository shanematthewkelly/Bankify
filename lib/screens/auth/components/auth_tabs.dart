import 'package:Bankify/configs/screen_sizing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthTabs extends StatelessWidget {
  const AuthTabs({
    Key key,
    @required this.press,
  }) : super(key: key);

  final ValueChanged<int> press;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSizing.screenWidth * 0.80,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DefaultTabController(
        length: 2,
        child: TabBar(
          indicator: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          indicatorColor: Colors.white,
          labelStyle: TextStyle(
              fontSize: screenWidthData(16), fontWeight: FontWeight.bold),
          labelColor: Colors.black,
          unselectedLabelColor: Colors.white,
          onTap: press,
          tabs: [
            Tab(
              text: "Sign In",
            ),
            Tab(text: "Sign Up")
          ],
        ),
      ),
    );
  }
}
