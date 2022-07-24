// To parse this JSON data, do
//
//     final monitorDashboardModel = monitorDashboardModelFromJson(jsonString);

import 'dart:convert';

class MonitorDashboardModel {
  MonitorDashboardModel({
    this.rcode,
    this.msg,
    this.data,
  });

  String? rcode;
  String? msg;
  Data? data;

  MonitorDashboardModel copyWith({
    String? rcode,
    String? msg,
    Data? data,
  }) =>
      MonitorDashboardModel(
        rcode: rcode ?? this.rcode,
        msg: msg ?? this.msg,
        data: data ?? this.data,
      );

  factory MonitorDashboardModel.fromRawJson(String str) =>
      MonitorDashboardModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MonitorDashboardModel.fromJson(Map<String, dynamic> json) =>
      MonitorDashboardModel(
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
    this.suhu,
    this.heartrate,
    this.saturasi,
  });

  Heartrate? suhu;
  Heartrate? heartrate;
  Heartrate? saturasi;

  Data copyWith({
    Heartrate? suhu,
    Heartrate? heartrate,
    Heartrate? saturasi,
  }) =>
      Data(
        suhu: suhu ?? this.suhu,
        heartrate: heartrate ?? this.heartrate,
        saturasi: saturasi ?? this.saturasi,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        suhu: json["suhu"] == null ? null : Heartrate.fromJson(json["suhu"]),
        heartrate: json["heartrate"] == null
            ? null
            : Heartrate.fromJson(json["heartrate"]),
        saturasi: json["saturasi"] == null
            ? null
            : Heartrate.fromJson(json["saturasi"]),
      );

  Map<String, dynamic> toJson() => {
        "suhu": suhu == null ? null : suhu?.toJson(),
        "heartrate": heartrate == null ? null : heartrate?.toJson(),
        "saturasi": saturasi == null ? null : saturasi?.toJson(),
      };
}

class Heartrate {
  Heartrate({
    this.id,
    this.value,
    this.createdAt,
  });

  int? id;
  double? value;
  DateTime? createdAt;

  Heartrate copyWith({
    int? id,
    double? value,
    DateTime? createdAt,
  }) =>
      Heartrate(
        id: id ?? this.id,
        value: value ?? this.value,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Heartrate.fromRawJson(String str) =>
      Heartrate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Heartrate.fromJson(Map<String, dynamic> json) => Heartrate(
        id: json["id"] == null ? null : json["id"],
        value: json["value"] == null ? null : json["value"].toDouble(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "value": value == null ? null : value,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
      };
}
