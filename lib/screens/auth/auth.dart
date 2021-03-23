import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBody(),
    );
  }
}
