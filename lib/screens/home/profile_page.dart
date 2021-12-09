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
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../swipe_message_profile.dart';
import 'package:food_dating_app/services/database.dart';
import '../../helpers/random_string.dart';
import 'package:provider/src/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

enum ImageSourceType { gallery, camera }

class _SignUpPageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late AuthProvider authProvider;

  late String myName;
  String myURL = '';
  String myRestaurant = '';

  // text field state
  String name = "";
  String restaurant = "";

  //Create a TextEditingController to retrieve the text a user has entered
  //into a text field
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final restaurantController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _image;
  late Image pfp;
  late String randomFileName;
  bool imageChanged = false;

  dynamic _pickImageError;
  bool isVideo = false;

  @override
  void initState() {
    getName();
    getRestaurant();
    getURL();
    super.initState();
    authProvider = context.read<AuthProvider>();
  }

  Future<void> getName() async {
    return await FirebaseFirestore.instance
        .collection("user")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((doc) => doc.get('name'))
        .then((name) {
      setState(() {
        myName = name;
      });
    });
  }

  Future<void> getRestaurant() async {
    return await FirebaseFirestore.instance
        .collection("user")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((doc) => doc.get('restaurant'))
        .then((restaurant) {
      setState(() {
        myRestaurant = restaurant;
      });
    });
  }

  Future<void> getURL() async {
    return await FirebaseFirestore.instance
        .collection("user")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((doc) => doc.get('pfpDownloadURL'))
        .then((pfpDownloadURL) {
      setState(() {
        myURL = pfpDownloadURL;
        pfp = Image.network(myURL);
      });
    });
  }

  Future pickImage() async {
    try {
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final pickedFileList = File(image.path);

      setState(() {
        _image = pickedFileList;
        pfp = Image.file(File(image.path));
        imageChanged = true;
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
                  child: Image(image: pfp.image, fit: BoxFit.contain)),
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
                onPressed: () async {
                  pickImage();
                }),
            TextFormField(
              //for future text call
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Enter your new name',
              ),
            ),
            TextFormField(
              //for future text call
              controller: restaurantController,
              decoration: const InputDecoration(
                hintText: 'Enter your new restaurant preference',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: MaterialButton(
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () async {
                    if (imageChanged) {
                      await uploadImage();
                      firebase_storage.Reference ref = firebase_storage
                          .FirebaseStorage.instance
                          .ref()
                          .child("pfps/$randomFileName.jpg");
                      String pfpDownloadURL =
                          (await ref.getDownloadURL()).toString();
                      DatabaseService(uid: _auth.currentUser!.uid)
                          .updateDoc("pfpDownloadURL", pfpDownloadURL);
                    }
                    if (nameController.text != myName) {
                      DatabaseService(uid: _auth.currentUser!.uid)
                          .updateDoc("name", nameController.text);
                    }
                    if (restaurantController.text != myRestaurant) {
                      DatabaseService(uid: _auth.currentUser!.uid)
                          .updateDoc("restaurant", restaurantController.text);
                    }
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //     builder: (context) => const SwipeMessageProfile()));
                    // We can have it refresh? instead
                  },
                  child: const Text(
                    'Update Profile Info',
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
