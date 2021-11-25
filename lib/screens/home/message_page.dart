/// Author: Hengrui Jia
/// This is the message page
///

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_dating_app/providers/auth_provider.dart';
//import 'package:food_dating_app/models/message_model.dart';
import 'package:provider/provider.dart';
import 'chat_screen.dart';
import 'package:food_dating_app/models/user_model.dart';
import 'package:food_dating_app/models/user_repository.dart';
import 'package:food_dating_app/styles.dart';

class MessagePage extends StatefulWidget {
  MessagePage({Key? key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final auth = Auth.FirebaseAuth.instance;
  final ScrollController listScrollController = ScrollController();
  int _limit = 20;
  int _limitIncrement = 20;
  String _textSearch = "";

  late AuthProvider authProvider;
  late String currentUserId;

  TextEditingController _controller = TextEditingController();
  late final FocusNode _focusNode;
  //UserRepository users = UserRepository();
  String _terms = '';

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    currentUserId = auth.currentUser!.uid;
    _controller = TextEditingController()..addListener(_onTextChanged);
    _focusNode = FocusNode();
    listScrollController.addListener(() {
      scrollListener;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  void _onTextChanged() {
    setState(() {
      _terms = _controller.text;
    });
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SearchBar(
        controller: _controller,
        focusNode: _focusNode,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final results = users.loadUsers();

    return Scaffold(
      //body: WillPopScope(
      body: Stack(
        children: [
          Column(
            children: [
              _buildSearchBox(),
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                stream: authProvider.getStreamFireStore(
                    "users", _limit, _textSearch),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    if ((snapshot.data?.docs.length ?? 0) > 0) {
                      return ListView.builder(
                        padding: EdgeInsets.all(10),
                        itemBuilder: (context, index) =>
                            buildItem(context, snapshot.data?.docs[index]),
                        itemCount: snapshot.data?.docs.length,
                        controller: listScrollController,
                      );
                    }
                  }
                  return const Text("hello");
                },
              ))
            ],
          )

          // Expanded(
          //   child: ListView.builder(
          //     itemBuilder: (context, index) => MatchRowItem(
          //       user: results[index],
          //       lastItem: index == results.length - 1,
          //     ),
          //     itemCount: results.length,
          //   ),
          // ),
        ],
      ),
      //onWillPop: onBackPress(),
    );
    //);
  }

  Widget buildItem(BuildContext context, DocumentSnapshot? document) {
    if (document != null) {
      //UserChat userChat = UserChat.fromDocument(document);
      // if (userChat.id == currentUserId) {
      //   return SizedBox.shrink();
      // } else {
      return Container(
        child: TextButton(
            child: Row(
              children: <Widget>[
                //   Material(
                //     child: userChat.photoUrl.isNotEmpty
                //         ? Image.network(
                //             userChat.photoUrl,
                //             fit: BoxFit.cover,
                //             width: 50,
                //             height: 50,
                //             loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                //               if (loadingProgress == null) return child;
                //               return Container(
                //                 width: 50,
                //                 height: 50,
                //                 child: Center(
                //                   child: CircularProgressIndicator(
                //                     color: ColorConstants.themeColor,
                //                     value: loadingProgress.expectedTotalBytes != null &&
                //                             loadingProgress.expectedTotalBytes != null
                //                         ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                //                         : null,
                //                   ),
                //                 ),
                //               );
                //             },
                //             errorBuilder: (context, object, stackTrace) {
                //               return Icon(
                //                 Icons.account_circle,
                //                 size: 50,
                //                 color: ColorConstants.greyColor,
                //               );
                //             },
                //           )
                //         : Icon(
                //             Icons.account_circle,
                //             size: 50,
                //             color: ColorConstants.greyColor,
                //           ),
                //     borderRadius: BorderRadius.all(Radius.circular(25)),
                //     clipBehavior: Clip.hardEdge,
                //   ),
                Flexible(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            //'Nickname: ${userChat.nickname}',
                            'UserID: ${document.get('id')}',
                            maxLines: 1,
                            //style: TextStyle(color: ColorConstants.primaryColor),
                          ),
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 5),
                        ),
                        // Container(
                        //   child: Text(
                        //     'About me: ${userChat.aboutMe}',
                        //     maxLines: 1,
                        //     style: TextStyle(color: ColorConstants.primaryColor),
                        //   ),
                        //   alignment: Alignment.centerLeft,
                        //   margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        // )
                      ],
                    ),
                    margin: EdgeInsets.only(left: 20),
                  ),
                ),
              ],
            ),
            onPressed: () {
              // if (Utilities.isKeyboardShowing()) {
              //   Utilities.closeKeyboard(context);
              // }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    //   peerId: userChat.id,
                    //   peerAvatar: userChat.photoUrl,
                    //   peerNickname: userChat.nickname,
                    userID: document.get("id"),
                  ),
                ),
              );
            }
            //     style: ButtonStyle(
            //       backgroundColor: MaterialStateProperty.all<Color>(ColorConstants.greyColor2),
            //       shape: MaterialStateProperty.all<OutlinedBorder>(
            //         RoundedRectangleBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(10)),
            //         ),
            //       ),
            //     ),
            //   ),
            //   margin: EdgeInsets.only(bottom: 10, left: 5, right: 5),
            //);
            //}
            ),
        //} else {
      );
    } else {
      return SizedBox.shrink();
    }
  }
}

