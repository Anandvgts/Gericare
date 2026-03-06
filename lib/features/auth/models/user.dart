import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.email,
    required this.phone,
    required this.userName,
  });

  final int? id;
  final String? email;
  final String? phone;
  final String? userName;

  factory User.formJson(Map<String, dynamic> json) {
    return User(
        id: json["id"],
        email: json["email"],
        phone: json["phone"],
        userName: json["userName"]);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phone": phone,
        "userName": userName,
      };

  List<Object?> get props => [id, email, phone, userName];
}
