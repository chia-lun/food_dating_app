// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart' as Auth;
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:food_dating_app/models/user.dart' as User;

// class SignUpController {
//   StreamController _isEmail = new StreamController();
//   StreamController _isPassword = new StreamController();
//   StreamController _isBtnLoading = new StreamController();

//   Stream get emailStream => _isEmail.stream;
//   Stream get passwordStream => _isPassword.stream;
//   Stream get btnLoadingstream => _isBtnLoading.stream;

//   Future<String> onSubmitSignIn(
//       {required String email, required String password}) async {
//     Auth.FirebaseAuth auth = Auth.FirebaseAuth.instance;
//     String result = '';
//     try {
//       Auth.FirebaseAuth firebaseUser = (await auth.signInWithEmailAndPassword(
//               email: email, password: password))
//           .user as Auth.FirebaseAuth;
//       String uid = firebaseUser.currentUser!.uid;
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(uid)
//           .get()
//           .then((DocumentSnapshot snapshot) {
//         User.User? user = User.User(
//             (snapshot.data() as dynamic)['fullname'],
//             (snapshot.data() as dynamic)['username'],
//             (snapshot.data() as dynamic)['password'],
//             (snapshot.data() as dynamic)['gender'],
//             (snapshot.data() as dynamic)['birthday'],
//             (snapshot.data() as dynamic)['phone'],
//             (snapshot.data() as dynamic)['address'],
//             (snapshot.data() as dynamic)['create_at'],
//             (snapshot.data() as dynamic)['type']);
//         print(user.toJson());
//       });
//     } catch (e) {
//       _isBtnLoading.sink.add(true);
//     }
//     _isBtnLoading.sink.add(true);
//     return result;
//   }
// }
