import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:food_dating_app/widgets/neumorphic_widgets.dart';

// class homePage extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return NeumorphicApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Neumorphic App',
//       themeMode: ThemeMode.light,
//       theme: const NeumorphicThemeData(
//         baseColor: Color(0xFFFFFFFF),
//         lightSource: LightSource.topLeft,
//         depth: 10,
//       ),
//       darkTheme: const NeumorphicThemeData(
//         baseColor: Color(0xFF3E3E3E),
//         lightSource: LightSource.topLeft,
//         depth: 6,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => __PageState();
// }

// class __PageState extends State<MyHomePage> {

//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     )
// }

// class HomePage extends StatelessWidget {
//   HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return NeumorphicTheme(
//       themeMode: ThemeMode.light,
//       theme: const NeumorphicThemeData(
//         baseColor: Color(0xFFFFFFFF),
//         lightSource: LightSource.topLeft,
//         accentColor: Colors.orange,
//         variantColor: Colors.black38,
//         depth: 10,
//       ),
//       darkTheme: const NeumorphicThemeData(
//         baseColor: Color(0xFF3E3E3E),
//         lightSource: LightSource.topLeft,
//         depth: 6,
//       ),
//       child: Material(
//         child: NeumorphicBackground(
//           child: _Page(),
//         ),
//       ),
//     );
//   }
// }

// class _Page extends StatefulWidget {
//   @override
//   __PageState createState() => __PageState();
// }

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Neumorphic(
//       style: NeumorphicStyle(
//           shape: NeumorphicShape.concave,
//           boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
//           depth: 20,
//           lightSource: LightSource.topLeft,
//           color: Colors.orange),
//       child: NeumorphicButton(

//       )
//     );
//   }
// }

// This is the stateful widget that the main application instantiates.
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

/// This is the private State class that goes with HomePage.
class _HomePageState extends State<HomePage> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(bottom: 40),
        ),
        Container(
          margin: const EdgeInsets.all(20.0),
          child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: InkWell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Image.asset('assets/images/ned1.jpg',
                        height: 500, fit: BoxFit.cover),
                  ),
                  const ListTile(
                    title: Text("Ned Mayo, 20"), // this could be static later
                    subtitle:
                        Text("French Meadow"), // this could be static later
                  )
                ],
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 15),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Chat',
              style: TextStyle(fontSize: 18, color: Colors.white)),
          // style: TextButton.styleFrom(
          //   //padding: const EdgeInsets.all(16.0),
          //   primary: Colors.white,
          //   textStyle: const TextStyle(fontSize: 20),
          //   backgroundColor: Colors.orange,

          // ),
          style: TextButton.styleFrom(
            backgroundColor: Colors.orange,
            //minimumSize: const Size(30.0, 10.0),
          ),
        )
      ]),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.orange,
      //   onTap: (int index) {
      //     _selectTab(pageKeys[index], index);
      //   },
      //   currentIndex: _selectedIndex,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.message),
      //       label: 'Message',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: 'Settings',
      //     ),
      //   ],
      //   selectedItemColor: Colors.white,
      //   //onTap: _onItemTapped,
      // ),
    );
  }
}
