import 'dart:convert';

import 'package:Bankify/components/appbars/appbar.dart';
import 'package:Bankify/components/bottom_modal.dart';
import 'package:Bankify/components/buttons/primary_button.dart';
import 'package:Bankify/configs/globals.dart';
import 'package:Bankify/configs/screen_sizing.dart';
import 'package:Bankify/screens/auth/components/input_fields.dart';
import 'package:Bankify/screens/auth/login/validators/validators.dart';
import 'package:Bankify/screens/auth/register/register.dart';
import 'package:Bankify/screens/plaid/bankConnectScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginBody extends StatefulWidget {
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  GlobalKey<FormState> validationKey = GlobalKey<FormState>();
  SharedPreferences sharedPreferences;
  bool stepChanged = false;

  // Form Field Controllers
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  // String variables
  String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppbar(),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          child: steppedAuth(),
        ),
      ),
      bottomNavigationBar: bottomButton(),
    );
  }

  Column steppedAuth() {
    return Column(
      children: <Widget>[
        new Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: screenHeightData(30),
                horizontal: screenWidthData(20)),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  stepChanged == false
                      ? "Please enter the email address used when you signed up with us."
                      : "Please enter the password used when you signed up with us.",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: screenWidthData(16),
                      fontFamily: 'MetroMedium',
                      height: 1.3),
                ),
                Container(
                  height: screenHeightData(25),
                ),
                Form(
                  key: validationKey,
                  child: stepChanged == false ? emailField() : passwordField(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeightData(20)),
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()),
                      );
                    },
                    child: RichText(
                        text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                          TextSpan(
                              text: "Don't have an account already? ",
                              style: TextStyle(
                                  fontFamily: 'MetroMedium',
                                  fontSize: screenWidthData(14))),
                          TextSpan(
                              text: "Sign up",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontFamily: 'MetroMedium',
                                  fontSize: screenWidthData(14)))
                        ])),
                  ),
                ),
              ],
            ),
          ),
        ),
        Spacer()
      ],
    );
  }

  AuthFields emailField() {
    return AuthFields(
      hint: "Email",
      controller: controllerEmail,
      validator: EmailValidator.validate,
      onSaved: (value) {
        //Setting the state
        email = value;
      },
    );
  }

  AuthFields passwordField() {
    return AuthFields(
      hint: "Password",
      hideText: true,
      controller: controllerPassword,
      validator: PasswordValidator.validate,
      onSaved: (value) {
        //Setting the state
        password = value;
      },
    );
  }

  Container bottomButton() {
    return Container(
      margin: EdgeInsets.only(
        bottom: screenHeightData(25),
        left: screenWidthData(15),
        right: screenWidthData(15),
      ),
      child: stepChanged == false ? emailButton() : passwordButton(),
    );
  }

  PrimaryButton emailButton() {
    return PrimaryButton(
      buttonText: "Continue",
      onPress: () async {
        if (!validationKey.currentState.validate()) {
          return;
        }
        validationKey.currentState.save();
        final String email = controllerEmail.text;

        storeEmail(email);
        controllerEmail.clear();

        setState(() {
          stepChanged = true;
        });
      },
    );
  }

  PrimaryButton passwordButton() {
    return PrimaryButton(
      buttonText: "Login",
      onPress: () async {
        if (!validationKey.currentState.validate()) {
          return;
        }
        validationKey.currentState.save();

        final String email = sharedPreferences.getString("email");
        final String password = controllerPassword.text;
        await signIn(email, password);
      },
    );
  }

  PrimaryAppbar buildAppbar() => PrimaryAppbar(
        centered: true,
        profile: Padding(
          padding: EdgeInsets.only(left: screenWidthData(15)),
          child: GestureDetector(
            onTap: () async {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: primaryColor,
              size: screenWidthData(25),
            ),
          ),
        ),
        title: Text(
          "Log In",
          style: TextStyle(
            color: Colors.black,
            fontSize: screenWidthData(16),
            fontWeight: FontWeight.bold,
            fontFamily: 'MetroBold',
          ),
        ),
      );

  Future signIn(String email, String password) async {
    sharedPreferences = await SharedPreferences.getInstance();

    final Uri endpoint = Uri.parse(baseURL + "/users/login");

    final response = await http.post(endpoint,
        headers: {"Accept": "Application/json"},
        body: {"email": email, "password": password});

    var responseData = jsonDecode(response.body);

    sharedPreferences.setString("token", responseData["token"]);
    sharedPreferences.setString("userId", responseData["id"]);

    if (response.statusCode == 200) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => ConnectBank()),
          (Route<dynamic> route) => false);

      return responseData;
    } else {
      incorrectUserDetails();
      setState(() {
        stepChanged = false;
        controllerPassword.clear();
        controllerEmail.clear();
      });
      return null;
    }
  }

  void incorrectUserDetails() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return ReusableModal(context: context);
        });
  }

  Future<void> storeEmail(String email) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("email", email);
  }
}
