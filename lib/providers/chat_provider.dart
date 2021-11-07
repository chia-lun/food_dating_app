import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_dating_app/models/message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:NSUserDefaults/NSUserDefaults.dart';

class ChatProvider {
  final NSUserDefaults prefs;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  ChatProvider(
      {required this.firebaseFirestore,
      required this.prefs,
      required this.firebaseStorage});
  String? getPref(String key) {
    return prefs.getString(key);
  }

  UploadTask uploadFile(File image, String fileName) {
    Reference reference = firebaseStorage.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask;
  }

  Future<void> updateDataFirestore(String collectionPath, String docPath,
      Map<String, dynamic> dataNeedUpdate) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(docPath)
        .update(dataNeedUpdate);
  }

  Stream<QuerySnapshot> getChatStream(String groupChatId, int limit) {
    return firebaseFirestore
        .collection("messages")
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy("time", descending: true)
        .limit(limit)
        .snapshots();
  }

  void sendMessage(String content, int type, String groupChatId,
      String currentUserId, String peerId) {
    DocumentReference documentReference = firebaseFirestore
        .collection("message")
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());
    Message messageChat = Message(
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