//class for the search bar
class SearchBar extends StatelessWidget {
  const SearchBar({
    required this.controller,
    required this.focusNode,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 8,
        ),
        child: Row(
          children: [
            const Icon(
              CupertinoIcons.search,
              color: Colors.white,
            ),
            Expanded(
              child: CupertinoTextField(
                controller: controller,
                focusNode: focusNode,
                style: Styles.searchText,
                cursorColor: Styles.searchCursorColor,
                decoration: null,
              ),
            ),
            GestureDetector(
              onTap: controller.clear,
              child: const Icon(
                CupertinoIcons.clear_thick_circled,
                color: Styles.searchIconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class MatchRowItem extends StatelessWidget {
//   const MatchRowItem({
//     required this.user,
//     required this.lastItem,
//     Key? key,
//   }) : super(key: key);

//   final User user;
//   final bool lastItem;

<<<<<<< HEAD
  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
      top: false,
      bottom: false,
      minimum: const EdgeInsets.only(
        left: 16,
        top: 8,
        bottom: 8,
        right: 8,
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              user.imageUrl,
              //package: product.assetPackage,
              fit: BoxFit.cover,
              width: 60,
              height: 60,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    user.name,
                    style: Styles.contactsName,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 8)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
=======
//   @override
//   Widget build(BuildContext context) {
//     final row = SafeArea(
//       top: false,
//       bottom: false,
//       minimum: const EdgeInsets.only(
//         left: 16,
//         top: 8,
//         bottom: 8,
//         right: 8,
//       ),
//       child: Row(
//         children: <Widget>[
//           ClipRRect(
//             borderRadius: BorderRadius.circular(4),
//             child: Image.asset(
//               user.imageUrl,
//               //package: product.assetPackage,
//               fit: BoxFit.cover,
//               width: 60,
//               height: 60,
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     user.name,
//                     style: Styles.contactsName,
//                   ),
//                   const Padding(padding: EdgeInsets.only(top: 8)),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
>>>>>>> 6e4cb05e724c7bd1e6facb3c8d8caed44913838e

//     if (lastItem) {
//       return GestureDetector(
//           onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (_) => ChatScreen(
//                         user: user,
//                       ))),
//           child: row);
//     }

//     return GestureDetector(
//         onTap: () => Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (_) => ChatScreen(
//                       user: user,
//                     ))),
//         child: Column(
//           children: <Widget>[
//             row,
//             Padding(
//               padding: const EdgeInsets.only(
//                 left: 100,
//                 right: 16,
//               ),
//               child: Container(
//                 height: 1,
//                 color: Styles.productRowDivider,
//               ),
//             ),
//           ],
//         ));
//   }
// }
