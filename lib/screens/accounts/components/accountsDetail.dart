import 'dart:convert';

import 'package:Bankify/components/appbars/appbar.dart';
import 'package:Bankify/components/widgets/appbar_icon_widget.dart';
import 'package:Bankify/configs/globals.dart';
import 'package:Bankify/configs/screen_sizing.dart';
import 'package:Bankify/screens/accounts/components/retrieveAccounts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'accountCardClipper.dart';

class AccountsDetail extends StatefulWidget {
  @override
  _AccountsDetailState createState() => _AccountsDetailState();
}

class _AccountsDetailState extends State<AccountsDetail> {
  @override
  void initState() {
    getCurrentBanks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: canvasColor,
      appBar: buildAppbar(),
      body: accountsList(),
    );
  }

  PrimaryAppbar buildAppbar() => PrimaryAppbar(
        title: Text(
          "Accounts",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontFamily: 'MetroBold',
          ),
        ),
        widgets: <Widget>[
          AppbarRightIcon(
            onPressed: () => null,
            icon: CupertinoIcons.search,
          ),
        ],
        backArrow: IconThemeData(
          color: Colors.black,
        ),
      );

  Container accountsList() {
    return Container(
      child: FutureBuilder(
        future: getCurrentBanks(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            // Wait for resolve
            return Container(
              height: MediaQuery.of(context).size.height / 1,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Color.fromRGBO(26, 68, 237, 1)))
                  ],
                ),
              ),
            );
          } else {
            // Return our data
            return ListView.builder(
              padding: EdgeInsets.only(top: screenHeightData(40)),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    snapshot.data[index].accountName != null
                        ? Container(
                            width: double.infinity,
                            height: 200,
                            margin: EdgeInsets.only(
                              left: 16,
                              right: 16,
                              bottom: 18,
                              top: 18,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: shadowColor,
                                  blurRadius: shadowBlur,
                                  offset: shadowOffset,
                                ),
                              ],
                            ),
                            child: Stack(
                              children: <Widget>[
                                ClipPath(
                                  clipper: AccountCardClipper(),
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(15),
                                              bottomRight: Radius.circular(15),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        CupertinoIcons.link_circle_fill,
                                        size: 40,
                                        color: primaryColor,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: screenHeightData(12),
                                        ),
                                        child: Text(
                                          snapshot.data[index].accountName,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'MetroBold',
                                            fontSize: screenWidthData(20),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: screenHeightData(5),
                                        ),
                                        child: Text(
                                          snapshot.data[index].accountType
                                              .toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: screenWidthData(12),
                                            letterSpacing: 4,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  left: 20.0,
                                  bottom: 20.0,
                                  child: Text(
                                    "€350",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'MetroBold',
                                      fontSize: screenWidthData(25),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  // Retrieves user's list of accounts
  Future getCurrentBanks() async {
    final Uri endpoint = Uri.parse(baseURL + "/api/accounts");

    final response =
        await http.get(endpoint, headers: {"Accept": "Application/json"});

    var responseData = jsonDecode(response.body)['accounts'] as List;

    List<AccountInformation> infoData = responseData
        .map((result) => AccountInformation.fromJson(result))
        .toList();

    for (var accounts in responseData) {
      AccountInformation accountInfo = AccountInformation(
        accounts[infoData],
        accounts[infoData],
      );

      infoData.add(accountInfo);
    }

    return infoData;
  }
}
