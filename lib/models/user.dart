import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import 'package:food_dating_app/widgets/utils.dart';

class User {
  final String idUser;
  final String name;
  //final String urlAvatar;

  const User({
    required this.idUser,
    required this.name,
    //required this.urlAvatar,
  });

  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
      'name': name,
      //'urlAvatar': urlAvatar,
    };
  }

  factory User.fromDocument(DocumentSnapshot doc) {
    String idUser = "";
    String name = "";
    //String urlAvatar = "";
    try {
      idUser = doc.get("idUser");
    } catch (e) {}
    try {
      name = doc.get("name");
    } catch (e) {}
    return User(idUser: idUser, name: name);
  }
}
