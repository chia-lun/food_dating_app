//import 'package:food_dating_app/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_dating_app/models/user_model.dart';

class Message {
  String senderID;
  String receiverID;
  String
      time; // Would usually be type DateTime or Firebase Timestamp in production apps
  String text;

  Message(
      {required this.senderID,
      required this.receiverID,
      required this.time,
      required this.text,
      String? idUser});

  Map<String, dynamic> toJson() {
    return {
      "senderID": this.senderID,
      "receiverID": this.receiverID,
      "time": this.time,
      "text": this.text,
    };
  }

  factory Message.fromDocument(DocumentSnapshot doc) {
    String senderID = (doc.get("senderId"));
    String receiverID = (doc.get("receiverID"));
    String time = (doc.get("time"));
    String text = (doc.get("text"));
    return Message(
        senderID: senderID, receiverID: receiverID, time: time, text: text);
  }
}
// // YOU - current user
// final User currentUser = User(
//   id: 0,
//   name: 'Current User',
//   imageUrl: 'assets/images/Hari.jpg',
// );

// // USERS
// final User hari = User(
//   id: 1,
//   name: 'Hari',
//   imageUrl: 'assets/images/hari.jpg',
// );
// final User james = User(
//   id: 2,
//   name: 'James',
//   imageUrl: 'assets/images/james.jpg',
// );
// final User jiaying = User(
//   id: 3,
//   name: 'Jiaying',
//   imageUrl: 'assets/images/jiaying.jpg',
// );
// final User ned = User(
//   id: 4,
//   name: 'Ned',
//   imageUrl: 'assets/images/ned.jpg',
// );

// // EXAMPLE CHATS ON HOME SCREEN
// List<Message> chats = [
//   Message(
//     sender: james,
//     time: '5:30 PM',
//     text: 'Hey, how\'s it going? What did you do today?',
//     isLiked: false,
//     unread: true,
//   ),
//   Message(
//     sender: jiaying,
//     time: '4:30 PM',
//     text: 'Hey, how\'s it going? What did you do today?',
//     isLiked: false,
//     unread: true,
//   ),
//   Message(
//     sender: ned,
//     time: '3:30 PM',
//     text: 'Hey, how\'s it going? What did you do today?',
//     isLiked: false,
//     unread: false,
//   ),
// ];

// // EXAMPLE MESSAGES IN CHAT SCREEN
// List<Message> messages = [
//   Message(
//     sender: james,
//     time: '5:30 PM',
//     text: 'Hey, how\'s it going? What did you do today?',
//     isLiked: true,
//     unread: true,
//   ),
//   Message(
//     sender: currentUser,
//     time: '4:30 PM',
//     text: 'Just walked my doge. She was super duper cute. The best pupper!!',
//     isLiked: false,
//     unread: true,
//   ),
//   Message(
//     sender: james,
//     time: '3:45 PM',
//     text: 'How\'s the doggo?',
//     isLiked: false,
//     unread: true,
//   ),
//   Message(
//     sender: james,
//     time: '3:15 PM',
//     text: 'All the food',
//     isLiked: true,
//     unread: true,
//   ),
//   Message(
//     sender: currentUser,
//     time: '2:30 PM',
//     text: 'Nice! What kind of food did you eat?',
//     isLiked: false,
//     unread: true,
//   ),
//   Message(
//     sender: james,
//     time: '2:00 PM',
//     text: 'I ate so much food today.',
//     isLiked: false,
//     unread: true,
//   ),
// ];
