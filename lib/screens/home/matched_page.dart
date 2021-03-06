import 'package:flutter/material.dart';
import 'package:food_dating_app/widgets/rounded_button.dart';
import 'package:food_dating_app/widgets/rounded_outline_button.dart';
import 'package:provider/provider.dart';
import 'package:food_dating_app/models/app_user.dart';
import 'package:food_dating_app/widgets/portrait.dart';
import 'chat_screen.dart';

class MatchedScreen extends StatelessWidget {
  static const String id = 'matched_screen';

  final String myProfilePhotoPath;
  final String myUserId;
  final String otherUserProfilePhotoPath;
  final String otherUserId;

  MatchedScreen(
      {required this.myProfilePhotoPath,
      required this.myUserId,
      required this.otherUserProfilePhotoPath,
      required this.otherUserId});

  void sendMessagePressed(BuildContext context) async {
    AppUser user = AppUser(
        uid: myUserId,
        name: "",
        age: 0,
        restaurant: "restaurant",
        pfpDownloadURL: "");
    Navigator.pop(context);
    Navigator.pushNamed(context, ChatScreen.id, arguments: {
      // "chat_id": compareAndCombineIds(myUserId, otherUserId),
      "user_id": user.uid,
      "other_user_id": otherUserId
    });
  }

  void keepSwipingPressed(BuildContext context) {
    Navigator.of(context).pop();
    print('tets');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 42.0,
            horizontal: 18.0,
          ),
          margin: EdgeInsets.only(bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('MATCHED'),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Portrait(imageUrl: myProfilePhotoPath),
                    Portrait(imageUrl: otherUserProfilePhotoPath)
                  ],
                ),
              ),
              Column(
                children: [
                  // RoundedButton(
                  //     text: 'SEND MESSAGE',
                  //     onPressed: () {
                  //       sendMessagePressed(context);
                  //     }),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      //createChatDialog(context);
                      keepSwipingPressed(context);
                    },
                    child: const Text('   Keep Swiping   ',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.orange,
                      //minimumSize: const Size(30.0, 10.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
