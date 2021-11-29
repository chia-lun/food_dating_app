import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:food_dating_app/models/app_user.dart';
import 'package:food_dating_app/screens/home/user_list.dart';
import 'package:food_dating_app/services/database.dart';
//import { "user", query, where, getDocs } from "firebase/firestore";

// Update this part with Firebase later
final DatabaseService db =
    DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid);
late List<AppUser>? userList = [];

class TinderImage extends StatefulWidget {
  @override
  _TinderImageState createState() => _TinderImageState();
}

class _TinderImageState extends State<TinderImage> {
  List<Card> cards = [];

  // Dynamically load cards from database
  @override
  void initState() {
    super.initState();
    loadUser().then((userList) {
      setState(() {
        userList = userList;
      });
    });
    // loadUser().then((value) => super.initState());
  }

  Future<void> loadUser() async {
    userList = await db.userListFromSnapShots();
    print(userList!.isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    //  if (userList == null) {

//      return Text("loading");
    //} else {
    for (AppUser appUser in userList!) {
      //print(appUser.name);
      cards.add(Card(
          Image.network(appUser.getURL()),
          Text(appUser.getName(),
              style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          Text(appUser.getAge().toString(),
              style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          Text(appUser.getRestaurant(),
              style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold))));
      //print(appUser.name + appUser.getURL() + "added");
    }

    // Stack of cards that can be swiped. Set width, height, etc here.
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.width * 1.5,

      // Important to keep as a stack to have overlay of cards.
      child: Stack(
        children: cards,
      ),
      // child: StreamBuilder<List<Card>>(
      //       stream: cards,
      //       builder: (context, snapshot) {
      //         if (!snapshot.hasData) return SizedBox();
      //         final data = snapshot.data;
      //         return Stack(
      //           children: data!,
      //         );
      //       },
      //     ),
    );
  }
  //}
}

class Card extends StatelessWidget {
  final Image image;
  final Text title;
  final Text age_title;
  final Text subtitle;
  Card(this.image, this.title, this.age_title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Swipable(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.width * 1.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              image: DecorationImage(
                image: image.image,
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Container(
                  child: title,
                ),
                Container(
                  child: age_title,
                ),
                Container(
                  child: subtitle,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Swipable(
  //     child: Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(16.0),
  //         image: DecorationImage(
  //           image: image.image,
  //           fit: BoxFit.cover,
  //           alignment: Alignment.bottomCenter,
  //         ),
  //       ),
  //       child: title,
  //     ),
  //     //onSwipeRight, left, up, down, cancel, etc...
  //   );
  // }
}
