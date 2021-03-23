import 'dart:async';
import 'dart:convert';
import 'package:Bankify/components/bottom_modal.dart';
import 'package:Bankify/components/secondary_button.dart';
import 'package:Bankify/configs/globals.dart';
import 'package:Bankify/configs/screen_sizing.dart';
import 'package:Bankify/models/user.dart';
import 'package:Bankify/screens/auth/auth.dart';
import 'package:Bankify/screens/plaid/bankConnectScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_fields.dart';
import 'auth_image.dart';
import 'auth_tabs.dart';

class AuthBody extends StatefulWidget {
  @override
  _AuthBodyState createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody> {
  bool isLoginTab = true;
  Duration _duration = Duration(seconds: 1);
  GlobalKey<FormState> validationKey = GlobalKey<FormState>();

  // Form Field Controllers
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  // String variables
  String name, email, phone, password;

  // Tab UI
  void changeUITheme(int activeTabNum) {
    if (activeTabNum == 0) {
      setState(() {
        isLoginTab = true;
      });
    } else {
      Future.delayed(Duration(milliseconds: 300), () {
        setState(() {
          isLoginTab = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color lightUI = Color.fromRGBO(80, 143, 235, 1);
    Color darkUI = Color.fromRGBO(26, 41, 66, 1);

    return SingleChildScrollView(
      child: AnimatedContainer(
        duration: _duration,
        curve: Curves.easeInOut,
        width: double.infinity,
        height: ScreenSizing.screenHeight,
        decoration: BoxDecoration(
          color: isLoginTab ? darkUI : lightUI,
        ),
        child: Stack(
          children: <Widget>[
            AuthImage(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: screenHeightData(50),
                    ),
                    AuthTabs(
                      press: (value) {
                        changeUITheme(value);
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: screenHeightData(50)),
                          child: Text(
                            isLoginTab ? "Welcome." : "Join Us.",
                            style: TextStyle(
                              fontFamily: 'VarelaRound',
                              fontSize: screenWidthData(40),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          height: screenHeightData(50),
                        ),
                        isLoginTab ? loginForm() : registerForm(),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

// Register UI logic
  Form registerForm() {
    return Form(
      key: validationKey,
      child: Column(
        children: <Widget>[
          AuthFields(
              hint: "Enter your name",
              controller: controllerName,
              validator: (fieldValue) {
                if (fieldValue.isEmpty) {
                  return 'Name is required';
                }
                //Check to determine if the input value is less than 4 characters long
                if (fieldValue.length < 3) {
                  return 'Name must be at least 3 characters';
                }
              },
              onSaved: (fieldValue) {
                //Setting the state
                name = fieldValue;
              }),
          AuthFields(
            hint: "Enter your email",
            controller: controllerEmail,
            validator: (fieldValue) {
              if (fieldValue.isEmpty) {
                return 'Email is required';
              }
              //Check to determine if the input value is less than 4 characters long
              if (fieldValue.length < 5) {
                return 'Email must be at least 5 characters';
              }
            },
            onSaved: (fieldValue) {
              //Setting the state
              email = fieldValue;
            },
          ),
          AuthFields(
            controller: controllerPhone,
            hint: "Enter your phone number",
            validator: (fieldValue) {
              if (fieldValue.isEmpty) {
                return 'Phone is required';
              }
              //Check to determine if the input value is less than 4 characters long
              if (fieldValue.length < 5) {
                return 'Phone must be at least 5 characters';
              }
            },
            onSaved: (fieldValue) {
              //Setting the state
              phone = fieldValue;
            },
          ),
          AuthFields(
            controller: controllerPassword,
            hint: "Enter your password",
            validator: (fieldValue) {
              if (fieldValue.isEmpty) {
                return 'Password is required';
              }
              //Check to determine if the input value is less than 8 characters long
              if (fieldValue.length < 8) {
                return 'Password must be at least 8 characters';
              }
            },
            onSaved: (fieldValue) {
              //Setting the state
              password = fieldValue;
            },
          ),
          Container(
            height: screenHeightData(50),
          ),
          SecondaryButton(
            buttonText: "Register",
            onPress: () async {
              if (!validationKey.currentState.validate()) {
                return; //Form is vaild
              }
              //Save the current state in memory
              validationKey.currentState.save();

              //Here we show the text of each field
              final String name = controllerName.text;
              final String email = controllerEmail.text;
              final String phone = controllerPhone.text;
              final String password = controllerPassword.text;

              //Calling the Future
              final UserModel user =
                  await userRegister(name, email, phone, password);
            },
          ),
        ],
      ),
    );
  }

  // Login UI Logic
  Form loginForm() {
    return Form(
      key: validationKey,
      child: Column(
        children: <Widget>[
          AuthFields(
            hint: "Enter your email",
            controller: controllerEmail,
            validator: (fieldValue) {
              if (fieldValue.isEmpty) {
                return 'Email is required';
              }
              //Check to determine if the input value is less than 4 characters long
              if (fieldValue.length < 5) {
                return 'Email must be at least 5 characters';
              }
            },
            onSaved: (fieldValue) {
              //Setting the state
              email = fieldValue;
            },
          ),
          AuthFields(
            hint: "Enter your password",
            // hideText: true,
            controller: controllerPassword,
            validator: (fieldValue) {
              if (fieldValue.isEmpty) {
                return 'Password is required';
              }
              //Check to determine if the input value is less than 8 characters long
              if (fieldValue.length < 8) {
                return 'Password must be at least 8 characters';
              }
            },
            onSaved: (fieldValue) {
              //Setting the state
              password = fieldValue;
            },
          ),
          Container(
            height: screenHeightData(50),
          ),
          SecondaryButton(
            buttonText: "Login",
            onPress: () async {
              if (!validationKey.currentState.validate()) {
                return;
              }
              //Save the current state in memory
              validationKey.currentState.save();

              //Here we authenticate the user with our Express REST API
              final String email = controllerEmail.text;
              final String password = controllerPassword.text;

              //Calling the Future
              signIn(email, password);
            },
          ),
        ],
      ),
    );
  }

  Future signIn(String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final String endpoint = baseURL + "/users/login";

    final response = await http.post(endpoint,
        headers: {"Accept": "Application/json"},
        body: {"email": email, "password": password});

    var responseData = jsonDecode(response.body);

    // Setting the user token & ID
    sharedPreferences.setString("token", responseData["token"]);
    sharedPreferences.setString("userId", responseData["id"]);

    // Correct user credentials
    if (response.statusCode == 200) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => ConnectBank()),
          (Route<dynamic> route) => false);

      return responseData;
    } else {
      incorrectUserDetails();
      return null;
    }
  }

  Future<UserModel> userRegister(String name, email, phone, password) async {
    final String endpoint = baseURL + "/users/register";

    final response = await http.post(endpoint, body: {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password
    });

    if (response.statusCode == 201) {
      final responseBody = response.body;

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => AuthScreen()),
          (Route<dynamic> route) => false);

      return userModelFromJson(responseBody);
    } else {
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
}
