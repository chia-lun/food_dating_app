import 'package:flutter/material.dart';

/// Author: Hengrui Jia
/// This is the message page

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
