import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  Future updateUser(String name, int age, String restaurant) async {
    return await userCollection
        .doc(uid)
        .set({'name': name, 'age': age, 'restaurant': restaurant});
  }
}