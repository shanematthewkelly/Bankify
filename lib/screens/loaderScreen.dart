import 'package:Bankify/screens/introScreen.dart';
import 'package:Bankify/screens/auth/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Preloader extends StatefulWidget {
  @override
  _PreloaderState createState() => _PreloaderState();
}

class _PreloaderState extends State<Preloader> {
  @override
  //Rendering the view for only 5 seconds using Future Delay before going to new screen
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(seconds: 6),
        () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => IntroScreen()),
            ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/loaderbackground.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "BANKIFY",
                    style: TextStyle(
                      fontFamily: 'VarelaRound',
                      color: Colors.black,
                      fontSize: 40,
                      letterSpacing: 1,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    height: 220,
                    padding: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, .3),
                            blurRadius: 25.0,
                            offset: Offset(0, 7)),
                      ],
                    ),
                    child: Lottie.asset(
                      'assets/lottie/bankify-loader.json',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
