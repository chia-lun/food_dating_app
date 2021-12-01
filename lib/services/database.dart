import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_dating_app/models/app_user.dart';
import 'package:food_dating_app/models/user.dart';
import 'package:food_dating_app/models/match.dart';
import 'package:food_dating_app/models/swipe.dart';

class DatabaseService {
  final String uid;
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  //const
  var appUser;

  DatabaseService({
    required this.uid,
  });

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  // late CollectionReference swipeColletion = FirebaseFirestore.instance
  //     .collection('user')
  //     .doc("POpmAxUz9yMDJSUqKKfAqYOhMSh1")
  //     .collection("swipes");

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
  Future<List<AppUser>> userListFromSnapShots() async {
    List<AppUser> listOfUsers = [];
    //snapshots.forEach((snapshot) {
    await FirebaseFirestore.instance.collection("user").get().then(
        (QuerySnapshot querySnapshot) => querySnapshot.docs.forEach((doc) {
              AppUser user = AppUser(
                  name: doc.get('name') ?? '',
                  age: doc.get('age') ?? 0,
                  restaurant: doc.get('restaurant') ?? '',
                  uid: '',
                  pfpDownloadURL: doc.get('pfpDownloadURL') ?? '');
              //print(doc.get('name'));
              listOfUsers.add(user);
            })); //{
    return listOfUsers;
  }

  Future addMatch(String userId, Match match) async {
    await userCollection
        .doc(userId)
        .collection('matches')
        .doc(match.id)
        .set(match.toMap());
  }

  Future addSwipedUser(Swipe swipe) async {
    await userCollection.doc(uid).collection('swipes').add(swipe.toMap());
  }

  Future<DocumentSnapshot> getSwipe(String swipeId) {
    return FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('swipes')
        .doc(swipeId)
        .get();
  }

  Future<QuerySnapshot> getMatches() async {
    return await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('matches')
        .get();
  }

  Future<QuerySnapshot> getPersonsToMatchWith(
      int limit, List<String> ignoreIds) {
    return instance
        .collection('user')
        .where('id', whereNotIn: ignoreIds)
        .limit(limit)
        .get();
  }
}
