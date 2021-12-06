import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_dating_app/api/firebase_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_dating_app/models/app_user.dart';
import 'package:food_dating_app/models/user.dart';
import 'package:food_dating_app/providers/auth_provider.dart';
import 'package:food_dating_app/services/auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:provider/src/provider.dart';
import '../../swipe_message_profile.dart';
import 'package:food_dating_app/services/database.dart';
import '../../helpers/random_string.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

enum ImageSourceType { gallery, camera }

class _SignUpPageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String myId = '';
  String myUsername = '';
  String myUrlAvatar = '';

  // void inputData() {
  //   final User user = _auth.currentUser;
  //   Future<DocumentSnapshot<Map<String, dynamic>>> snap =
  //       FirebaseFirestore.instance.collection('Users').doc(user!.uid).get();
  //   // String myId = snap['uid'];
  //   // String myUsername = snap['name'];
  //   // String myUrlAvatar = snap['avatarurl'];
  //   setState(() {
  //     name = user.displayName!;
  //   });
  // }

  final AuthService _authService = AuthService();
  late AuthProvider authProvider;

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
  late String randomFileName;
  //XFile? _image;

  dynamic _pickImageError;
  bool isVideo = false;

  @override
  void initState() {
    super.initState();

    authProvider = context.read<AuthProvider>();
  }

  // String getUserId() {
  //   final User? user = _auth.currentUser;
  //   final userId = user!.uid;

  //   return userId;
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
    randomFileName = generateRandomString(10);

    return FirebaseApi.uploadFile(randomFileName, _image!);
  }

  @override
  Widget build(BuildContext context, DocumentSnapshot document) {
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
              child: Container(
                  height: screenWidth - 150,
                  width: screenWidth - 150,
                  color: Colors.grey[300],
                  child: _image == null
                      ? const Icon(Icons.add_a_photo,
                          color: Colors.white, size: 150)
                      : Image(
                          image: FileImage(File(_image!.path)),
                          fit: BoxFit.contain)),
            ),
            MaterialButton(
                color: Colors.orange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: const Text(
                  'Replace your profile image',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  pickImage();
                }),
            TextFormField(
              //for future text call
              // initialValue:
              //Controller: nameController,
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
              initialValue: AppUser.fromDocument(document).getAge().toString(),
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
              //initialValue: '${document.get('restaurant')}',
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
              //initialValue: '${document.get('email')}',
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
              //initialValue: '${document.get('password')}',
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
                  onPressed: () async {
                    _authService.registerWithEmailAndPassword(email, password);
                    await uploadImage();
                    firebase_storage.Reference ref = firebase_storage
                        .FirebaseStorage.instance
                        .ref()
                        .child("profiles$randomFileName.jpg");
                    String pfpDownloadURL =
                        (await ref.getDownloadURL()).toString();
                    DatabaseService(uid: AppUser.fromDocument(document).getId())
                        .addUser(
                      nameController.text,
                      int.parse(ageController.text),
                      restaurantController.text,
                      emailController.text,
                      passwordController.text,
                      pfpDownloadURL,
                    );
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
                  )),
            )
          ],
        ),
      )),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
