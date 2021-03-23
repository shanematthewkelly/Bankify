import 'package:Bankify/configs/screen_sizing.dart';
import 'package:Bankify/screens/onboarding/onboarding.dart';
import 'package:flutter/material.dart';

class Preloader extends StatefulWidget {
  @override
  _PreloaderState createState() => _PreloaderState();
}

class _PreloaderState extends State<Preloader>
    with SingleTickerProviderStateMixin {
  AnimationController _animController;

  @override
  void initState() {
    // Animation setup
    _animController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));

    _animController.forward();
    super.initState();

    // Rendering the view for only 5 seconds
    new Future.delayed(
        const Duration(milliseconds: 4000),
        () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OnBoarding()),
            ));
  }

  @override
  void dispose() {
    // Memory Mangement
    _animController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    ScreenSizing().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          BankifyTitle(
            animationLocal: _animController,
          ),
        ],
      ),
    );
  }
}

class BankifyTitle extends StatelessWidget {
  // Local Animation Controller
  final AnimationController animationLocal;

  // Constructor
  BankifyTitle({@required this.animationLocal});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height / 1,
      child: Center(
        child: FadeTransition(
          opacity: animationLocal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "BANKIFY",
                style: TextStyle(
                  fontFamily: 'Audiowide',
                  color: Colors.black,
                  fontSize: 40,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
