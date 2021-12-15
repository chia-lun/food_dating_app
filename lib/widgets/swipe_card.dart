import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:food_dating_app/models/app_user.dart';
import 'package:food_dating_app/models/swipe.dart';
import 'package:food_dating_app/screens/home/matched_page.dart';
import 'package:food_dating_app/services/database.dart';
import 'package:food_dating_app/models/match.dart';

class SwipeCard extends StatefulWidget {
  final AppUser? user;
  //final BuildContext swipePageContext;

  SwipeCard({required this.user});

  @override
  // ignore: no_logic_in_create_state
  _SwipeCardState createState() => _SwipeCardState(user: user);
}

class _SwipeCardState extends State<SwipeCard> {
  _SwipeCardState({required this.user});
  AppUser? user;
  //BuildContext swipePageContext;
  final DatabaseService db =
      DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid);

  AppUser convertCurrentUser() {
    final User? user = FirebaseAuth.instance.currentUser!;
    return AppUser(
        uid: user!.uid, name: "", age: 0, restaurant: "", pfpDownloadURL: "");
  }

  void personSwiped(
      AppUser currentUser, AppUser otherUser, bool isLiked) async {
    print('test');
    print(otherUser.uid);
    db.addSwipedUser(Swipe(otherUser.uid, isLiked));
    //_ignoreSwipeIds.add(otherUser.uid);

    if (await isMatch(otherUser) == true) {
      db.addMatch(FirebaseAuth.instance.currentUser!.uid, Match(otherUser.uid));
      db.addMatch(otherUser.uid, Match(FirebaseAuth.instance.currentUser!.uid));
      // save line 48&49 later to incorporate with chat
      //String chatId = compareAndCombineIds(myUser.uid, otherUser.uid);
      //_localDatabase.addChat(Chat(chatId, null));

      // will quickly build a match screen
      // Navigator.pushNamed(context, MatchedScreen.id, arguments: {
      //   "my_user_id": currentUser.uid,
      //   "my_profile_photo_path": currentUser.pfpDownloadURL,
      //   "other_user_profile_photo_path": otherUser.pfpDownloadURL,
      //   "other_user_id": otherUser.uid
      // });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MatchedScreen(
            //   peerId: userChat.id,
            //   peerAvatar: userChat.photoUrl,
            //   peerNickname: userChat.nickname,
            myProfilePhotoPath: currentUser.pfpDownloadURL,
            myUserId: currentUser.uid,
            otherUserProfilePhotoPath: otherUser.pfpDownloadURL,
            otherUserId: otherUser.uid,
          ),
        ),
      );
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

  @override
  Widget build(BuildContext context) {
    return Swipable(
      // horizontalSwipe: false,
      // verticalSwipe: true,
      child: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.width * 1.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              image: DecorationImage(
                image: Image.network(user!.getURL()).image,
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
              //child: Text(title.toString()),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Text(user!.getName(),
                        style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(user!.getAge().toString(),
                        style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Text(user!.getRestaurant(),
                        style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      onSwipeRight: (finalPosition) {
        personSwiped(convertCurrentUser(), user!, true);
      },
      onSwipeLeft: (finalPosition) {
        //personSwiped(convertCurrentUser(), user!, false, );
      },
      //onSwipeLeft: ,
    );
  }
}
