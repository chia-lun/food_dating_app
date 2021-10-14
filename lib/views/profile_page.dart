// import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:food_dating_app/widgets/neumorphic_widgets.dart'
    as neumorphic_widgets;

//import 'package:card_settings/card_settings.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({Key? key}) : super(key: key);

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//         navigationBar: CupertinoNavigationBar(
//           middle: Text(
//             "Profile Setting",
//             textAlign: TextAlign.justify,
//           ),
//         ),
//         child: CupertinoTextField(
//           placeholder: "HEllo",
//         ));
//   }
// }

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      theme: const NeumorphicThemeData(
        defaultTextColor: Color(0xFF3E3E3E),
        accentColor: Colors.orange,
        variantColor: Colors.black38,
        depth: 2,
        intensity: 0.5,
      ),
      themeMode: ThemeMode.light,
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
  double age = 12;
  String gender = "";
  // // Gender gender;
  String restaurant = "";
  Set<String> rides = Set();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
              // child: TopBar(
              //   actions: <Widget>[
              //     ThemeConfigurator(),
              //   ],
              // ),
            ),
            Neumorphic(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              style: NeumorphicStyle(
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 8,
                  ),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: NeumorphicButton(
                  //     onPressed: _isButtonEnabled() ? () {} : null,
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 20, vertical: 20),
                  //     child: Text(
                  //       "Sign Up",
                  //       style: TextStyle(fontWeight: FontWeight.w800),
                  //     ),
                  //   ),
                  // ),
                  neumorphic_widgets.AvatarField(),
                  const SizedBox(
                    height: 8,
                  ),
                  neumorphic_widgets.NTextField(
                    label: "Email",
                    hint: "",
                    onChanged: (firstName) {
                      setState(() {
                        this.email = email;
                      });
                    },
                  ),
                  neumorphic_widgets.NTextField(
                    label: "Password",
                    hint: "",
                    onChanged: (firstName) {
                      setState(() {
                        this.password = password;
                      });
                    },
                  ),
                  neumorphic_widgets.NTextField(
                    label: "Name",
                    hint: "",
                    onChanged: (firstName) {
                      setState(() {
                        this.name = name;
                      });
                    },
                  ),
                  neumorphic_widgets.NTextField(
                    label: "Gender",
                    hint: "",
                    onChanged: (firstName) {
                      setState(() {
                        this.gender = gender;
                      });
                    },
                  ),
                  // const SizedBox(
                  //   height: 8,
                  // ),
                  neumorphic_widgets.AgeField(
                    age: this.age,
                    onChanged: (age) {
                      setState(() {
                        this.age = age;
                      });
                    },
                  ),
                  // const SizedBox(
                  //   height: 8,
                  // ),
                  neumorphic_widgets.NTextField(
                    label: "Restaurant",
                    hint: "",
                    onChanged: (lastName) {
                      setState(() {
                        this.restaurant = restaurant;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // _RideField(
                  //   rides: this.rides,
                  //   onChanged: (rides) {
                  //     setState(() {
                  //       this.rides = rides;
                  //     });
                  //   },
                  // ),
                  // SizedBox(
                  //   height: 28,
                  // ),

                  // SizedBox(
                  //   height: 20,
                  // ),
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
