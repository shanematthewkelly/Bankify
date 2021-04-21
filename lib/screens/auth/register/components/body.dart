import 'package:Bankify/components/appbars/appbar.dart';
import 'package:Bankify/components/buttons/primary_button.dart';
import 'package:Bankify/configs/globals.dart';
import 'package:Bankify/configs/screen_sizing.dart';
import 'package:Bankify/models/user.dart';
import 'package:Bankify/screens/auth/components/input_fields.dart';
import 'package:Bankify/screens/auth/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegisterBody extends StatefulWidget {
  @override
  _RegisterBodyState createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  GlobalKey<FormState> validationKey = GlobalKey<FormState>();
  SharedPreferences sharedPreferences;
  bool stepChanged = false;

  // Form Field Controllers
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  // String variables
  String name, email, phone, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppbar(),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height / 1.5,
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
                      ? "Hey there! We want to get to know you, lets start with the basics."
                      : "Please register your phone number and enter a secure password.",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: screenWidthData(16),
                      fontFamily: 'MetroMedium',
                      height: 1.3),
                ),
                Container(
                  height: screenHeightData(25),
                ),
                stepChanged == false
                    ? Form(
                        key: validationKey,
                        child: Column(
                          children: <Widget>[
                            nameField(),
                            emailField(),
                          ],
                        ),
                      )
                    : Form(
                        key: validationKey,
                        child: Column(
                          children: <Widget>[
                            phoneField(),
                            passwordField(),
                          ],
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeightData(20)),
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: RichText(
                        text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                          TextSpan(
                              text: "Already have an account with us? ",
                              style: TextStyle(
                                  fontFamily: 'MetroMedium',
                                  fontSize: screenWidthData(14))),
                          TextSpan(
                              text: "Log in",
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

  AuthFields nameField() {
    return AuthFields(
      hint: "Name",
      controller: controllerName,
      validator: (fieldValue) {
        if (fieldValue.isEmpty) {
          return 'Name is required';
        }
        if (fieldValue.length < 2) {
          return 'Email must be at least 2 characters';
        }
      },
      onSaved: (fieldValue) {
        name = fieldValue;
      },
    );
  }

  AuthFields emailField() {
    return AuthFields(
      hint: "Email",
      controller: controllerEmail,
      validator: (fieldValue) {
        if (fieldValue.isEmpty) {
          return 'Email is required';
        }
        if (fieldValue.length < 6) {
          return 'Email must be at least 6 characters';
        }
      },
      onSaved: (fieldValue) {
        email = fieldValue;
      },
    );
  }

  AuthFields phoneField() {
    return AuthFields(
      hint: "Phone",
      controller: controllerPhone,
      validator: (fieldValue) {
        if (fieldValue.isEmpty) {
          return 'Phone is required';
        }
        if (fieldValue.length < 6) {
          return 'Phone must be at least 6 characters';
        }
      },
      onSaved: (fieldValue) {
        phone = fieldValue;
      },
    );
  }

  AuthFields passwordField() {
    return AuthFields(
      hint: "Password",
      controller: controllerPassword,
      validator: (fieldValue) {
        if (fieldValue.isEmpty) {
          return 'Password is required';
        }
        if (fieldValue.length < 8) {
          return 'Password must be at least 8 characters';
        }
      },
      onSaved: (fieldValue) {
        password = fieldValue;
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

        storeNameAndEmail(name, email);
        controllerName.clear();
        controllerEmail.clear();

        setState(() {
          stepChanged = true;
        });
      },
    );
  }

  PrimaryButton passwordButton() {
    return PrimaryButton(
      buttonText: "Register",
      onPress: () async {
        if (!validationKey.currentState.validate()) {
          return null;
        }
        validationKey.currentState.save();

        final String name = sharedPreferences.getString("name");
        final String email = sharedPreferences.getString("email");
        final String phone = controllerPhone.text;
        final String password = controllerPassword.text;

        final UserModel user = await userRegister(name, email, phone, password);

        return user;
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
          "Register",
          style: TextStyle(
            color: Colors.black,
            fontSize: screenWidthData(16),
            fontWeight: FontWeight.bold,
            fontFamily: 'MetroBold',
          ),
        ),
      );

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
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
          (Route<dynamic> route) => false);

      return userModelFromJson(responseBody);
    } else {
      return null;
    }
  }

  Future<void> storeNameAndEmail(String name, String email) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("email", email);
    sharedPreferences.setString("name", name);
  }
}
