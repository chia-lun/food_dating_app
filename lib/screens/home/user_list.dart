import 'package:flutter/material.dart';
import 'package:food_dating_app/models/user.dart';
import 'package:food_dating_app/models/app_user.dart';
import 'package:food_dating_app/screens/home/user_tile.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final appUsers = Provider.of<List<AppUser>>(context);
    // // print(users);
    // users.forEach((user) {
    //   print(user.name);
    //   //print(user.age);
    //   //print(user.restaurant);
    // });

    return ListView.builder(
      itemCount: appUsers.length,
      itemBuilder: (context, index) {
        return UserTile(appUser: appUsers[index]);
      },
    );
  }
}
