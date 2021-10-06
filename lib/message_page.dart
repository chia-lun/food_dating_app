/// Author: Hengrui Jia
/// This is the message page
///

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange)),
      title: "MessagePage",
      home: MessagePage(),
    );
  }
}

class MessagePage extends StatefulWidget {
  @override
  MessagePageState createState() => MessagePageState();
}

class MessagePageState extends State<MessagePage> {
  final _contactList = <String>["Steve", "Peter"];

  //final _contactList = Set<String>();
  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, item) {
          if (item.isOdd) return Divider();

          final index = item ~/ 2;

          return _buildRow(_contactList[index]);
        });
  }

  Widget _buildRow(String contactName) {
    return ListTile(title: Text(contactName, style: TextStyle(fontSize: 18.0)));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('ContactList')), body: _buildList());
  }
}
