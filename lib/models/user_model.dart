class UserModel {
  String? email;
  String? password;
  String? phone;
  String? type;

  UserModel({this.email, this.password, this.phone, this.type});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['type'] = this.type;
    return data;
  }
}
