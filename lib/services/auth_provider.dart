import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_dating_app/models/app_user.dart';
import 'package:food_dating_app/services/database.dart';

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
  final Status _status = Status.uninitialized;
  //late AppUser _user;
  Future<AppUser> get user => _getUser();

  Status get status => _status;

  AuthProvider({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  Stream<QuerySnapshot>? getStreamFireStore(
      String pathCollection, int limit, List<String> id) {
    if (id.isNotEmpty) {
      return firebaseFirestore
          .collection(pathCollection)
          .limit(limit)
          .where('id', whereIn: id)
          .snapshots();
    }
    return null;
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //User? user = result.user;
      // create a new document for the user with the uid
      //await DatabaseService(uid: user!.uid).updateUser('Uma', 1, 'Petco', '');
      return _getUser();
    } catch (error) {
      print(error.toString());
    }
  }

  Future<AppUser> _getUser() async {
    //if (_user.getId()!= null) return _user;
    String id = FirebaseAuth.instance.currentUser!.uid;
    print(AppUser.fromDocument(await DatabaseService(uid: id).getUser()).name);
    return AppUser.fromDocument(await DatabaseService(uid: id).getUser());
  }
}
