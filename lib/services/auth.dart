import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_dating_app/models/app_user.dart';
import 'package:food_dating_app/providers/auth_provider.dart';
import 'package:food_dating_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  // TODO
  AppUser? _userFromFirebaseUser(User user) {
    return user != null
        ? AppUser(
            uid: user.uid,
            name: "uma",
            age: 10,
            restaurant: "restaurant",
            pfpDownloadURL: '')
        : null;
  }

  // // auth change user stream
  // Stream<User> get user {
  //   return _auth.authStateChanges().map((User user) => _userFromFirebaseUser(user));
  // }

  Stream<User?> get onAuthStateChanged => _auth.authStateChanges();

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      //FirebaseFirestore.instance.collection("user").doc()
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      // create a new document for the user with the uid
      await DatabaseService(uid: user!.uid).updateUser('Uma', 1, 'Petco', '');
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
