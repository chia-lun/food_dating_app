import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_dating_app/providers/auth_provider.dart';
import 'package:food_dating_app/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_dating_app/swipe_message_profile.dart';
import 'package:food_dating_app/services/database.dart';
import 'package:food_dating_app/screens/authentication/signup_page.dart';
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

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 220.0, left: 40, right: 40),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: 'Email'),
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: TextField(
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Password'),
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              },
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            MaterialButton(
                color: Colors.orange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: const Text(
                  'Signin anon',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                onPressed: () async {
                  dynamic result = await _auth.signInAnonymously();
                  if (result == null) {
                    print("error signing in");
                  } else {
                    print("signed in");
                    //print(result.uid);
                  }
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const SwipeMessageProfile()));
                }),
            MaterialButton(
                color: Colors.orange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: const Text(
                  'Signin',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                onPressed: () async {
                  _auth
                      .signInWithEmailAndPassword(
                          email: _email, password: _password)
                      .then((_) {
                    // Navigator.push(context,
                    //     MaterialPageRoute(
                    //         builder: (context) => SwipeMessageProfile()));

                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const SwipeMessageProfile()));
                  });
                  //print(auth.currentUser.toString());
                  //authProvider.handleSignIn();
                }),
            MaterialButton(
              color: Colors.orange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: const Text(
                'Signup',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
                // auth
                //     .createUserWithEmailAndPassword(
                //         email: _email, password: _password)
                //     .then((_) {
                //   // Navigator.of(context).pushReplacement(MaterialPageRoute(
                //   //     builder: (context) => const SwipeMessageProfile()));

                // });
              },
            )
          ])
        ],
      ),
    );
  }
}
