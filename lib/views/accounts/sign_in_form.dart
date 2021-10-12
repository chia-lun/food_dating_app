import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_dating_app/views/accounts/sign_in_controller.dart';
import 'package:food_dating_app/widgets/input_text.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  SignInController signInController = new SignInController();
  String _email = '';
  String _password = '';

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 180.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/images/icon.jpg')),
              ),
            ),
            StreamBuilder(
              stream: signInController.emailStream,
              builder: (context, snapshot) => InputText(
                  title: 'Email',
                  controller: _textController,
                  errorText: snapshot.hasError ? snapshot.error.toString() : '',
                  icon: CupertinoIcons.envelope,
                  onValueChange: (value) {
                    _email = value;
                  }),
            ),
            StreamBuilder(
              stream: signInController.passwordStream,
              builder: (context, snapshot) => InputText(
                  title: 'Password',
                  controller: _textController,
                  errorText: snapshot.hasError ? snapshot.error.toString() : '',
                  icon: CupertinoIcons.lock,
                  onValueChange: (value) {
                    _password = value;
                  }),
            ),
            TextButton(
              onPressed: () {
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: const Text(
                'Forgot Password',
                style: TextStyle(color: Colors.orange, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            const Text('New User? Create Account')
          ],
        ),
      ),
    );
  }
}
