// To parse this JSON data, do
//
//     final monitorDashboardModel = monitorDashboardModelFromJson(jsonString);

import 'dart:convert';

class ManageUserModel {
  ManageUserModel({
    this.rcode,
    this.msg,
    this.data,
  });

  String? rcode;
  String? msg;
  List<Datum>? data;

  ManageUserModel copyWith({
    String? rcode,
    String? msg,
    List<Datum>? data,
  }) =>
      ManageUserModel(
        rcode: rcode ?? this.rcode,
        msg: msg ?? this.msg,
        data: data ?? this.data,
      );

  factory ManageUserModel.fromRawJson(String str) =>
      ManageUserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ManageUserModel.fromJson(Map<String, dynamic> json) =>
      ManageUserModel(
        rcode: json["rcode"] == null ? null : json["rcode"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "rcode": rcode == null ? null : rcode,
        "msg": msg == null ? null : msg,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.username,
    this.handphone,
    this.email,
    this.emailVerifiedAt,
    this.isAdmin,
    this.fcmToken,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? username;
  String? handphone;
  String? email;
  dynamic? emailVerifiedAt;
  int? isAdmin;
  String? fcmToken;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum copyWith({
    int? id,
    String? name,
    String? username,
    String? handphone,
    String? email,
    dynamic? emailVerifiedAt,
    int? isAdmin,
    String? fcmToken,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Datum(
        id: id ?? this.id,
        name: name ?? this.name,
        username: username ?? this.username,
        handphone: handphone ?? this.handphone,
        email: email ?? this.email,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        isAdmin: isAdmin ?? this.isAdmin,
        fcmToken: fcmToken ?? this.fcmToken,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        username: json["username"] == null ? null : json["username"],
        handphone: json["handphone"] == null ? null : json["handphone"],
        email: json["email"] == null ? null : json["email"],
        emailVerifiedAt: json["email_verified_at"],
        isAdmin: json["is_admin"] == null ? null : json["is_admin"],
        fcmToken: json["fcm_token"] == null ? null : json["fcm_token"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "username": username == null ? null : username,
        "handphone": handphone == null ? null : handphone,
        "email": email == null ? null : email,
        "email_verified_at": emailVerifiedAt,
        "is_admin": isAdmin == null ? null : isAdmin,
        "fcm_token": fcmToken == null ? null : fcmToken,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
      };
}
