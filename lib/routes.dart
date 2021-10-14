// import 'package:food_dating_app/views/chat_screen.dart';
import 'package:food_dating_app/app.dart';
import 'package:food_dating_app/views/accounts/sign_in_controller.dart';
import 'package:food_dating_app/views/accounts/sign_up_form.dart';
import 'package:food_dating_app/views/home_page.dart';
import 'package:food_dating_app/views/login_page.dart';
import 'package:food_dating_app/views/message_page.dart';
import 'package:food_dating_app/views/profile_page.dart';
import 'package:food_dating_app/views/accounts/sign_in_form.dart';

const initialRoute = "app";

var routes = {
  'home_page': (context) => HomePage(),
  // 'chat_page': (context) => ChatPage(),
  // 'login_page': (context) => LoginPage(),
  'message_page': (context) => MessagePage(),
  'profile_page': (context) => ProfilePage(),
  'sign_in': (context) => SignInPage(),
  'sign_up': (context) => SignUpPage(),
  'app': (context) => App()
};
