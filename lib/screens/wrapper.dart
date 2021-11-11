import 'package:flutter/material.dart';
import 'package:food_dating_app/models/user.dart';
import 'package:food_dating_app/screens/home/home_page.dart';
import 'package:provider/provider.dart';
import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return HomePage();
    }
  }
}
