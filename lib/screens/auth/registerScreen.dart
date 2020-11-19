import 'dart:developer';

import 'package:Bankify/models/user.dart';
import 'package:Bankify/screens/auth/loginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

//Herw we are returning a Future and passing in the User Model class
Future<UserModel> userRegister(String name, email, phone, password) async {
  //Accessing the AWS Amplify endpoint
  final String endpoint =
      "https://t3tjyg5p36.execute-api.us-east-1.amazonaws.com/dev/users/register";

  //Attempting to retrieve the repsonse body
  final response = await http.post(endpoint, body: {
    "name": name,
    "email": email,
    "phone": phone,
    "password": password
  });

  if (response.statusCode == 201) {
    final responseBody = response.body;

    return userModelFromJson(responseBody);
  } else {
    log("Error in response");
    return null;
  }
}

class _RegisterScreenState extends State<RegisterScreen> {
  //Key used to check any state changes
  GlobalKey<FormState> validationKey = GlobalKey<FormState>();

//Global variable for our UserModel class
  UserModel _user;

  //Form Field Controllers
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  //String variables
  String name, email, phone, password;

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
                margin: EdgeInsets.only(top: 60),
                height: 230,
                child: Lottie.asset(
                  'assets/lottie/register.json',
                  fit: BoxFit.fill,
                ),
              ),
              Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(25),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5),
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
                            padding:
                                EdgeInsets.only(left: 5, top: 1, bottom: 1),
                            child: TextFormField(
                              controller: controllerName,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter your name",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                              ),
                              //Validation - checks if the field value is empty
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
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16.0),
                      padding: EdgeInsets.all(5),
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
                            padding:
                                EdgeInsets.only(left: 5, top: 1, bottom: 1),
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
                                email = fieldValue;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16.0),
                      padding: EdgeInsets.all(5),
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
                            padding:
                                EdgeInsets.only(left: 5, top: 1, bottom: 1),
                            child: TextFormField(
                              controller: controllerPhone,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter your phone number",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                              ),
                              //Validation - checks if the field value is empty
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
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16.0),
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
                    GestureDetector(
                      onTap: () async {
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

                        setState(() {
                          _user = user;
                        });

                        //Navigate to the login screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: Container(
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
                    SizedBox(height: 65),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text("Already have an account?",
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
}
