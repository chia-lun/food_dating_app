class User {
  late String fullname;
  late String username;
  late String password;

  late String age;

  late String restaurant;
  User(this.fullname, this.username, this.password, this.age, this.restaurant);

  User.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    username = json['username'];
    password = json['password'];

    age = json['age'];

    restaurant = json['restaurant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = fullname;
    data['username'] = username;
    data['password'] = password;

    data['age'] = age;

    data['restaurant'] = restaurant;
    return data;
  }
}
