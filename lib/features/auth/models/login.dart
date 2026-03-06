import 'package:equatable/equatable.dart';
import 'user.dart';

class Login extends Equatable{
  final String? token;
  final User? user;

  const Login({required this.token,required this.user});

  factory Login.formJson(Map<String,dynamic> json){
    return Login(token: json["token"], user: json['user'] != null 
          ? User.formJson(json['user'] as Map<String, dynamic>)  
          : null,);
  }

  Map<String,dynamic> toJson() => {
    "token":token,
    "user" : user?.toJson(),
  };

  @override
  List<Object?> get props => [token,user];
}