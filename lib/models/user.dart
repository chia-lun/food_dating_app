// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:meta/meta.dart';

// import 'package:food_dating_app/widgets/utils.dart';

// class User {
//   // late String fullname;
//   // late String username;
//   // late String password;

//   // late String age;

//   // late String restaurant;
//   // User(this.fullname, this.username, this.password, this.age, this.restaurant);

//   // User.fromJson(Map<String, dynamic> json) {
//   //   fullname = json['fullname'];
//   //   username = json['username'];
//   //   password = json['password'];
//   //   age = json['age'];
//   //   restaurant = json['restaurant'];
//   // }

//   // Map<String, dynamic> toJson() {
//   //   final Map<String, dynamic> data = new Map<String, dynamic>();
//   //   data['fullname'] = fullname;
//   //   data['username'] = username;
//   //   data['password'] = password;
//   //   data['age'] = age;
//   //   data['restaurant'] = restaurant;
//   //   return data;
//   final String idUser;
//   final String name;
//   //final String urlAvatar;

//   const User({
//     required this.idUser,
//     required this.name,
//     //required this.urlAvatar,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'idUser': idUser,
//       'name': name,
//       //'urlAvatar': urlAvatar,
//     };
//   }

//   factory User.fromDocument(DocumentSnapshot doc) {
//     String idUser = "";
//     String name = "";
//     //String urlAvatar = "";
//     try {
//       idUser = doc.get("idUser");
//     } catch (e) {}
//     try {
//       name = doc.get("name");
//     } catch (e) {}
//     return User(idUser: idUser, name: name);
//   }
//   String getid() {
//     return idUser;
//   }

//   String getname() {
//     return name;
//   }
// }
