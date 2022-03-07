import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_dating_app/screens/authentication/preference_page.dart';
import 'package:food_dating_app/screens/authentication/signin_page.dart';
import 'package:food_dating_app/services/auth_provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthProvider _authService = AuthProvider(
      firebaseAuth: FirebaseAuth.instance,
      firebaseFirestore: FirebaseFirestore.instance);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/landing_page.jpeg"),
          ),
        ),
      ),
      Container(
        color: const Color.fromRGBO(0, 0, 0, 0.55),
      ),
      Container(
        margin: EdgeInsets.only(
            right: size.width * 0.1,
            bottom: size.height * 0.1,
            left: size.width * 0.1),
        alignment: Alignment.centerLeft,
        child: const Center(
          child: Text(
            'Create your account',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 40.0,
                fontFamily: 'bold',
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(255, 255, 255, 1)),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(
            right: size.width * 0.1,
            bottom: size.height * 0.35,
            left: size.width * 0.1),
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () => {},
              color: const Color.fromRGBO(255, 255, 255, 0.35),
              minWidth: size.width * 1,
              height: size.width * 0.1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                //for future text call
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  border: InputBorder.none,
                ),
                validator: (String? value) {
                  if (value == null && EmailValidator.validate(value!)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
                cursorColor: const Color.fromRGBO(255, 255, 255, 0.75),
              ),
            ),
          ],
        ),
      ),
      Container(
          margin: EdgeInsets.only(
              right: size.width * 0.1,
              bottom: size.height * 0.27,
              left: size.width * 0.1),
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () => {},
                color: const Color.fromRGBO(255, 255, 255, 0.35),
                minWidth: size.width * 1,
                height: size.width * 0.1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextFormField(
                  controller: passwordController,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Enter your password',
                    border: InputBorder.none,
                  ),
                  validator: (String? value) {
                    if (value == null || value.length < 6) {
                      // create more for security later
                      return 'Enter min. 6 characters';
                    }
                    return null;
                  },
                  cursorColor: const Color.fromRGBO(255, 255, 255, 0.75),
                ),
              ),
            ],
          )),
      Container(
          margin: EdgeInsets.only(
              right: size.width * 0.1,
              bottom: size.height * 0.2,
              left: size.width * 0.1),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                  text: TextSpan(
                      style: const TextStyle(color: Colors.white),
                      text: "Let's add some personal preference.",
                      children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PreferencePage()));
                          },
                        text: ' Start here',
                        style: const TextStyle(
                            color: Color.fromRGBO(225, 16, 144, 1.0)))
                  ]))
            ],
          )),
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
                      text: "Already have an account?",
                      children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInPage()));
                          },
                        text: ' Log In',
                        style: const TextStyle(
                            color: Color.fromRGBO(225, 16, 144, 1.0)))
                  ]))
            ],
          )),
      Container(),
    ]));
  }
}
