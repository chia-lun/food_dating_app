import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_dating_app/routes.dart';
import 'package:food_dating_app/views/login_signup_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'food_dating_app',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: FutureBuilder(
            future: _fbApp,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print('You have an error! ${snapshot.error.toString()}');
                return const Text('Something went wrong');
              } else if (snapshot.connectionState == ConnectionState.done) {
                return MaterialApp(
                  locale: DevicePreview.locale(context),
                  builder: DevicePreview.appBuilder,
                  initialRoute: initialRoute,
                  routes: routes,
                  //routes: (context)=> LoginSignupPage()
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }) //const MyHomePage(title: 'Flutter Demo Home Page'),

        );
  }
}
