import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_dating_app/views/accounts/sign_in_controller.dart';
import 'package:food_dating_app/views/accounts/sign_up_controller.dart';
import 'package:food_dating_app/views/accounts/sign_in_form.dart';
import 'package:food_dating_app/views/accounts/sign_up_form.dart';
import 'package:food_dating_app/routes.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:food_dating_app/swipe_message_profile.dart';

class LoginSignupPage extends StatefulWidget {
  //const LoginSignupPage({Key? key}) : super(key: key);

  @override
  State<LoginSignupPage> createState() => _LoginSignupPageWidgetState();
}

class _LoginSignupPageWidgetState extends State<LoginSignupPage> {
  late String _email, _password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(title: const Text('Login'),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(  
                hintText: 'Email'
              ),
               onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:[
            ElevatedButton(
              //color: Theme.of(context).accentColor,
              child: const Text('Signin'),
              onPressed: (){
                  auth.signInWithEmailAndPassword(email: _email, password: _password).then((_){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SwipeMessageProfile()));
                  });
                  
            }),
            ElevatedButton( 
              //color: Theme.of(context).accentColor,
              child: const Text('Signup'),
              onPressed: (){
                auth.createUserWithEmailAndPassword(email: _email, password: _password).then((_){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SwipeMessageProfile()));
                });
                
              },
            )
          ])
        ],),
    );
  }
}


// class _LoginSignupPageWidgetState extends State<LoginSignupPage> {
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
