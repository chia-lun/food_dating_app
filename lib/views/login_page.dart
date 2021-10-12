import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_dating_app/views/accounts/sign_in_controller.dart';
import 'package:food_dating_app/views/accounts/sign_up_controller.dart';
import 'package:food_dating_app/views/accounts/sign_in_form.dart';
import 'package:food_dating_app/views/accounts/sign_up_form.dart';
import 'package:food_dating_app/routes.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    if (Auth.FirebaseAuth.instance.currentUser!.uid != '') {
      Navigator.pushNamed(context, 'sign_in');
    } else {
      Navigator.pushNamed(context, 'sign_in');
    }
    return Row();
  }
}


// class _LoginPageWidgetState extends State<LoginPage> {
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
