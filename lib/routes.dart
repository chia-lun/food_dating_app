// import 'package:food_dating_app/views/chat_screen.dart';
// ignore: avoid_web_libraries_in_flutter
//import 'dart:js';

import 'package:food_dating_app/swipe_message_profile.dart';
import 'package:food_dating_app/screens/home/home_page.dart';
import 'package:food_dating_app/screens/authentication/signin_page.dart';
import 'package:food_dating_app/screens/home/message_page.dart';
import 'package:food_dating_app/screens/home/profile_page.dart';

const initialRoute = "login_signup_page";

var routes = {
  //'chat_page': (context) => ChatPage(),
  //'login_page': (context) => LoginPage(),
  //'sign_in': (context) => SignInView(),

  //swipe_message_profile is the page that allows users to navigate between
  //swipe page (home page), message page (where they can see people
  //who messaged) and profile page (where they can modify their settings)
  'swipe_message_profile': (context) => const SwipeMessageProfile(),

  //login_signup_page is the page that users use to sign up or log in, after
  //either sign up bottom or log in bottom is on press, they will be navigated
  //to swipe_message_profile page
  'login_signup_page': (context) => SignInPage()
};
