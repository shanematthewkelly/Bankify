import 'package:Bankify/preloader.dart';
import 'package:Bankify/screens/home/home.dart';
import 'package:Bankify/screens/plaid/bankSuccessful.dart';
import 'package:Bankify/screens/profile/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'Bankify',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Preloader(),
      debugShowCheckedModeBanner: false,
    );
  }
}
