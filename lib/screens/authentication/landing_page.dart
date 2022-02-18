import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_dating_app/screens/authentication/signin_page.dart';
import 'package:food_dating_app/screens/authentication/signup_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
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
            color: Color.fromRGBO(0, 0, 0, 0.55),
          ),
          Container(
            margin: EdgeInsets.only(
                left: size.width * 0.08, bottom: size.width * 0.3),
            alignment: Alignment.topLeft,
            child: const Center(
              child: Text(
                'Food,             better than     ever before',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 50.0,
                    fontFamily: 'bold',
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(255, 255, 255, 1)),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                right: size.width * 0.45,
                top: size.height * 0.15,
                left: size.width * 0.1),
            alignment: Alignment.topLeft,
            child: const Center(
              child: Text(
                'We help you match with your food soul mate.',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 13.0, color: Color.fromRGBO(255, 255, 255, 1)),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: size.height * 0.05),
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaterialButton(
                    minWidth: size.width * 0.8,
                    height: size.width * 0.1,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          color: Color.fromRGBO(199, 16, 144, 1.0),
                          fontSize: 14,
                          fontWeight: FontWeight.w900),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInPage()));
                    }),
                SizedBox(height: size.height * 0.01),
                MaterialButton(
                    minWidth: size.width * 0.8,
                    height: size.width * 0.1,
                    color: const Color.fromRGBO(199, 16, 144, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Signup',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w900),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()));
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
