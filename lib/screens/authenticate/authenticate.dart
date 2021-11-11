import 'package:flutter/material.dart';
import 'package:food_dating_app/screens/authenticate/signup_page.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SignUpPage(),
    );
  }
}
