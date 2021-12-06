import 'package:food_dating_app/models/app_user.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final AppUser appUser;
  UserTile({required this.appUser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: const CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.orange,
          ),
          title: Text(appUser.name),
          subtitle: Text('Takes me to restaurant: ${appUser.restaurant}'),
        ),
      ),
    );
  }
}
