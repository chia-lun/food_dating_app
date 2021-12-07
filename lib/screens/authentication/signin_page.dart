import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_dating_app/providers/auth_provider.dart';
import 'package:food_dating_app/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_dating_app/swipe_message_profile.dart';
import 'package:food_dating_app/services/database.dart';
import 'package:food_dating_app/screens/authentication/signup_page.dart';
import 'package:food_dating_app/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageWidgetState();
}

class _SignInPageWidgetState extends State<SignInPage> {
  late String _email, _password;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.10),
          Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Colors.white,
              image: DecorationImage(
                fit: BoxFit.fill,
                image:
                    AssetImage("assets/images/Clink_logo_by_Sawyer_Neske.png"),
              ),
            ),
          ),
          // SizedBox(height: size.height * 0.05),
          // Image.asset(
          //   "assets/images/Clink_logo_by_Sawyer_Neske.png",
          //   fit: BoxFit.fitWidth,
          //   width: 220.0,
          //   alignment: Alignment.bottomCenter,
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(50.0),
          // child: TextField(
          SizedBox(height: size.height * 0.05),
          SizedBox(
            width: size.width * 0.75,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Email',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
              cursorColor: Colors.orange,
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: TextField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
              cursorColor: Colors.orange,
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              },
            ),
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // MaterialButton(
                //     color: Colors.orange,
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(30)),
                //     child: const Text(
                //       'Signin anon',
                //       style: TextStyle(
                //           color: Colors.white, fontWeight: FontWeight.w600),
                //     ),
                //     onPressed: () async {
                //       dynamic result = await _auth.signInAnonymously();
                //       if (result == null) {
                //         print("error signing in");
                //       } else {
                //         print("signed in");
                //         //print(result.uid);
                //       }
                //       Navigator.of(context).pushReplacement(MaterialPageRoute(
                //           builder: (context) => const SwipeMessageProfile()));
                //     }),
                MaterialButton(
                    color: Colors.orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      '                             SIGNIN                             ',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                    onPressed: () async {
                      _auth
                          .signInWithEmailAndPassword(
                              email: _email, password: _password)
                          .then((_) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const SwipeMessageProfile()));
                      });
                    }),
                SizedBox(height: size.height * 0.20),
                MaterialButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    'Don\'t have an Account? Signup now',
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                )
              ])
        ],
      ),
    );
  }
}


// class _SignInPageWidgetState extends State<SignInPage> {
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
//                     width: 200,
//                     height: 150,
//                     /*decoration: BoxDecoration(
//                         color: Colors.red,
//                         borderRadius: BorderRadius.circular(50.0)),*/
//                     child: Image.asset('assets/images/icon.jpg')),
//               ),
//             ),
//             const Padding(
//               padding:
//                   EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
//               //padding: EdgeInsets.symmetric(horizontal: 15),
//               child: TextField(
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Email',
//                     hintText: 'Enter valid email id as abc@gmail.com'),
//               ),
//             ),
//             const Padding(
//               padding:
//                   EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
//               //padding: EdgeInsets.symmetric(horizontal: 15),
//               child: TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Password',
//                     hintText: 'Enter secure password'),
//               ),
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
//               width: 250,
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
