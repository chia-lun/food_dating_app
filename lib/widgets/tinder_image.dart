// import 'dart:ui';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_swipable/flutter_swipable.dart';
// import 'package:food_dating_app/models/app_user.dart';
// import 'package:food_dating_app/screens/home/matched_page.dart';
// import 'package:food_dating_app/services/database.dart';
// import 'package:food_dating_app/models/match.dart';
// import 'package:food_dating_app/models/swipe.dart';

// // Update this part with Firebase later
// final DatabaseService db =
//     DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid);
// late List<AppUser>? userList = [];

// class TinderImage extends StatefulWidget {
//   const TinderImage({Key? key}) : super(key: key);

//   @override
//   _TinderImageState createState() => _TinderImageState();
// }

// class _TinderImageState extends State<TinderImage> {
//   List<Card> cards = [];

//   // Dynamically load cards from database
//   @override
//   void initState() {
//     super.initState();
//     loadUser().then((userList) {
//       setState(() {
//         userList = userList;
//       });
//     });
//     // loadUser().then((value) => super.initState());
//   }

//   Future<void> loadUser() async {
//     userList = await db.userListFromSnapShots();
//     //print(userList);
//     print(userList!.isEmpty);
//   }

//   @override
//   Widget build(BuildContext context) {
//     for (AppUser appUser in userList!) {
//       print(appUser.name);
//       cards.add(Card(
//           //context,
//           Image.network(appUser.getURL()),
//           Text(appUser.getName(),
//               style: const TextStyle(
//                   fontSize: 24,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold)),
//           Text(appUser.getAge().toString(),
//               style: const TextStyle(
//                   fontSize: 24,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold)),
//           Text(appUser.getRestaurant(),
//               style: const TextStyle(
//                   fontSize: 24,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold)),
//           appUser));
//       //print(appUser.name + appUser.getURL() + "added");
//     }

//     // Stack of cards that can be swiped. Set width, height, etc here.
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.9,
//       height: MediaQuery.of(context).size.width * 1.5,
//       // Important to keep as a stack to have overlay of cards.
//       child: Stack(
//         children: cards,
//       ),
//     );
//   }
//   //}
// }

// class Card extends StatelessWidget {
//   final Image image;
//   final Text title;
//   final Text age_title;
//   final Text subtitle;
//   final AppUser otherUser;
//   final BuildContext context;
//   //late bool isLiked = true;

//   Card(this.context, this.image, this.title, this.age_title, this.subtitle,
//       this.otherUser,
//       {Key? key})
//       : super(key: key);

//   final _auth = FirebaseAuth.instance;
//   late List<String> _ignoreSwipeIds;

//   late User? user = _auth.currentUser;

//   String getUserId() {
//     //final User? user = _auth.currentUser;
//     final userId = user!.uid;
//     return userId;
//   }

//   AppUser convertCurrentUser() {
//     final User? user = _auth.currentUser;
//     // ignore: avoid_print
//     //print(user!.uid);
//     return AppUser(
//         uid: user!.uid, name: "", age: 0, restaurant: "", pfpDownloadURL: "");
//   }

//   late final DatabaseService _localDatabase = DatabaseService(uid: getUserId());

//   Future personSwiped(
//       AppUser currentUser, AppUser otherUser, bool isLiked) async {
//     _localDatabase.addSwipedUser(Swipe(otherUser.uid, isLiked));
//     //_ignoreSwipeIds.add(otherUser.uid);

//     if (isLiked == true) {
//       if (await isMatch(otherUser) == true) {
//         _localDatabase.addMatch(getUserId(), Match(otherUser.uid));
//         _localDatabase.addMatch(otherUser.uid, Match(getUserId()));
//         // save line 48&49 later to incorporate with chat
//         //String chatId = compareAndCombineIds(myUser.uid, otherUser.uid);
//         //_localDatabase.addChat(Chat(chatId, null));

//         // will quickly build a match screen
//         Navigator.pushNamed(context, MatchedScreen.id, arguments: {
//           "my_user_id": currentUser.uid,
//           "my_profile_photo_path": currentUser.pfpDownloadURL,
//           "other_user_profile_photo_path": otherUser.pfpDownloadURL,
//           "other_user_id": otherUser.uid
//         });
//       }
//     }
//     setState(() {});
//   }

//   Future<bool> isMatch(AppUser otherUser) async {
//     print("o");
//     DocumentSnapshot swipeSnapshot =
//         await _localDatabase.getSwipe(otherUser.uid);
//     print("1");
//     print(swipeSnapshot);
//     if (swipeSnapshot.exists) {
//       print("snapshot exists");
//       Swipe swipe = Swipe.fromSnapshot(swipeSnapshot);

//       if (swipe.liked == true) {
//         print("or here");
//         return true;
//       }
//     }
//     print("pass here");
//     return false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Swipable(
//       child: Column(
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width * 0.9,
//             height: MediaQuery.of(context).size.width * 1.5,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16.0),
//               image: DecorationImage(
//                 image: image.image,
//                 fit: BoxFit.cover,
//                 alignment: Alignment.bottomCenter,
//               ),
//               //child: Text(title.toString()),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Row(
//                   children: [
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     Container(
//                       child: title,
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     Container(
//                       child: age_title,
//                     )
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     Container(
//                       child: subtitle,
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       onSwipeLeft: (finalPosition) {
//         personSwiped(convertCurrentUser(), otherUser, true);
//       },
//       onSwipeRight: (finalPosition) {
//         personSwiped(convertCurrentUser(), otherUser, false);
//       },
//     );
//   }

//   void setState(Null Function() param0) {}
// }
