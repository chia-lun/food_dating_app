/// Author: Hengrui Jia
/// This is the message page
///

import 'package:flutter/material.dart';
import 'package:food_dating_app/models/message_model.dart';

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
  Widget _buildList() {
    return ListView.builder(
        itemCount: chats.length,
        itemBuilder: (BuildContext context, int index) {
          final Message chat = chats[index];
          return Row(
            children: <Widget>[
              CircleAvatar(
                radius: 35.0,
                backgroundImage: AssetImage(chat.sender.imageUrl),
              ),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    chat.sender.name,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Text(
                      chat.text,
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('ContactList')), body: _buildList());
  }
}
