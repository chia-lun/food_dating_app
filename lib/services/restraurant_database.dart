import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantDatabase {
  final FirebaseFirestore instance = FirebaseFirestore.instance;

  final CollectionReference restaurantCollection =
      FirebaseFirestore.instance.collection('restaurant');

  final listOfRestaurants = [
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

  Future fillRestaurantsIfEmpty() async {
    for (String name in listOfRestaurants) {
      restaurantCollection
          .doc(name)
          .set({"name": name}, SetOptions(merge: true));
    }
  }

  
}
