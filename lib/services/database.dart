import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_dating_app/models/app_user.dart';
import 'package:food_dating_app/models/user.dart';

class DatabaseService {
  final String uid;

  var appUser;
  DatabaseService({
    required this.uid,
  });

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

  // user list from snapshot
  List<AppUser>? userListFromSnapShots(Stream<QuerySnapshot> snapshots) {
    List<AppUser>? listOfUsers = [];
    snapshots.forEach((snapshot) {
      snapshot.docs.map((doc) {
        listOfUsers.add(AppUser(
            //idUser: doc.data['idUser'],
            name: doc.get('name') ?? '',
            age: doc.get('age') ?? 0,
            restaurant: doc.get('restaurant') ?? '',
            uid: ''));
      });
    });
    return listOfUsers;
    // return snapshots.docs.map((doc) {
    //   return AppUser(
    //       //idUser: doc.data['idUser'],
    //       name: doc.get('name') ?? '',
    //       age: doc.get('age') ?? 0,
    //       restaurant: doc.get('restaurant') ?? '',
    //       uid: '');
    // }).toList();
  }

  Stream<QuerySnapshot> getUserStream() {
    return FirebaseFirestore.instance.collection("user").snapshots();
  }

  // // get user doc stream
  // Stream<AppUser> get userData {
  //   return userCollection.doc(uid).snapshots().map();
  // }
}
