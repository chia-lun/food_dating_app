import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_dating_app/helpers/random_string.dart';
import 'package:food_dating_app/services/auth_provider.dart';
import 'package:food_dating_app/services/firebase_api.dart';
import 'package:food_dating_app/widgets/swipe_message_profile.dart';
import 'package:image_picker/image_picker.dart';

class PicturePage extends StatefulWidget {
  const PicturePage({Key? key}) : super(key: key);

  @override
  State<PicturePage> createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile picture'),
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0.9),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.93)),
            ),
            Container(),
            Container(),
            Container(),
            Container(),
            Container(
                margin: EdgeInsets.only(
                    right: size.width * 0.1,
                    bottom: size.height * 0.05,
                    left: size.width * 0.1),
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(
                            style: const TextStyle(color: Colors.white),
                            text: 'You are ready to go!',
                            children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SwipeMessageProfile()));
                                },
                              text: ' Go!',
                              style: const TextStyle(
                                  color: Color.fromRGBO(225, 16, 144, 1.0)))
                        ]))
                  ],
                ))
          ],
        ));
  }
}
