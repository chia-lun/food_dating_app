// import 'package:flutter/material.dart';
// import 'package:flutter_swipable/flutter_swipable.dart';
// import 'package:food_dating_app/models/message_model.dart';

// final List data = [
//   {
//     'title': "Ned Mayo, 20",
//     //'subtitle': Text("French Meadow"),
//   },
//   {
//     'title': "Jiaying Wu, 20",
//     //'subtitle': Text("Shish"),
//   },
//   {
//     'title': Text("he"),
//     //'subtitle': Text("Cafe Mac"),
//   },
//   {
//     'title': "Hari,19",
//     //'subtitle': Text("Cooking at 30 mac"),
//   }
// ];

// class tinderText extends StatefulWidget {
//   @override
//   _tinderTextState createState() => _tinderTextState();
// }

// class _tinderTextState extends State<tinderText> {
//   List<Text> texts = [
//     Text(
//       data[0]['title'],
//       //data[0]['subtitle'],
//     ),
//     Text(
//       data[1]['title'],
//       //data[1]['subtitle'],
//     ),
//     Text(
//       data[2]['title'],
//       //data[2]['subtitle'],
//     ),
//     Text(
//       data[3]['title'],
//       // data[3]['subtitle']
//     )
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width * 0.9,
//       height: MediaQuery.of(context).size.width * 0.3,
//       child: Stack(
//         children: texts,
//       ),
//     );
//   }
// }

// class Text extends StatelessWidget {
//   final Text title;
//   //final Text subtitle;
//   Text(this.title, int i);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ListTile(title: title)
//       ],
//     );
//   }
// }
