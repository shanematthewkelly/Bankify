import 'package:Bankify/components/primary_button.dart';
import 'package:Bankify/configs/globals.dart';
import 'package:Bankify/configs/screen_sizing.dart';
import 'package:Bankify/screens/login/login.dart';
import 'package:Bankify/screens/register/register.dart';
import 'package:flutter/material.dart';
import 'data.dart';

class OnBoardingBody extends StatefulWidget {
  @override
  _OnBoardingBodyState createState() => _OnBoardingBodyState();
}

class _OnBoardingBodyState extends State<OnBoardingBody> {
  int selectedPageView = 0;
  List<Map<String, String>> onBoardingData = [
    {
      "heading": "Banking made simple with Bankify",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vitae neque quis est mattis ultrices et eu lacus.",
      "image": "assets/images/festival.png"
    },
    {
      "heading": "Manage your transactions",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vitae neque quis est mattis ultrices et eu lacus.",
      "image": "assets/images/reserve.png"
    },
    {
      "heading": "Discover your expenditure",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vitae neque quis est mattis ultrices et eu lacus.",
      "image": "assets/images/rewards.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      selectedPageView = value;
                    });
                  },
                  itemCount: onBoardingData.length,
                  itemBuilder: (context, index) => OnBoardingData(
                        heading: onBoardingData[index]['heading'],
                        description: onBoardingData[index]['description'],
                        image: onBoardingData[index]["image"],
                      )),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidthData(15)),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        onBoardingData.length,
                        (index) => indicator(index: index),
                      ),
                    ),
                    Container(
                      height: screenHeightData(26),
                    ),
                    PrimaryButton(
                      buttonText: "Continue",
                      onPress: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()),
                        );
                      },
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: RichText(
                          text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                            TextSpan(
                                text: "Already signed up? ",
                                style: TextStyle(
                                    fontFamily: 'Montserrat-Secondary',
                                    fontSize: screenWidthData(15))),
                            TextSpan(
                                text: "Log In",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontFamily: 'Montserrat-Secondary',
                                    fontSize: screenWidthData(15)))
                          ])),
                    ),
                    Container(
                      height: screenHeightData(16),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container indicator({int index}) {
    return Container(
      margin: EdgeInsets.only(right: 6, left: 6),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
          color: selectedPageView == index ? primaryColor : Colors.grey,
          borderRadius: BorderRadius.circular(20)),
    );
  }
}
