class User {
  late String fullname;
  late String username;
  late String password;
  late String gender;
  late String birthday;
  late String phone;
  late String address;
  late String create_at;
  late String type;
  User(this.fullname, this.username, this.password, this.gender, this.birthday,
      this.phone, this.address, this.create_at, this.type);

  User.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    username = json['username'];
    password = json['password'];
    gender = json['gender'];
    birthday = json['birthday'];
    phone = json['phone'];
    address = json['address'];
    create_at = json['create_at'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = fullname;
    data['username'] = username;
    data['password'] = password;
    data['gender'] = gender;
    data['birthday'] = birthday;
    data['phone'] = phone;
    data['address'] = address;
    data['create_at'] = create_at;
    data['type'] = type;
    return data;
  }
}
