import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Fooder';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.orange,
        ),
      ),
      title: _title,
      home: const MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(bottom: 15),
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
                    child: Image.asset('assets/images/NedOne.JPG',
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
        TextButton(
          onPressed: () {},
          child: const Text('Chat',
              style: TextStyle(fontSize: 20, color: Colors.white)),
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pages),
            label: 'Pages',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
