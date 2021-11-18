import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_dating_app/api/firebase_api.dart';
import 'package:food_dating_app/widgets/input_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_dating_app/services/auth.dart';
import 'package:image_picker/image_picker.dart';

import '../../swipe_message_profile.dart';
import 'package:food_dating_app/services/database.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

enum ImageSourceType { gallery, camera }

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  // text field state
  String name = "";
  String age = "";
  String restaurant = "";
  String email = '';
  String password = '';

  //Create a TextEditingController to retrieve the text a user has entered
  //into a text field
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final restaurantController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _image;
  //XFile? _image;

  dynamic _pickImageError;
  bool isVideo = false;

  String getUserId() {
    final User? user = auth.currentUser;
    final userId = user!.uid;

    return userId;
  }

  // void _handleImage({required ImageSource source}) async {
  //   Navigator.pop(context);
  //   XFile? imageFile = await ImagePicker().pickImage(source: source);

  //   if (imageFile != null) {
  //     //imageFile = await _cropImage(imageFile: imageFile);
  //     setState(() {
  //       _image = imageFile;
  //     });
  //   }
  // }

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
    final destination = 'profiles/$pickedFileList';

    FirebaseApi.uploadFile(destination, _image!);
    // setState(() {});

    // if (task == null) return;

    // final snapshot = await task!.whenComplete(() {});
    // final urlDownload = await snapshot.ref.getDownloadURL();

    // print('Download-Link: $urlDownload');
  }

  // void _handleURLButtonPress(BuildContext context, var type) {
  //   Navigator.push(context,
  //       MaterialPageRoute(builder: (context) => ImageFromGalleryEx(type)));
  // }

  // void _showSelectImageDialog() {
  //   showCupertinoModalPopup(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return CupertinoActionSheet(
  //         title: const Text('Add Photo'),
  //         actions: <Widget>[
  //           CupertinoActionSheetAction(
  //             child: const Text('Take Photo'),
  //             onPressed: () => _handleImage(source: ImageSource.camera),
  //           ),
  //           CupertinoActionSheetAction(
  //             child: const Text('Choose From Gallery'),
  //             onPressed: () => _handleImage(source: ImageSource.gallery),
  //           )
  //         ],
  //         cancelButton: CupertinoActionSheetAction(
  //           child: const Text(
  //             'Cancel',
  //             style: TextStyle(color: Colors.redAccent),
  //           ),
  //           onPressed: () => Navigator.pop(context),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // get the screenWidth
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        height: MediaQuery.of(context).size.height - 50,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              // onTap: () {
              //   _showSelectImageDialog();
              // },
              child: Container(
                  height: screenWidth - 150,
                  width: screenWidth - 150,
                  color: Colors.grey[300],
                  child: _image == null
                      ? Icon(Icons.add_a_photo, color: Colors.white, size: 150)
                      : Image(
                          image: FileImage(File(_image!.path)),
                          fit: BoxFit.contain)),
            ),
            MaterialButton(
                color: Colors.orange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: const Text(
                  'Pick image from your gallery',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  pickImage();
                  uploadImage();
                }

                //onPressed: () => _handleURLButtonPress(context, ImageSourceType.gallery);
                ),
            TextFormField(
              //for future text call
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Enter your name',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              //for future text call
              controller: ageController,
              decoration: const InputDecoration(
                hintText: 'Enter your age',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              //for future text call
              controller: restaurantController,
              decoration: const InputDecoration(
                hintText: 'Enter your restaurant',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onChanged: (value) {
                setState(() => restaurant = value);
              },
            ),
            TextFormField(
              //for future text call
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please an email';
                }
                return null;
              },
              onChanged: (value) {
                setState(() => email = value);
              },
            ),
            TextFormField(
              //for future text call
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: 'Enter your password',
              ),
              validator: (String? value) {
                if (value == null || value.length < 6) {
                  return 'Enter vaild password with 6+ chars long';
                }
                return null;
              },
              onChanged: (value) {
                setState(() => password = value);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: MaterialButton(
                color: Colors.orange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {
                  DatabaseService(uid: getUserId()).addUser(
                      nameController.text,
                      int.parse(ageController.text),
                      restaurantController.text,
                      emailController.text,
                      passwordController.text);
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  // if (_formKey.currentState!.validate()) {
                  //   // Process data.
                  // }
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const SwipeMessageProfile()));
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
