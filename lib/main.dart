import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_dating_app/providers/auth_provider.dart';
import 'package:food_dating_app/providers/chat_provider.dart';
import 'package:food_dating_app/routes.dart';
// import 'package:food_dating_app/screens/authentication/signin_page.dart';
// import 'package:provider/provider.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MyApp());
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatefulWidget {
  final SharedPreferences prefs;
  MyApp({required this.prefs});

  @override
  _MyAppState createState() => _MyAppState(prefs);
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  SharedPreferences prefs;
  _MyAppState(this.prefs);

  //final SharedPreferences prefs = prefs;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
            create: (_) => AuthProvider(
                firebaseAuth: FirebaseAuth.instance,
                prefs: prefs,
                firebaseFirestore: firebaseFirestore),
          ),
          Provider<ChatProvider>(
            create: (_) => ChatProvider(
              prefs: prefs,
              firebaseFirestore: this.firebaseFirestore,
              firebaseStorage: this.firebaseStorage,
            ),
          )
        ],
        child: MaterialApp(
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
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }) //const MyHomePage(title: 'Flutter Demo Home Page'),

            ));
  }
//}
}
