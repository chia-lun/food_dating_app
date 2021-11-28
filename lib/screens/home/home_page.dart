//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:food_dating_app/widgets/tinder_image.dart';
// import 'package:food_dating_app/screens/home/chat_screen.dart';
// import 'package:food_dating_app/screens/home/message_page.dart';
import 'package:food_dating_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:food_dating_app/screens/home/user_list.dart';
import 'package:food_dating_app/models/app_user.dart';
//import 'package:food_dating_app/tinder_text.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

/// This is the private State class that goes with HomePage.
class _HomePageState extends State<HomePage> {
  final auth = FirebaseAuth.instance;

  //This is the chat pop-up dialog function
  createChatDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Dinner?"),
            content: TextField(
              controller: customController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text("Go"),
                onPressed: () {
                  Navigator.of(context).pop(customController.text.toString());
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<User>>.value(
        value: DatabaseService().appUser,
        initialData: [],
        child: Scaffold(
          body: Column(children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(bottom: 40),
            ),
            Container(
                margin: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TinderImage(),
                  ],
                )),
            const Padding(
              padding: EdgeInsets.only(bottom: 15),
            ),
            TextButton(
              onPressed: () {
                createChatDialog(context);
              },
              child: const Text('Chat',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              style: TextButton.styleFrom(
                backgroundColor: Colors.orange,
                //minimumSize: const Size(30.0, 10.0),
              ),
            )
          ]),
        ));
  }
}
