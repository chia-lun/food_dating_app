import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_dating_app/models/message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatProvider {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  ChatProvider(
      {required this.firebaseFirestore,
      required this.prefs,
      required this.firebaseStorage});
  String? getPref(String key) {
    return prefs.getString(key);
  }

  Future<void> updateDataFirestore(String collectionPath, String docPath,
      Map<String, dynamic> dataNeedUpdate) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(docPath)
        .update(dataNeedUpdate);
  }

  Stream<QuerySnapshot> getChatStream(String groupChatID, int limit) {
    return firebaseFirestore
        .collection("messages") //message
        .doc(groupChatID)
        .collection(groupChatID)
        .orderBy("time", descending: true)
        .limit(limit)
        .snapshots();
  }

  void sendMessage(
      String content, String groupChatId, String currentUserId, String peerId) {
    DocumentReference documentReference = firebaseFirestore
        .collection("messages") //message
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());
    Message messageChat = Message(
      groupChatID: groupChatId,
      senderID: currentUserId,
      receiverID: peerId,
      time: DateTime.now().millisecondsSinceEpoch.toString(),
      text: content,
    );
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        messageChat.toJson(),
      );
    });
  }
}
