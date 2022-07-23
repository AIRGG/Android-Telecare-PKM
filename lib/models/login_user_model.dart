// To parse this JSON data, do
//
//     final loginUserModel = loginUserModelFromJson(jsonString);

import 'dart:convert';

class LoginUserModel {
  LoginUserModel({
    this.username,
    this.password,
    this.role,
    this.name,
  });

  String? username;
  String? password;
  String? role;
  String? name;

  LoginUserModel copyWith({
    String? username,
    String? password,
    String? role,
    String? name,
  }) =>
      LoginUserModel(
        username: username ?? this.username,
        password: password ?? this.password,
        role: role ?? this.role,
        name: name ?? this.name,
      );

  factory LoginUserModel.fromRawJson(String str) =>
      LoginUserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginUserModel.fromJson(Map<String, dynamic> json) => LoginUserModel(
        username: json["username"] == null ? null : json["username"],
        password: json["password"] == null ? null : json["password"],
        role: json["role"] == null ? null : json["role"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "username": username == null ? null : username,
        "password": password == null ? null : password,
        "role": role == null ? null : role,
        "name": name == null ? null : name,
      };
}
