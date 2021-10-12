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
      theme: NeumorphicThemeData(
        defaultTextColor: Color(0xFF3E3E3E),
        accentColor: Colors.grey,
        variantColor: Colors.black38,
        depth: -10,
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
  String firstName = "";
  String lastName = "";
  double age = 12;
  // Gender gender;
  Set<String> rides = Set();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 12, right: 12, top: 10),
              // child: TopBar(
              //   actions: <Widget>[
              //     ThemeConfigurator(),
              //   ],
              // ),
            ),
            Neumorphic(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              style: NeumorphicStyle(
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: NeumorphicButton(
                      onPressed: _isButtonEnabled() ? () {} : null,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  neumorphic_widgets.AvatarField(),
                  SizedBox(
                    height: 8,
                  ),
                  neumorphic_widgets.NTextField(
                    label: "First name",
                    hint: "",
                    onChanged: (firstName) {
                      setState(() {
                        this.firstName = firstName;
                      });
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  neumorphic_widgets.NTextField(
                    label: "Last name",
                    hint: "",
                    onChanged: (lastName) {
                      setState(() {
                        this.lastName = lastName;
                      });
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  neumorphic_widgets.AgeField(
                    age: this.age,
                    onChanged: (age) {
                      setState(() {
                        this.age = age;
                      });
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  // _GenderField(
                  //   gender: gender,
                  //   onChanged: (gender) {
                  //     setState(() {
                  //       this.gender = gender;
                  //     });
                  //   },
                  // ),
                  SizedBox(
                    height: 8,
                  ),
                  /*
                  _RideField(
                    rides: this.rides,
                    onChanged: (rides) {
                      setState(() {
                        this.rides = rides;
                      });
                    },
                  ),
                  SizedBox(
                    height: 28,
                  ),
                   */
                  SizedBox(
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
    return this.firstName.isNotEmpty && this.lastName.isNotEmpty;
  }
}
