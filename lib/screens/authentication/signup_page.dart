import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_dating_app/services/firebase_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_dating_app/services/auth_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../swipe_message_profile.dart';
import 'package:food_dating_app/services/database.dart';
import '../../helpers/random_string.dart';
import 'package:food_dating_app/services/restaurant_database.dart'
    as restaurant_data;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

enum ImageSourceType { gallery, camera }

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthProvider _authService = AuthProvider(
      firebaseAuth: FirebaseAuth.instance,
      firebaseFirestore: FirebaseFirestore.instance);

  //Create a TextEditingController to retrieve the text a user has entered
  //into a text field
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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

  String _selectedRestaurant = "Estelle";

  final List<String> _restaurant = [
    "Groveland Tap",
    "Estelle",
    "Tono Pizzeria + Cheesecakes",
    "Simplicitea",
    "Nashville Coop",
    "Starbucks",
    "Chip’s Clubhouse",
    "Hot Hands Pie & Biscuit",
    "Roots Roasting",
    "Caribou",
    "Nothing Bundt Cakes",
    "Breadsmith",
    "Jamba",
    "St Paul Cheese Shop",
    "Khyber Pass Cafe",
    "Dunn Bros",
    "Pad Thai Restaurant",
    "French Meadow",
    "Shish",
    "The Italian Pie Shoppe",
    "Grand Catch",
    "St Paul Meat Shop",
    "Sencha",
    "Indochin"
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        height: MediaQuery.of(context).size.height - 50,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: size.height * 0.10),
            GestureDetector(
              child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.grey[300],
                  child: _image == null
                      ? const Icon(Icons.add_a_photo,
                          color: Colors.white, size: 150)
                      : Image(
                          image: FileImage(File(_image!.path)),
                          fit: BoxFit.fill)),
            ),
            MaterialButton(
                color: Colors.orange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  'Pick image from your gallery',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  pickImage();
                }

                //onPressed: () => _handleURLButtonPress(context, ImageSourceType.gallery);
                ),
            TextFormField(
              //for future text call
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Enter your name',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
              cursorColor: Colors.orange,
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
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              cursorColor: Colors.orange,
            ),
            DropdownButton(
              hint: const Text("Select your restaurant"),
              isExpanded: true,
              onChanged: (newValue) {
                _selectedRestaurant = newValue.toString();
              },
              items: _restaurant.map((restaurant) {
                return DropdownMenuItem(
                  value: restaurant,
                  child: Text(restaurant),
                );
              }).toList(),
              value: _selectedRestaurant,
            ),
            TextFormField(
              //for future text call
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please an email';
                }
                return null;
              },
              cursorColor: Colors.orange,
            ),
            TextFormField(
              //for future text call
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: 'Enter your password',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
              validator: (String? value) {
                if (value == null || value.length < 6) {
                  return 'Enter vaild password with 6+ chars long';
                }
                return null;
              },
              cursorColor: Colors.orange,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: MaterialButton(
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () async {
                    _authService.registerWithEmailAndPassword(
                        emailController.text, passwordController.text);
                    await uploadImage();
                    firebase_storage.Reference ref = firebase_storage
                        .FirebaseStorage.instance
                        .ref()
                        .child("pfps/$randomFileName.jpg");
                    String pfpDownloadURL =
                        (await ref.getDownloadURL()).toString();
                    DatabaseService(uid: getUserId()).addUser(
                      nameController.text,
                      int.parse(ageController.text),
                      _selectedRestaurant,
                      emailController.text,
                      passwordController.text,
                      pfpDownloadURL,
                    );
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const SwipeMessageProfile()));
                  },
                  child: const Text(
                    '     SUBMIT     ',
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
