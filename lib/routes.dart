// import 'package:food_dating_app/views/chat_screen.dart';
import 'package:food_dating_app/views/home_page.dart';
import 'package:food_dating_app/views/login_page.dart';
import 'package:food_dating_app/views/message_page.dart';
import 'package:food_dating_app/views/profile_page.dart';

const initialRoute = "login_page";

var routes = {
  'home_page': (context) => HomePage(),
  // 'chat_page': (context) => ChatPage(),
  'login_page': (context) => LoginPage(),
  'message_page': (context) => MessagePage(),
  'profile_page': (context) => ProfilePage()
};
