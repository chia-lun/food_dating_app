import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_dating_app/models/app_user.dart';
import 'package:food_dating_app/models/user.dart';

class DatabaseService {
  final String uid;
  //const
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
    return await userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'name': name,
      'age': age,
      'restaurant': restaurant,
      'email': email,
      'password': password,
      'pfpDownloadURL': pfpDownloadURL,
      'id': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  // user list from snapshot
  Future<List<AppUser>> userListFromSnapShots() async {
    List<AppUser> listOfUsers = [];
    //snapshots.forEach((snapshot) {
    await FirebaseFirestore.instance.collection("user").get().then(
        (QuerySnapshot querySnapshot) => querySnapshot.docs.forEach((doc) {
              AppUser user = AppUser(
                  name: doc.get('name') ?? '',
                  age: doc.get('age') ?? 0,
                  restaurant: doc.get('restaurant') ?? '',
                  uid: doc.get('id') ?? '',
                  pfpDownloadURL: doc.get('pfpDownloadURL') ?? '');
              //print(doc.get('name'));
              listOfUsers.add(user);
            })); //{
    //map((doc) {
    //
    //   print(user.name);
    //   //print(doc.get('name'));
    // );
    // }
    //});
    // for (AppUser appUser in listOfUsers) {
    //   print(appUser.name);
    // }
    // print("lisyo "listOfUsers.isEmpty);
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

  // Stream<QuerySnapshot> getUserStream() {
  //   return FirebaseFirestore.instance.collection("user").snapshots();
  // }

  // // get user doc stream
  // Stream<AppUser> get userData {
  //   return userCollection.doc(uid).snapshots().map();
  // }
}
