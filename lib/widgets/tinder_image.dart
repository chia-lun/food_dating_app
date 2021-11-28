import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';

// Update this part with Firebase later
final List data = [
  {
    'image': Image.network(
        'https://firebasestorage.googleapis.com/v0/b/food-dating-app-1ef3f.appspot.com/o/ned1.jpg?alt=media&token=010c3652-2c28-47fa-ac0b-405a852ef55c'),
    'title': const Text("Ned Mayo, 20"),
    'subtitle': const Text("French Meadow"),
  },
  {
    'image': Image.network(
        'https://firebasestorage.googleapis.com/v0/b/food-dating-app-1ef3f.appspot.com/o/jiaying.jpg?alt=media&token=f139075c-c764-4aca-bef2-549f89f8287c'),
    'title': const Text("Jiaying Wu, 20"),
    'subtitle': const Text("Shish"),
  },
  {
    'image': Image.network(
        'https://firebasestorage.googleapis.com/v0/b/food-dating-app-1ef3f.appspot.com/o/james.jpg?alt=media&token=37933011-41af-47ac-a19f-235c7fb2f4fe'),
    'title': const Text("James, 20"),
    'subtitle': const Text("Cafe Mac"),
  },
  {
    'image': Image.network(
        'https://firebasestorage.googleapis.com/v0/b/food-dating-app-1ef3f.appspot.com/o/hari.jpg?alt=media&token=7c0d1056-ffd5-4d2c-b340-933fbdae82e9'),
    'title': const Text("Hari,19"),
    'subtitle': const Text("Cooking at 30 mac"),
  }
];

class TinderImage extends StatefulWidget {
  @override
  _TinderImageState createState() => _TinderImageState();
}

class _TinderImageState extends State<TinderImage> {
  // Dynamically load cards from database
  List<Card> cards = [
    Card(
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
      height: MediaQuery.of(context).size.width * 1.5,
      // width: 240,
      // height: 300,
      // Important to keep as a stack to have overlay of cards.
      child: Stack(
        children: cards,
      ),
      // child: StreamBuilder<List<Card>>(
      //       stream: cards,
      //       builder: (context, snapshot) {
      //         if (!snapshot.hasData) return SizedBox();
      //         final data = snapshot.data;
      //         return Stack(
      //           children: data!,
      //         );
      //       },
      //     ),
    );
  }
}

class Card extends StatelessWidget {
  final Image image;
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
              image: DecorationImage(
                image: image.image,
                fit: BoxFit.fill,
                alignment: Alignment.bottomCenter,
              ),
            ),
            child: Text(title.toString()),
          ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Swipable(
  //     child: Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(16.0),
  //         image: DecorationImage(
  //           image: image.image,
  //           fit: BoxFit.cover,
  //           alignment: Alignment.bottomCenter,
  //         ),
  //       ),
  //       child: title,
  //     ),
  //     //onSwipeRight, left, up, down, cancel, etc...
  //   );
  // }
}
