//import 'package:food_dating_app/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_dating_app/models/user_model.dart';

class Message {
  String groupChatID;
  String senderID;
  String receiverID;
  String
      time; // Would usually be type DateTime or Firebase Timestamp in production apps
  String text;

  Message(
      {required this.groupChatID,
      required this.senderID,
      required this.receiverID,
      required this.time,
      required this.text,
      String? idUser});

  Map<String, dynamic> toJson() {
    return {
      "groupChatID": this.groupChatID,
      "senderID": this.senderID,
      "receiverID": this.receiverID,
      "time": this.time,
      "text": this.text,
    };
  }

  factory Message.fromDocument(DocumentSnapshot doc) {
    String groupChatID = (doc.get("groupChatID"));
    String senderID = (doc.get("senderID"));
    String receiverID = (doc.get("receiverID"));
    String time = (doc.get("time"));
    String text = (doc.get("text"));
    return Message(
        groupChatID: groupChatID,
        senderID: senderID,
        receiverID: receiverID,
        time: time,
        text: text);
  }
}
