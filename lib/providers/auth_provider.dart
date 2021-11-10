import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:food_dating_aoo/constants/constants.dart';
//import 'package:food_dating_app/models/.dart';
import 'package:food_dating_app/models/user.dart' as model;
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  authenticateError,
  authenticateCanceled,
}

class AuthProvider extends ChangeNotifier {
  //final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final SharedPreferences prefs;
  final FirebaseAuth auth = FirebaseAuth.instance;
  Status _status = Status.uninitialized;

  Status get status => _status;

  AuthProvider({
    required this.firebaseAuth,
    //required this.googleSignIn,
    required this.prefs,
    required this.firebaseFirestore,
  });

  String? getUserFirebaseId() {
    return prefs.getString("id");
  }

  // Future<bool> isLoggedIn() async {
  //  bool isLoggedIn = await firebaseAuth.
  //   if (isLoggedIn && prefs.getString("id")?.isNotEmpty == true) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  Future<bool> handleSignIn() async {
    // _status = Status.authenticating;
    // notifyListeners();

    // GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    // if (googleUser != null) {
    //   GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
    //   final AuthCredential credential = GoogleAuthProvider.credential(
    //     accessToken: googleAuth.accessToken,
    //     idToken: googleAuth.idToken,
    //   );

    // User? firebaseUser = (await firebaseAuth.signInWithCredential(credential)).user;
    User? firebaseUser = auth.currentUser;
    if (firebaseUser != null) {
      final QuerySnapshot result = await firebaseFirestore
          .collection("users")
          .where("id", isEqualTo: firebaseUser.uid)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.length == 0) {
        // Writing data to server because here is a new user
        firebaseFirestore.collection("users").doc(firebaseUser.uid).set({
          "name": firebaseUser.displayName,
          //FirestoreConstants.photoUrl: firebaseUser.photoURL,
          "id": firebaseUser.uid,
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
          "chattingwith": null
        });

        // Write data to local storage
        User? currentUser = firebaseUser;
        await prefs.setString("id", currentUser.uid);
        await prefs.setString("name", currentUser.displayName ?? "");
        //await prefs.setString(FirestoreConstants.photoUrl, currentUser.photoURL ?? "");
      } else {
        // Already sign up, just get data from firestore
        DocumentSnapshot documentSnapshot = documents[0];
        model.User userChat = model.User.fromDocument(documentSnapshot);
        // Write data to local
        await prefs.setString("id", userChat.idUser);
        await prefs.setString("name", userChat.name);

        //   await prefs.setString(FirestoreConstants.photoUrl, userChat.photoUrl);
        //   await prefs.setString(FirestoreConstants.aboutMe, userChat.aboutMe);
      }
      _status = Status.authenticated;
      notifyListeners();
      return true;
    } else {
      _status = Status.authenticateError;
      notifyListeners();
      return false;
    }
  }

  //  else {
  //   _status = Status.authenticateCanceled;
  //   notifyListeners();
  //   return false;
  // }
}


  // Future<void> handleSignOut() async {
  //   _status = Status.uninitialized;
  //   await firebaseAuth.signOut();
  //   await googleSignIn.disconnect();
  //   await googleSignIn.signOut();
  // }
//}