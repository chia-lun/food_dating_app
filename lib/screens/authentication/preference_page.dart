import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_dating_app/helpers/random_string.dart';
import 'package:food_dating_app/screens/authentication/picture_page.dart';
import 'package:food_dating_app/services/auth_provider.dart';
import 'package:food_dating_app/services/firebase_api.dart';
import 'package:image_picker/image_picker.dart';

class PreferencePage extends StatefulWidget {
  const PreferencePage({Key? key}) : super(key: key);

  @override
  State<PreferencePage> createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthProvider _authService = AuthProvider(
      firebaseAuth: FirebaseAuth.instance,
      firebaseFirestore: FirebaseFirestore.instance);

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _image;
  late String randomFileName;
  //XFile? _image;

  dynamic _pickImageError;
  bool isVideo = false;

  String getUserId() {
    final User? user = _auth.currentUser;
    final userId = user!.uid;

    return userId;
  }

  Future pickImage() async {
    try {
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final pickedFileList = File(image.path);

      setState(() {
        _image = pickedFileList;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Future uploadImage() async {
    if (_image == null) return;

    final pickedFileList = File(_image!.path);
    randomFileName = generateRandomString(10);

    return FirebaseApi.uploadFile(randomFileName, _image!);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Personal Information'),
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0.9),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.93)),
            ),
            Container(
                margin: EdgeInsets.only(
                    right: size.width * 0.1,
                    top: size.height * 0.05,
                    left: size.width * 0.1),
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                        text: const TextSpan(
                      style: TextStyle(color: Colors.white),
                      text: "Name",
                    ))
                  ],
                )),
            Container(
              margin: EdgeInsets.only(
                  right: size.width * 0.1,
                  top: size.height * 0.08,
                  left: size.width * 0.1),
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () => {},
                    color: const Color.fromRGBO(255, 255, 255, 0.35),
                    minWidth: size.width * 1,
                    height: size.width * 0.1,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                          topLeft: Radius.circular(0.0),
                          bottomLeft: Radius.circular(20.0)),
                    ),
                    child: TextFormField(
                      controller: nameController,
                      validator: (String? value) {
                        if (value == null && value!.isEmpty) {
                          return 'Enter valid name';
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        hintText: 'Name',
                        border: InputBorder.none,
                      ),
                      cursorColor: const Color.fromRGBO(255, 255, 255, 0.75),
                    ),
                  ),
                ],
              ),
            ),
            Container(),
            Container(),
            Container(),
            Container(),
            Container(
                margin: EdgeInsets.only(
                    right: size.width * 0.1,
                    bottom: size.height * 0.05,
                    left: size.width * 0.1),
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(
                            style: const TextStyle(color: Colors.white),
                            text: 'Let\'s add your pictures',
                            children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PicturePage()));
                                },
                              text: ' here',
                              style: const TextStyle(
                                  color: Color.fromRGBO(225, 16, 144, 1.0)))
                        ]))
                  ],
                ))
          ],
        ));
  }
}
