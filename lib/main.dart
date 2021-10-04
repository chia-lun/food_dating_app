import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp ({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.orange,
    ).copyWith(
      secondary: Colors.deepOrange,
    ),
    textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.black)),
  ),

      home: Scaffold(
        appBar: AppBar(title: Text('Fooder')),
        body: Center(
          child: Text('Hello'),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Colors.orange,
          child: Container(height: 70.0),
        )
      ));
  }
}