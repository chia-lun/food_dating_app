import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';

// Update this part with Firebase later
final List data = [
  {
    'image': AssetImage('assets/images/ned1.jpg'),
    'title': Text("Ned Mayo, 20"),
    'subtitle': Text("French Meadow"),
  },
  {
    'image': AssetImage('assets/images/jiaying.jpg'),
    'title': Text("Jiaying Wu, 20"),
    'subtitle': Text("Shish"),
  },
  {
    'image': AssetImage('assets/images/james.jpg'),
    'title': Text("James, 20"),
    'subtitle': Text("Cafe Mac"),
  },
  {
    'image': AssetImage('assets/images/hari.jpg'),
    'title': Text("Hari,19"),
    'subtitle': Text("Cooking at 30 mac"),
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
      data[0]['title'],
      data[0]['subtitle'],
    ),
    Card(
      data[1]['image'],
      data[1]['title'],
      data[1]['subtitle'],
    ),
    Card(
      data[2]['image'],
      data[2]['title'],
      data[2]['subtitle'],
    ),
    Card(data[3]['image'], data[3]['title'], data[3]['subtitle'])
  ];

  @override
  Widget build(BuildContext context) {
    // Stack of cards that can be swiped. Set width, height, etc here.
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      // height: MediaQuery.of(context).size.width * 1.5,
      height: 500,
      // Important to keep as a stack to have overlay of cards.
      child: Stack(
        children: cards,
      ),
    );
  }
}

class Card extends StatelessWidget {
  final AssetImage image;
  final Text title;
  final Text subtitle;
  Card(this.image, this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Swipable(
        child: Column(
      children: [
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                image: DecorationImage(image: image, fit: BoxFit.cover)),
            child: ListTile(
              title: title,
              subtitle: subtitle,
            )),
      ],
    )
        // Set the swipable widget
        // child: Container(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(16.0),
        //     image: DecorationImage(
        //       image: image,
        //       fit: BoxFit.cover,
        //       alignment: Alignment.bottomCenter,
        //     ),
        //   ),
        // ),
        // child: ListTile(
        //       title: title,
        //       subtitle: subtitle,
        //     )
        // onSwipeRight, left, up, down, cancel, etc...
        );
  }
}
