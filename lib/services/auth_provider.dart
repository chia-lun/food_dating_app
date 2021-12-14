import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_dating_app/models/app_user.dart';
//import 'package:food_dating_aoo/constants/constants.dart';
//import 'package:food_dating_app/models/.dart';
import 'package:food_dating_app/models/user.dart' as model;
import 'package:food_dating_app/services/database.dart';
//import 'package:google_sign_in/google_sign_in.dart';

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
  final FirebaseAuth auth = FirebaseAuth.instance;
  Status _status = Status.uninitialized;

  Status get status => _status;

  AuthProvider({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  Stream<QuerySnapshot> getStreamFireStore(
      String pathCollection, int limit, List<String> id) {
    return firebaseFirestore
        .collection(pathCollection)
        .limit(limit)
        .where('id', whereIn: id)
        .snapshots();
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      print(error.toString());
    }
  }
}
