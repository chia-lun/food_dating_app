import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';

// Update this part with Firebase later
final List data = [
  {
    //'color': Colors.red,
    'image': AssetImage('assets/images/ned1.jpg'),
  },
  {
    //'color': Colors.green,
    'image': AssetImage('assets/images/jiaying.jpg'),
  },
  {
    //'color': Colors.blue,
    'image': AssetImage('assets/images/ned2.jpg'),
  }
];

class Tinder extends StatefulWidget {
  @override
  _TinderState createState() => _TinderState();
}

class _TinderState extends State<Tinder> {
  // Dynamically load cards from database
  List<Card> cards = [
    Card(
      //data[0]['color'],
      data[0]['image'],
    ),
    Card(
      //data[1]['color'],
      data[1]['image'],
    ),
    Card(
      //data[2]['color'],
      data[2]['image'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Stack of cards that can be swiped. Set width, height, etc here.
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.width * 1.5,
      // Important to keep as a stack to have overlay of cards.
      child: Stack(
        children: cards,
      ),
    );
  }
}

class Card extends StatelessWidget {
  final AssetImage image;
  //final Color color;
  Card(this.image);

  @override
  Widget build(BuildContext context) {
    return Swipable(
      // Set the swipable widget
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          image: DecorationImage(
            image: image,
            fit: BoxFit.cover,
          ),
          //color: color,
        ),
      ),

      // onSwipeRight, left, up, down, cancel, etc...
    );
  }
}
