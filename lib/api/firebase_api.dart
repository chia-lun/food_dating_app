import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseApi {
  static UploadTask? uploadFile(String randomFileName, File file) {
    try {
      final ref = FirebaseStorage.instance.ref("pfps/$randomFileName.jpg");

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static UploadTask? uploadBytes(String randomFileName, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(randomFileName);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
