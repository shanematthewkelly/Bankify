import 'dart:convert';
import 'package:Bankify/configs/globals.dart';
import 'package:Bankify/screens/plaid/bankConnectScreen.dart';
import 'package:Bankify/screens/register/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Key used to check any state changes
  GlobalKey<FormState> validationKey = GlobalKey<FormState>();

  //Setup our preloader display
  bool _isLoading = false;

  //Form Field Controllers
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  //String variables
  String username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        //Form
        child: Form(
          //Accessing the key
          key: validationKey,
          child: Column(
            children: <Widget>[
              Container(
                height: 350,
                child: Lottie.asset(
                  'assets/lottie/login.json',
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(25),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 5, top: 1, bottom: 1),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, .3),
                                blurRadius: 25.0,
                                offset: Offset(0, 7)),
                          ]),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(5),
                            child: TextFormField(
                              controller: controllerEmail,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter your email",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                              ),
                              //Validation - checks if the field value is empty
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
                                username = fieldValue;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      padding: EdgeInsets.only(left: 5, top: 1, bottom: 1),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, .3),
                                blurRadius: 25.0,
                                offset: Offset(0, 7)),
                          ]),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(5),
                            child: TextFormField(
                              controller: controllerPassword,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter your password",
                                  hintStyle:
                                      TextStyle(color: Colors.grey[400])),
                              keyboardType: TextInputType.visiblePassword,
                              //Validation - checks if the field value is empty
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
                              //Hiding the password field
                              obscureText: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    //Login
                    GestureDetector(
                      onTap: () async {
                        if (!validationKey.currentState.validate()) {
                          return;
                        }
                        //Save the current state in memory
                        validationKey.currentState.save();

                        //Here we authenticate the user with our Express REST API
                        final String email = controllerEmail.text;
                        final String password = controllerPassword.text;

                        //Preloader active
                        setState(() {
                          _isLoading = true;
                        });

                        //Calling the Future
                        signIn(email, password);
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(36, 97, 227, .8),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, .3),
                                blurRadius: 25.0,
                                offset: Offset(0, 7))
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "L O G I N",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    //Register
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(219, 0, 161, 1),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(219, 0, 161, .3),
                                blurRadius: 25.0,
                                offset: Offset(0, 7))
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "R E G I S T E R",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    GestureDetector(
                      onTap: () {
                        //TODO: Forgot Password Handler
                      },
                      child: Text("Forgotten password?",
                          style: TextStyle(color: Colors.grey[400])),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future signIn(String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    //Accessing the AWS Amplify endpoint
    final String endpoint = baseURL + "/users/login";

    //Attempting to retrieve the repsonse body
    final response = await http.post(endpoint,
        headers: {"Accept": "Application/json"},
        body: {"email": email, "password": password});

    var responseData = jsonDecode(response.body);

    //Setting the user token & ID
    sharedPreferences.setString("token", responseData["token"]);
    sharedPreferences.setString("userId", responseData["id"]);

    //Correct user credentials
    if (response.statusCode == 200) {
      //Load new route
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => ConnectBank()),
          (Route<dynamic> route) => false);

      return responseData;
    } else {
      //User has entered the wrong information, call this function to display a modal
      incorrectUserDetails();
      return null;
    }
  }

  void incorrectUserDetails() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          //here we return the view
          return Container(
            //Configuring the view port of the device's screen
            height: MediaQuery.of(context).size.height * .45,
            child: Padding(
              padding: EdgeInsets.only(right: 17, top: 17),
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          //Modal 'Close' Button
                          Navigator.of(context).pop();
                        },
                        child: Icon(CupertinoIcons.arrow_down_circle_fill,
                            color: Color.fromRGBO(36, 97, 227, .8), size: 30),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.only(left: 27, top: 30),
                          child: Text(
                              "The details you have entered for your account seem to be incorrect, sorry!",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 200,
                    padding: EdgeInsets.only(top: 20),
                    child: Lottie.asset(
                      'assets/lottie/incorrect.json',
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
