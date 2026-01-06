import 'package:gericare_doctor/core/base/base_model.dart';

class UserModel extends BaseModel {
  late int id;
  late String email;
  late String phone;
  late String username;

  @override
  UserModel fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    username = json['username'];
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "phone": phone,
      "username": username,
    };
  }
}
