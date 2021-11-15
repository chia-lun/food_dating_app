import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  //method to update an existing user
  Future updateUser(String name, int age, String restaurant) async {
    return await userCollection
        .doc(uid)
        .set({'name': name, 'age': age, 'restaurant': restaurant});
  }

  //method to add a new user
  Future addUser(String name, int age, String restaurant, String email,
      String password) async {
    return await userCollection.add({
      'name': name,
      'age': age,
      'restaurant': restaurant,
      'email': email,
      'password': password
    });
  }
}
