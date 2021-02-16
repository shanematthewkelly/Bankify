import 'package:Bankify/screens/core/accountsDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountsFragment extends StatefulWidget {
  @override
  _AccountsFragmentState createState() => _AccountsFragmentState();
}

class _AccountsFragmentState extends State<AccountsFragment> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.height / 1,
              margin: EdgeInsets.only(left: 15, right: 15, top: 0),
              padding: EdgeInsets.only(top: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 0.5)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 70,
                    width: 70,
                    margin: EdgeInsets.only(left: 14),
                    child: Image.asset("assets/images/accounts-icon.png",
                        fit: BoxFit.contain),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 18),
                                child: Text(
                                  "Get More\nFrom Your Accounts.",
                                  style: TextStyle(
                                      fontSize: 28, fontFamily: 'MetroBold'),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 18, top: 10),
                                child: Text(
                                  "Dive in and explore more about our account types. Your accounts are private and safe with us.",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromRGBO(191, 191, 191, 1)),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 30),
                                alignment: Alignment.centerRight,
                                height: 65,
                                width: MediaQuery.of(context).size.height / 1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(15)),
                                  color: Color.fromRGBO(26, 68, 237, 1),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AccountsDetail()),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 20),
                                        height: 40,
                                        width: 180,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(60),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Get Started.",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    26, 68, 237, 1),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
