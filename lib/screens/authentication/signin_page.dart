import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_dating_app/services/auth_provider.dart';
import 'package:food_dating_app/widgets/swipe_message_profile.dart';
import 'package:food_dating_app/screens/authentication/signup_page.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  static String tag = 'signin-page';

  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageWidgetState();
}

class _SignInPageWidgetState extends State<SignInPage> {
  late String _email, _password;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    //AuthProvider authProvider = Provider.of<AuthProvider>(context);
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
            left: size.width * 0.04),
        alignment: Alignment.centerLeft,
        child: const Center(
          child: Text(
            'Welcome back',
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
        margin:
            EdgeInsets.only(right: size.width * 0.45, left: size.width * 0.1),
        alignment: Alignment.centerLeft,
        child: const Center(
          child: Text(
            'I know you missed me, xoxo.',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 13.0, color: Color.fromRGBO(255, 255, 255, 1)),
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
              child: TextField(
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  border: InputBorder.none,
                ),
                cursorColor: const Color.fromRGBO(255, 255, 255, 0.75),
                onChanged: (value) => {
                  setState(() {
                    _email = value.trim();
                  })
                },
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
                child: TextField(
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    border: InputBorder.none,
                  ),
                  cursorColor: const Color.fromRGBO(255, 255, 255, 0.75),
                  onChanged: (value) => {
                    setState(() {
                      _password = value.trim();
                    })
                  },
                ),
              ),
            ],
          )),
      Container(
          margin: EdgeInsets.only(
              right: size.width * 0.1,
              bottom: size.height * 0.15,
              left: size.width * 0.1),
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MaterialButton(
                  minWidth: size.width * 1,
                  height: size.width * 0.12,
                  color: const Color.fromRGBO(199, 16, 144, 1.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
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
                      text: 'Don\'t have an Account?',
                      children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()));
                          },
                        text: ' Sign Up Now',
                        style: const TextStyle(
                            color: Color.fromRGBO(225, 16, 144, 1.0)))
                  ]))
            ],
          ))
    ]));
  }
}
