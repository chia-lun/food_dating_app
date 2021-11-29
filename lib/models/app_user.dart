class AppUser {
  late final String uid;
  late final String name;
  late final int age;
  late String restaurant;
  late String pfpDownloadURL;

  AppUser({
    required this.uid,
    required this.name,
    required this.age,
    required this.restaurant,
    String? pfpDownloadURL,
  });

  String getName() {
    return name;
  }

  String getRestaurant() {
    return restaurant;
  }

  String getURL() {
    return pfpDownloadURL;
  }

  // User(this.fullname, this.username, this.password, this.gender, this.birthday,
  //     this.phone, this.address, this.create_at, this.type);

  // User.fromJson(Map<String, dynamic> json) {
  //   fullname = json['fullname'];
  //   username = json['username'];
  //   password = json['password'];
  //   gender = json['gender'];
  //   birthday = json['birthday'];
  //   phone = json['phone'];
  //   address = json['address'];
  //   create_at = json['create_at'];
  //   type = json['type'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['fullname'] = fullname;
  //   data['username'] = username;
  //   data['password'] = password;
  //   data['gender'] = gender;
  //   data['birthday'] = birthday;
  //   data['phone'] = phone;
  //   data['address'] = address;
  //   data['create_at'] = create_at;
  //   data['type'] = type;
  //   return data;
  // }
}
