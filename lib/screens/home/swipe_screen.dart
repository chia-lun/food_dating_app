import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_dating_app/models/app_user.dart';
import 'package:food_dating_app/models/swipe.dart';
import 'package:food_dating_app/services/auth_provider.dart';
import 'package:food_dating_app/services/database.dart';
import 'package:food_dating_app/models/match.dart';
import 'package:food_dating_app/widgets/custom_modal.dart';
import 'package:food_dating_app/widgets/swipe_card.dart';
import 'package:provider/provider.dart';
import 'matched_page.dart';

class SwipeScreen extends StatefulWidget {
  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  final DatabaseService db =
      DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> _ignoreSwipeIds = [];
  //late List<AppUser> userList = [];

  // Future<List<AppUser>> loadPeople(String myUserId) async {
  //   print(_ignoreSwipeIds.length);
  //   print('hi');
  //   if (_ignoreSwipeIds.isEmpty) {
  //     print('empty');
  //     _ignoreSwipeIds = <String>[];
  //     var swipes = await db.getSwipes(myUserId);
  //     for (var i = 0; i < swipes.size; i++) {
  //       print(swipes.size);
  //       Swipe swipe = Swipe.fromSnapshot(swipes.docs[i]);
  //       print(swipe.id);
  //       _ignoreSwipeIds.add(swipe.id);
  //     }
  //     _ignoreSwipeIds.add(myUserId);
  //   }
  //   print('not empty');
  //   QuerySnapshot userToMatch = await db.getUserToMatch(_ignoreSwipeIds);
  //   if (userToMatch.docs.isNotEmpty) {
  //     var userToMatchWith = AppUser.fromDocument(userToMatch.docs.first);
  //     print(userToMatchWith.name);
  //     return userToMatchWith;
  //   } else {
  //     return null;
  //   }
  // }

  // Future<void> loadUser() async {
  //   userList = ((await db.userListFromSnapShots()) as Stream<AppUser>?)!;
  // }

  Future<List<AppUser>> loadPeople() async {
    return await db.userListFromSnapShots();
  }

  AppUser convertCurrentUser() {
    final User? user = FirebaseAuth.instance.currentUser!;
    return AppUser(
        uid: user!.uid, name: "", age: 0, restaurant: "", pfpDownloadURL: "");
  }

  void personSwiped(
      AppUser currentUser, AppUser otherUser, bool isLiked) async {
    db.addSwipedUser(Swipe(otherUser.uid, isLiked));
    _ignoreSwipeIds.add(otherUser.uid);

    if (await isMatch(otherUser) == true) {
      db.addMatch(FirebaseAuth.instance.currentUser!.uid, Match(otherUser.uid));
      db.addMatch(otherUser.uid, Match(FirebaseAuth.instance.currentUser!.uid));
      // save line 48&49 later to incorporate with chat
      //String chatId = compareAndCombineIds(myUser.uid, otherUser.uid);
      //_localDatabase.addChat(Chat(chatId, null));

      // will quickly build a match screen
      Navigator.pushNamed(context, MatchedScreen.id, arguments: {
        "my_user_id": currentUser.uid,
        "my_profile_photo_path": currentUser.pfpDownloadURL,
        "other_user_profile_photo_path": otherUser.pfpDownloadURL,
        "other_user_id": otherUser.uid
      });
    }
    setState(() {});
  }

  Future<bool> isMatch(AppUser otherUser) async {
    DocumentSnapshot swipeSnapshot = await db.getSwipe(otherUser.uid);
    if (swipeSnapshot.exists) {
      Swipe swipe = Swipe.fromSnapshot(swipeSnapshot);

      if (swipe.liked == true) {
        return true;
      }
    }
    return false;
  }

  createChatDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Dinner?"),
            content: TextField(
              controller: customController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: const Text("Go"),
                onPressed: () {
                  Navigator.of(context).pop(customController.text.toString());
                  print(FirebaseAuth.instance.currentUser!.uid);
                  //personSwiped(convertCurrentUser(), otherUser, true);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
        key: _scaffoldKey,
        body: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return FutureBuilder<AppUser>(
              future: authProvider.user,
              builder: (context, userSnapshot) {
                return CustomModalProgressHUD(
                  inAsyncCall: authProvider.user == null,
                  //offset: ,
                  child: (userSnapshot.hasData)
                      ? FutureBuilder<List<AppUser>>(
                          future: loadPeople(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                !snapshot.hasData) {
                              return Center(
                                child: Container(
                                    child: Text('No users',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4)),
                              );
                            }
                            if (!snapshot.hasData) {
                              return CustomModalProgressHUD(
                                inAsyncCall: true,
                                child: Container(),
                              );
                            }
<<<<<<< HEAD
                            return Container(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(30, 38, 1, 1),
                                child: Column(children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Stack(
                                          children: snapshot.data!
                                              .map((user) => Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            1.5,
                                                    child: SwipeCard(
                                                        user: user,
                                                        swipeLike: () =>
                                                            personSwiped(
                                                                convertCurrentUser(),
                                                                user,
                                                                true)),
                                                  ))
                                              .toList()),
                                    ],
                                  ),
                                  // const Padding(
                                  //   padding: EdgeInsets.only(bottom: 620),
                                  // ),
                                  TextButton(
                                    onPressed: () {
                                      createChatDialog(context);
                                    },
                                    child: const Text('   Chat   ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white)),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.orange,
                                      //minimumSize: const Size(30.0, 10.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                  )
                                ]),
                              ),
=======
                            return Padding(
                              padding: EdgeInsets.fromLTRB(23, 1, 1, 1),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Stack(
                                        children: snapshot.data!
                                            .map((user) => Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.9,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      1.5,
                                                  child: SwipeCard(user: user),
                                                ))
                                            .toList()),
                                    TextButton(
                                      onPressed: () {
                                        createChatDialog(context);
                                      },
                                      child: const Text('   Chat   ',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white)),
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.orange,
                                        //minimumSize: const Size(30.0, 10.0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      ),
                                    )
                                  ]),
>>>>>>> 2f7381a13a96c1b3a7c7f7f0fe3d9f264ce14134
                            );
                          })
                      : Container(),
                );
              },
            );
          },
        ));
  }
}
