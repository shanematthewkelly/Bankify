import 'package:Bankify/screens/core/bankConnectScreen.dart';
import 'package:Bankify/screens/core/home/home.dart';
import 'package:Bankify/screens/intro/loaderScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'Bankify',
      theme: ThemeData(
        //Application Global Theme
        primarySwatch: Colors.red,
      ),
      home: Preloader(),
      debugShowCheckedModeBanner: false,
    );
  }
}
