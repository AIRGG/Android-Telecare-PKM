// To parse this JSON data, do
//
//     final PasienModel = LoginUserModelFromJson(jsonString);

import 'dart:convert';

class PasienModel {
  PasienModel({
    this.rcode,
    this.msg,
    this.data,
  });

  String? rcode;
  String? msg;
  Data? data;

  PasienModel copyWith({
    String? rcode,
    String? msg,
    Data? data,
  }) =>
      PasienModel(
        rcode: rcode ?? this.rcode,
        msg: msg ?? this.msg,
        data: data ?? this.data,
      );

  factory PasienModel.fromRawJson(String str) =>
      PasienModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PasienModel.fromJson(Map<String, dynamic> json) => PasienModel(
        rcode: json["rcode"] == null ? null : json["rcode"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "rcode": rcode == null ? null : rcode,
        "msg": msg == null ? null : msg,
        "data": data == null ? null : data?.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.name,
    this.jenis_kelamin,
    this.tanggal_lahir,
  });

  int? id;
  String? name;
  String? jenis_kelamin;
  // dynamic? emailVerifiedAt;
  DateTime? tanggal_lahir;

  Data copyWith({
    int? id,
    String? name,
    String? jenis_kelamin,
    // dynamic? emailVerifiedAt,
    DateTime? tanggal_lahir,
  }) =>
      Data(
        id: id ?? this.id,
        name: name ?? this.name,
        jenis_kelamin: jenis_kelamin ?? this.jenis_kelamin,
        tanggal_lahir: tanggal_lahir ?? this.tanggal_lahir,        
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        jenis_kelamin: json["jenis_kelamin"] == null ? null : json["jenis_kelamin"],
        // emailVerifiedAt: json["email_verified_at"],
        tanggal_lahir: json["tanggal_lahir"] == null
            ? null
            : DateTime.parse(json["tanggal_lahir"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "jenis_kelamin": jenis_kelamin == null ? null : jenis_kelamin,
        // "email_verified_at": emailVerifiedAt,
        "tanggal_lahir": tanggal_lahir == null ? null : tanggal_lahir?.toIso8601String(),
      };
}
