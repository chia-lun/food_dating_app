// import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:food_dating_app/services/auth.dart';
import 'package:food_dating_app/swipe_message_profile.dart';
import 'package:food_dating_app/screens/authentication/signin_page.dart';
import 'package:food_dating_app/widgets/neumorphic_widgets.dart'
    as neumorphic_widgets;

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      themeMode: ThemeMode.light,
      theme: const NeumorphicThemeData(
        baseColor: Color(0xFFFFFFFF),
        lightSource: LightSource.topLeft,
        accentColor: Colors.orange,
        variantColor: Colors.black38,
        depth: 10,
      ),
      darkTheme: const NeumorphicThemeData(
        baseColor: Color(0xFF3E3E3E),
        lightSource: LightSource.topLeft,
        depth: 6,
      ),
      child: Material(
        child: NeumorphicBackground(
          child: _Page(),
        ),
      ),
    );
  }
}

class _Page extends StatefulWidget {
  @override
  __PageState createState() => __PageState();
}

enum Gender { MALE, FEMALE, NON_BINARY }

class __PageState extends State<_Page> {
  String email = '';
  String password = '';
  String name = "";
  double age = 18;
  String gender = "";
  // // Gender gender;
  String restaurant = "";
  Set<String> rides = Set();

  //for signout
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
            ),
            Neumorphic(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              style: NeumorphicStyle(
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(13)),
              ),
              child: Column(
                children: <Widget>[
                  Align(
                      alignment: Alignment.bottomRight,
                      child: NeumorphicButton(
                        onPressed: () async {
                          await _auth.signOut();

                          /// _logoutStatus = true;
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => SignInPage()));
                        },
                        child: const Text("logout"),
                      )),
                  neumorphic_widgets.AvatarField(),
                  const SizedBox(
                    height: 8,
                  ),
                  neumorphic_widgets.NTextField(
                    label: "Email",
                    hint: "",
                    // hint: FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser!.uid).get().doc("age").toString(),
                    onChanged: (email) {
                      setState(() {
                        this.email = email;
                      });
                    },
                  ),
                  neumorphic_widgets.NTextField(
                    label: "Password",
                    hint: "",
                    onChanged: (password) {
                      setState(() {
                        this.password = password;
                      });
                    },
                  ),
                  neumorphic_widgets.NTextField(
                    label: "Name",
                    hint: "",
                    onChanged: (name) {
                      setState(() {
                        this.name = name;
                      });
                    },
                  ),
                  neumorphic_widgets.NTextField(
                    label: "Gender",
                    hint: "",
                    onChanged: (gener) {
                      setState(() {
                        this.gender = gender;
                      });
                    },
                  ),
                  neumorphic_widgets.AgeField(
                    age: this.age,
                    onChanged: (age) {
                      setState(() {
                        this.age = age;
                      });
                    },
                  ),
                  neumorphic_widgets.NTextField(
                    label: "Restaurant",
                    hint: "",
                    onChanged: (restaurant) {
                      setState(() {
                        this.restaurant = restaurant;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool _isButtonEnabled() {
    //return this.firstName.isNotEmpty && this.lastName.isNotEmpty;
    return this.name.isNotEmpty;
  }
}
