import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_dating_app/services/firebase_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_dating_app/models/app_user.dart';
import 'package:food_dating_app/models/user.dart';
import 'package:food_dating_app/services/auth_provider.dart';
import 'package:food_dating_app/screens/authentication/signin_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:food_dating_app/widgets/swipe_message_profile.dart';
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

  //Create a TextEditingController to retrieve the text a user has entered
  //into a text field
  final nameController = TextEditingController();
  final ageController = TextEditingController();

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

  Future logout() async {
    await FirebaseAuth.instance.signOut().then((value) =>
        Navigator.of(context, rootNavigator: true).pushReplacement(
            MaterialPageRoute(builder: (context) => SignInPage())));
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
    final double screenWidth = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        height: MediaQuery.of(context).size.height - 20,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.05),
            GestureDetector(
              child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.grey[300],
                  child: Image(
                      image: pfp.image,
                      fit: BoxFit.fill,
                      alignment: Alignment.topRight)),
            ),
            MaterialButton(
                color: Colors.orange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  'Replace your profile image',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                onPressed: () async {
                  pickImage();
                }),
            // TextFormField(
            //   //for future text call
            //   initialValue: myName,
            //   decoration: const InputDecoration(
            //     enabled: false,
            //     labelText: 'Your current name: ',
            //     labelStyle: TextStyle(color: Colors.grey),
            //     focusedBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(color: Colors.orange),
            //     ),
            //   ),
            //   cursorColor: Colors.orange,
            //   style: TextStyle(color: Colors.orange),
            // ),
            TextFormField(
              //for future text call
              controller: nameController,
              decoration: const InputDecoration(
                //filled: true,
                //icon: Icon(Icons.person),
                labelText: 'Enter your new name here',
                labelStyle: TextStyle(color: Colors.grey),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
              cursorColor: Colors.orange,
            ),
            // TextFormField(
            //   //for future text call
            //   initialValue: myRestaurant,
            //   decoration: const InputDecoration(
            //     enabled: false,
            //     labelText: 'Your current preferred restaurant: ',
            //     labelStyle: TextStyle(color: Colors.grey),
            //     focusedBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(color: Colors.orange),
            //     ),
            //   ),
            //   cursorColor: Colors.orange,
            //   style: TextStyle(color: Colors.orange),
            // ),
            // const Text("                            ",
            //     style: TextStyle(color: Colors.grey, fontSize: 8),
            //     textAlign: TextAlign.start),
            const Text(
                "Enter your new restaurant here:                                       ",
                style: TextStyle(color: Colors.grey, fontSize: 12),
                textAlign: TextAlign.start),
            DropdownButton(
              hint: const Text("Select your restaurant"),
              isExpanded: true,
              onChanged: (newValue) {
                _selectedRestaurant = newValue.toString();
                setState(() {
                  _selectedRestaurant;
                });
              },
              items: _restaurant.map((restaurant) {
                return DropdownMenuItem(
                  value: restaurant,
                  child: Text(restaurant),
                );
              }).toList(),
              value: _selectedRestaurant,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: MaterialButton(
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
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
                      imageChanged = false;
                    }
                    if (nameController.text != myName &&
                        nameController.text.isNotEmpty) {
                      DatabaseService(uid: _auth.currentUser!.uid)
                          .updateDoc("name", nameController.text);
                    }
                    if (_selectedRestaurant != myRestaurant) {
                      DatabaseService(uid: _auth.currentUser!.uid)
                          .updateDoc("restaurant", _selectedRestaurant);
                    }
                    setState(() {
                      getName();
                      getRestaurant();
                    });
                  },
                  child: const Text(
                    'Update Profile Info',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )),
            ),
            SizedBox(height: size.height * 0.1),
            RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    text: 'Wanna take a break? ',
                    children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInPage()));
                        },
                      text: 'Log out.',
                      style: TextStyle(color: Colors.orange))
                ]))
          ],
        ),
      )),
    );
  }
}
