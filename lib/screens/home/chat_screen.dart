import 'dart:io';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_dating_app/constants/color_constants.dart';
import 'package:food_dating_app/models/message.dart';
import 'package:food_dating_app/models/user_model.dart' as model;
import 'package:food_dating_app/providers/auth_provider.dart';
import 'package:food_dating_app/providers/chat_provider.dart';
import 'package:food_dating_app/views/login_signup_page.dart';
import 'package:provider/src/provider.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  final model.User user;

  ChatScreen({Key? key, required this.user}) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState(
        user: user,
      );
}

class ChatScreenState extends State<ChatScreen> {
  ChatScreenState({required this.user});
  model.User user;
  final FirebaseAuth auth = FirebaseAuth.instance;
  late String currentUserId;
  late ChatProvider chatProvider;
  late AuthProvider authProvider;

  List<QueryDocumentSnapshot> listMessage = [];
  int _limit = 20;
  int _limitIncrement = 20;
  String groupChatID = "";
  String userID = "";

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    chatProvider = context.read<ChatProvider>();
    authProvider = context.read<AuthProvider>();
    //focusNode.addListener(onFocusChange);
    listScrollController.addListener(_scrollListener);
    readLocal();
  }

  _scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange &&
        _limit <= listMessage.length) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  _buildMessage(Message message, bool isMe) {
    final Container msg = Container(
      margin: isMe
          ? const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 80.0,
            )
          : const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: isMe ? Theme.of(context).accentColor : Color(0xFFFFEFEE),
        borderRadius: isMe
            ? const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.time,
            style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            message.text,
            style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,
      ],
    );
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.photo),
              iconSize: 25.0,
              color: Theme.of(context).primaryColor,
              onPressed: () {} //onSendMessage(textEditingController.text),
              ),
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              onSubmitted: (value) {
                onSendMessage(textEditingController.text);
              },
              style:
                  TextStyle(color: ColorConstants.primaryColor, fontSize: 15),
              controller: textEditingController,
              decoration: InputDecoration.collapsed(
                hintText: 'Type your message...',
                hintStyle: TextStyle(color: ColorConstants.greyColor),
              ),
              focusNode: focusNode,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () => onSendMessage(textEditingController.text),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          widget.user.name,
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: WillPopScope(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[buildListMessage(), _buildMessageComposer()],
              )
            ],
          ),
          onWillPop: onBackPress),
      // body: GestureDetector(
      //   onTap: () => FocusScope.of(context).unfocus(),
      //   child: Column(
      //     children: <Widget>[
      //       Expanded(
      //         child: Container(
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.only(
      //               topLeft: Radius.circular(30.0),
      //               topRight: Radius.circular(30.0),
      //             ),
      //           ),
      //           child: ClipRRect(
      //               borderRadius: BorderRadius.only(
      //                 topLeft: Radius.circular(30.0),
      //                 topRight: Radius.circular(30.0),
      //               ),
      //               child: buildListMessage()),
      //         ),
      //       ),
      //       _buildMessageComposer(),
      //     ],
      //   ),
      // ),
    );
  }

  Future<bool> onBackPress() {
    // if (isShowSticker) {
    //   setState(() {
    //     isShowSticker = false;
    //   });
    // } else {
    chatProvider.updateDataFirestore(
      'users',
      currentUserId,
      {'chattingWith': null},
    );
    Navigator.pop(context);
    //}

    return Future.value(false);
  }

  void readLocal() {
    //print("if this method is a decor");
    if //(authProvider.getUserFirebaseId()?.isNotEmpty == true) {
        (auth.currentUser != null) {
      //print("check if runs");
      currentUserId =
          auth.currentUser!.uid; //authProvider.getUserFirebaseId()!;

    } else {
      //print("check if runs");
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginSignupPage()),
          (Route<dynamic> route) => false,
        );
      });
    }
    userID = user.id;
    if (currentUserId.compareTo(user.id) > 0) {
      groupChatID = '$currentUserId+$userID';
      print(userID);
    } else {
      groupChatID = '$userID+$currentUserId';
      print(userID);
    }

    chatProvider.updateDataFirestore(
      "users",
      currentUserId,
      {'chattingWith': user.id},
    );
  }

  void onSendMessage(String content) {
    if (content.trim().isNotEmpty) {
      textEditingController.clear();
      chatProvider.sendMessage(content, groupChatID, currentUserId, user.id);
      listScrollController.animateTo(0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  Widget buildListMessage() {
    return Flexible(
      child: groupChatID.isNotEmpty
          ? StreamBuilder<QuerySnapshot>(
              stream: chatProvider.getChatStream(groupChatID, _limit),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  listMessage = snapshot.data!.docs;
                  if (listMessage.length > 0) {
                    return ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context, index) =>
                          buildItem(index, snapshot.data?.docs[index]),
                      itemCount: snapshot.data?.docs.length,
                      reverse: true,
                      controller: listScrollController,
                    );
                  } else {
                    return Center(child: Text("No message here yet..."));
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorConstants.themeColor,
                    ),
                  );
                }
              },
            )
          : Center(
              child: CircularProgressIndicator(
                color: ColorConstants.themeColor,
              ),
            ),
    );
  }

  Widget buildItem(int index, DocumentSnapshot? documentSnapshot) {
    if (documentSnapshot != null) {
      Message message = Message.fromDocument(documentSnapshot);
      if (message.receiverID == currentUserId) {
        return Row(
          children: <Widget>[
            Container(
              child: Text(
                message.text,
                style: TextStyle(color: ColorConstants.primaryColor),
              ),
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              width: 200,
              decoration: BoxDecoration(color: ColorConstants.greyColor),
              margin: EdgeInsets.only(bottom: 20),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        );
      } else {
        return Container(
            child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    message.text,
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  width: 200,
                  decoration: BoxDecoration(
                      color: ColorConstants.primaryColor,
                      borderRadius: BorderRadius.circular(8)),
                  margin: EdgeInsets.only(left: 10),
                )
              ],
            )
          ],
        ));
      }
    } else {
      return SizedBox.shrink();
    }
  }
}
