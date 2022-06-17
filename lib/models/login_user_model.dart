// To parse this JSON data, do
//
//     final loginUserModel = loginUserModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LoginUserModel loginUserModelFromJson(String str) =>
    LoginUserModel.fromJson(json.decode(str));

String loginUserModelToJson(LoginUserModel data) => json.encode(data.toJson());

class LoginUserModel {
  LoginUserModel({
    required this.username,
    required this.password,
    required this.role,
    required this.name,
  });

  late final String username;
  late final String password;
  late final String role;
  late final String name;

  factory LoginUserModel.fromJson(Map<String, dynamic> json) => LoginUserModel(
        username: json["username"],
        password: json["password"],
        role: json["role"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "role": role,
        "name": name,
      };
}
