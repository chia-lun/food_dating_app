import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';

// Link to DB
final List data = [
  {
    'color': Colors.red,
    'image': Image.asset('assets/images/ned1.jpg', height: 500),
  },
  {
    'color': Colors.green,
    'image': Image.asset('assets/images/jiaying.jpg', height: 500),
  },
  {
    'color': Colors.blue,
    'image': Image.asset('assets/images/james.jpg', height: 500),
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
      data[0]['color'],
      data[0]['image'],
    ),
    Card(
      data[1]['color'],
      data[1]['image'],
    ),
    Card(
      data[2]['color'],
      data[2]['image'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Stack of cards that can be swiped. Set width, height, etc here.
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.7,
      // Important to keep as a stack to have overlay of cards.
      child: Stack(
        children: cards,
      ),
    );
  }
}

class Card extends StatelessWidget {
  final Image image;
  final Color color;
  Card(this.color, this.image);

  @override
  Widget build(BuildContext context) {
    return Swipable(
      // Set the swipable widget
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          image: DecorationImage(
            image: AssetImage('assets/images/ned1.jpg'),
            fit: BoxFit.cover,
          ),
          color: color,
        ),
      ),

      // onSwipeRight, left, up, down, cancel, etc...
    );
  }
}
