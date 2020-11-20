import 'package:Bankify/models/introData.dart';
import 'package:Bankify/screens/auth/loginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(14, 135, 235, 1),
              Color.fromRGBO(20, 202, 222, 1)
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 50,
                  left: 35,
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Discover',
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'MetroBold',
                          color: Colors.white),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 37, bottom: 60, top: 6),
                child: Column(
                  children: <Widget>[
                    Text(
                      'INTRODUCTION',
                      style: TextStyle(
                          fontSize: 13, color: Colors.white, letterSpacing: 5),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 500,
                padding: EdgeInsets.only(left: 28),
                child: Swiper(
                  //Letting itemCount know where our data is
                  itemCount: appInfo.length,
                  itemWidth: MediaQuery.of(context).size.width - 2 * 64,
                  layout: SwiperLayout.STACK,
                  pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                        activeSize: 20, space: 10, activeColor: Colors.white),
                  ),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(height: 110),
                            Card(
                              elevation: 7,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(34),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 110),
                                    Text(
                                      appInfo[index].title,
                                      style: TextStyle(
                                          fontFamily: 'MetroBold',
                                          fontSize: 32,
                                          color: Colors.black),
                                      textAlign: TextAlign.left,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 2),
                                      child: Text(
                                        "Introduction",
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    Row(
                                      children: [
                                        Text(
                                          "Find out more",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color:
                                                Color.fromRGBO(21, 79, 237, 1),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: Icon(
                                            CupertinoIcons.arrow_right_circle,
                                            color:
                                                Color.fromRGBO(21, 79, 237, 1),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12, right: 12),
                          padding: EdgeInsets.all(40),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .3),
                                    blurRadius: 25.0,
                                    offset: Offset(0, 5)),
                              ]),
                          child: Image.asset(
                            appInfo[index].image,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(14, 135, 235, 1),
          ),
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "LOGIN",
                style: TextStyle(
                    color: Colors.white, fontSize: 16, letterSpacing: 5),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Icon(
                  CupertinoIcons.arrowshape_turn_up_right,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
