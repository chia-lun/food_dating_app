class User {
  late String fullname;
  late String username;
  late String password;
  late String gender;
  late String birthday;
  late String phone;
  late String restaurant;
  User(this.fullname, this.username, this.password, this.gender, this.birthday,
      this.phone, this.restaurant);

  User.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    username = json['username'];
    password = json['password'];
    gender = json['gender'];
    birthday = json['birthday'];
    phone = json['phone'];
    restaurant = json['restaurant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = fullname;
    data['username'] = username;
    data['password'] = password;
    data['gender'] = gender;
    data['birthday'] = birthday;
    data['phone'] = phone;
    data['restaurant'] = restaurant;
    return data;
  }
}
