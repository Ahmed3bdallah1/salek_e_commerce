import 'package:car_rentting/Features/auth/data/models/user_model.dart';

class LoginEntity {
  String token;
  UserModel user;

  LoginEntity({required this.token, required this.user});

  factory LoginEntity.fromJson(Map<String, dynamic> json) {
    return LoginEntity(
        token: json['token'], user: UserModel.fromJson(json['data']));
  }
}
