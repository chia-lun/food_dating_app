// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:food_dating_app/views/accounts/sign_in_controller.dart';
// import 'package:food_dating_app/widgets/input_text.dart';

// class SignInView extends StatefulWidget {
//   @override
//   _SignInViewState createState() => _SignInViewState();
// }

// class _SignInViewState extends State<SignInView> {
//   SignInController signInController = new SignInController();
//   String _email = '';
//   String _password = '';

//   final TextEditingController _textController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(top: 180.0),
//               child: Center(
//                 child: Container(
//                     width: 150,
//                     height: 150,
//                     /*decoration: BoxDecoration(
//                         color: Colors.red,
//                         borderRadius: BorderRadius.circular(50.0)),*/
//                     child: Image.asset('assets/images/icon.jpg')),
//               ),
//             ),
//             StreamBuilder(
//               stream: signInController.emailStream,
//               builder: (context, snapshot) => InputText(
//                   title: 'Email',
//                   controller: _textController,
//                   errorText: snapshot.hasError ? snapshot.error.toString() : '',
//                   icon: CupertinoIcons.envelope,
//                   onValueChange: (value) {
//                     _email = value;
//                   }),
//             ),
//             StreamBuilder(
//               stream: signInController.passwordStream,
//               builder: (context, snapshot) => InputText(
//                   title: 'Password',
//                   controller: _textController,
//                   errorText: snapshot.hasError ? snapshot.error.toString() : '',
//                   icon: CupertinoIcons.lock,
//                   onValueChange: (value) {
//                     _password = value;
//                   }),
//             ),
//             TextButton(
//               onPressed: () {
//                 //TODO FORGOT PASSWORD SCREEN GOES HERE
//               },
//               child: const Text(
//                 'Forgot Password',
//                 style: TextStyle(color: Colors.orange, fontSize: 15),
//               ),
//             ),
//             Container(
//               height: 50,
//               width: 150,
//               decoration: BoxDecoration(
//                   color: Colors.orange,
//                   borderRadius: BorderRadius.circular(20)),
//               child: TextButton(
//                 onPressed: () {},
//                 child: const Text(
//                   'Login',
//                   style: TextStyle(color: Colors.white, fontSize: 20),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 130,
//             ),
//             const Text('New User? Create Account')
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:food_dating_app/widgets/neumorphic_widgets.dart'
    as neumorphic_widgets;

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      theme: const NeumorphicThemeData(
        defaultTextColor: Color(0xFF3E3E3E),
        accentColor: Colors.orange,
        variantColor: Colors.orange,
        depth: -2,
        intensity: 0.4,
      ),
      themeMode: ThemeMode.light,
      child: Material(
        child: NeumorphicBackground(
          child: _SignInPage(),
        ),
      ),
    );
  }
}

class _SignInPage extends StatefulWidget {
  @override
  State<_SignInPage> createState() => _SignInPageState();
}

enum Gender { MALE, FEMALE, NON_BINARY }

class _SignInPageState extends State<_SignInPage> {
  String email = '';
  String password = '';
  //String name = "";
  //double age = 12;
  //String gender = "";
  // // Gender gender;
  //String restaurant = "";
  //Set<String> rides = Set();

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
                  Align(
                    alignment: Alignment.centerRight,
                    child: NeumorphicButton(
                      onPressed: _isButtonEnabled() ? () {} : null,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Text(
                        "New User? Create Account",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  neumorphic_widgets.AvatarField(),
                  const SizedBox(
                    height: 50,
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
                  const SizedBox(
                    height: 15,
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
                  Align(
                    alignment: Alignment.center,
                    child: NeumorphicButton(
                      onPressed: _isButtonEnabled() ? () {} : null,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 120,
                  ),
                  // neumorphic_widgets.NTextField(
                  //   label: "Name",
                  //   hint: "",
                  //   onChanged: (firstName) {
                  //     setState(() {
                  //       this.name = name;
                  //     });
                  //   },
                  // ),
                  // neumorphic_widgets.NTextField(
                  //   label: "Gener",
                  //   hint: "",
                  //   onChanged: (firstName) {
                  //     setState(() {
                  //       this.gender = gender;
                  //     });
                  //   },
                  // ),
                  // // const SizedBox(
                  // //   height: 8,
                  // // ),
                  // neumorphic_widgets.AgeField(
                  //   age: this.age,
                  //   onChanged: (age) {
                  //     setState(() {
                  //       this.age = age;
                  //     });
                  //   },
                  // ),
                  // const SizedBox(
                  //   height: 8,
                  // ),
                  // neumorphic_widgets.NTextField(
                  //   label: "Restaurant",
                  //   hint: "",
                  //   onChanged: (lastName) {
                  //     setState(() {
                  //       this.restaurant = restaurant;
                  //     });
                  //   },
                  // ),

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
    return this.email.isNotEmpty && this.password.isNotEmpty;
  }
}
