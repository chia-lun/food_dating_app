import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_dating_app/models/app_user.dart';
import 'package:food_dating_app/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  //method to update an existing user
  Future updateUser(
      String name, int age, String restaurant, String pfpDownloadURL) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'age': age,
      'restaurant': restaurant,
      'pfpDownloadURL': pfpDownloadURL
    });
  }

  //method to add a new user
  Future addUser(String name, int age, String restaurant, String email,
      String password, String pfpDownloadURL) async {
    return await userCollection.add({
      'name': name,
      'age': age,
      'restaurant': restaurant,
      'email': email,
      'password': password,
      'pfpDownloadURL': pfpDownloadURL,
    });
  }

  //user list from snapshot
  List<User>? _userListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return User(
          idUser: doc.data['idUser'],
          name: doc.data['name'] ?? '',
          age: doc.data['age'] ?? 0,
          restaurant: doc.data['restaurant'] ?? '');
    }).toList();
  }

  //get user stream
  Stream<User> get user {
    return userCollection.snapshots().map(_userListFromSnapShot);
  }
}
