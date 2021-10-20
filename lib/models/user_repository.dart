import 'user_model.dart';

class UserRepository {
  static final _allUsers = <User>[
    User(id: 001, name: 'Jiaying Wu', imageUrl: 'assets/images/jiaying.jpg'),
    User(id: 002, name: 'Ned Mayo', imageUrl: 'assets/images/ned.jpg'),
    User(id: 003, name: 'Hari Jia', imageUrl: 'assets/images/hari.jpg'),
    User(id: 004, name: 'Jimmy Yang', imageUrl: 'assets/images/james.jpg'),
    User(id: 005, name: 'Sawyer Neske', imageUrl: 'assets/images/sawyer.jpg'),
  ];

  List<User> loadUsers() {
    return _allUsers;
  }
}
