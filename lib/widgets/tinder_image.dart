import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:food_dating_app/models/app_user.dart';
import 'package:food_dating_app/services/database.dart';

// Update this part with Firebase later
final DatabaseService db =
    DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid);
final List<AppUser>? userList = db.userListFromSnapShots(db.getUserStream());

class TinderImage extends StatefulWidget {
  @override
  _TinderImageState createState() => _TinderImageState();
}

class _TinderImageState extends State<TinderImage> {
  // Dynamically load cards from database
  List<Card> cards = [
    Card(
      Image.network(userList![0].getURL()),
      Text(userList![0].getName()),
      Text(userList![0].getRestaurant()),
    ),
    // Card(
    //   Image.network(userList![1].getURL()),
    //   Text(userList![1].getName()),
    //   Text(userList![1].getRestaurant()),
    // ),
    // Card(
    //   Image.network(userList![2].getURL()),
    //   Text(userList![2].getName()),
    //   Text(userList![2].getRestaurant()),
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    // Stack of cards that can be swiped. Set width, height, etc here.
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.width * 1.5,
      // width: 240,
      // height: 300,
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
}

class Card extends StatelessWidget {
  final Image image;
  final Text title;
  final Text subtitle;
  Card(this.image, this.title, this.subtitle);

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
                fit: BoxFit.fill,
                alignment: Alignment.bottomCenter,
              ),
            ),
            child: Text(title.toString()),
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
