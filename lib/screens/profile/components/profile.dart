import 'dart:convert';

import 'package:Bankify/components/appbars/appbar.dart';
import 'package:Bankify/components/widgets/appbar_icon_widget.dart';
import 'package:Bankify/configs/globals.dart';
import 'package:Bankify/configs/screen_sizing.dart';
import 'package:Bankify/screens/auth/login/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'details.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  SharedPreferences sharedPreferences;

  String username, email, phone = "";

  _ProfileScreenState() {
    accountDetails().then((value) => setState(() {
          username = value["name"];
          email = value["email"];
          phone = value["phone"];
          print(username);
        }));
  }

  @override
  void initState() {
    accountDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: canvasColor,
      appBar: buildAppbar(),
      body: profileScreenUI(context),
    );
  }

  PrimaryAppbar buildAppbar() => PrimaryAppbar(
        title: Text(
          username != null ? username : "@Username",
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontFamily: 'MetroBold',
          ),
        ),
        widgets: <Widget>[
          AppbarRightIcon(
            onPressed: () {
              print("CLICKED");
            },
            icon: CupertinoIcons.info,
          )
        ],
        backArrow: IconThemeData(
          color: Colors.black,
        ),
      );

  Container profileScreenUI(context) {
    return Container(
        child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidthData(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: screenHeightData(40),
                bottom: screenHeightData(15),
                left: screenWidthData(15),
              ),
              child: Text(
                "Profile Details",
                style: TextStyle(color: Colors.grey, fontSize: 16),
                textAlign: TextAlign.left,
              ),
            ),
            ProfileDetail(
              icon: CupertinoIcons.building_2_fill,
              profileInfo: username != null ? username : "Username",
            ),
            ProfileDetail(
              icon: CupertinoIcons.envelope_badge,
              profileInfo: email != null ? email : "Email",
            ),
            ProfileDetail(
              icon: CupertinoIcons.device_phone_portrait,
              profileInfo: phone != null ? phone : "Phone",
            ),
            Container(
              height: screenHeightData(70),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: screenHeightData(15),
                left: screenWidthData(25),
              ),
              child: Text(
                "Actions",
                style: TextStyle(color: Colors.grey, fontSize: 16),
                textAlign: TextAlign.left,
              ),
            ),
            ProfileDetail(
              icon: CupertinoIcons.heart_slash,
              profileInfo: "Logout",
              onPress: () async {
                print("Clicked");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginBody(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ));
  }

  Future accountDetails() async {
    sharedPreferences = await SharedPreferences.getInstance();

    // Retrieve the currently logged in user's ID
    final String userId = sharedPreferences.getString("userId");

    final Uri endpoint = Uri.parse(baseURL + "/retrieve/users/" + userId);

    final response =
        await http.get(endpoint, headers: {"Accept": "Application/json"});

    var responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      var userDetails = responseData["userRetrieved"];

      return await userDetails;
    }
  }
}
