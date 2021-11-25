import 'user_model.dart';

class UserRepository {
  static final _allUsers = <User>[
    User(
        id: '001',
        name: 'Jiaying Wu',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/food-dating-app-1ef3f.appspot.com/o/hari.jpg?alt=media&token=7c0d1056-ffd5-4d2c-b340-933fbdae82e9'),
    User(
        id: '002',
        name: 'Ned Mayo',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/food-dating-app-1ef3f.appspot.com/o/hari.jpg?alt=media&token=7c0d1056-ffd5-4d2c-b340-933fbdae82e9'),
    User(
        id: '003',
        name: 'Hari Jia',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/food-dating-app-1ef3f.appspot.com/o/hari.jpg?alt=media&token=7c0d1056-ffd5-4d2c-b340-933fbdae82e9'),
    User(
        id: '004',
        name: 'James Yang',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/food-dating-app-1ef3f.appspot.com/o/hari.jpg?alt=media&token=7c0d1056-ffd5-4d2c-b340-933fbdae82e9'),
  ];

  List<User> loadUsers() {
    return _allUsers;
  }
}
