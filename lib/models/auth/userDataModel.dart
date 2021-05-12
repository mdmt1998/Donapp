class UserData {
  String address;
  String city;
  String email;
  String name;
  String password;
  int phoneNumber;
  String uId;

  UserData(
      {this.address,
      this.city,
      this.email,
      this.name,
      this.password,
      this.phoneNumber,
      this.uId});

  UserData.fromJson(Map<dynamic, dynamic> json) {
    uId = json['uId'];
    password = json['password'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    city = json['city'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['city'] = this.city;
    data['email'] = this.email;
    data['name'] = this.name;
    data['password'] = this.password;
    data['phoneNumber'] = this.phoneNumber;
    data['uId'] = this.uId;
    return data;
  }
}
