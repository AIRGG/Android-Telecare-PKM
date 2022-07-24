// To parse this JSON data, do
//
//     final notificationUserModel = notificationUserModelFromJson(jsonString);

import 'dart:convert';

class NotificationUserModel {
  NotificationUserModel({
    this.rcode,
    this.msg,
    this.data,
  });

  String? rcode;
  String? msg;
  List<Datum>? data;

  NotificationUserModel copyWith({
    String? rcode,
    String? msg,
    List<Datum>? data,
  }) =>
      NotificationUserModel(
        rcode: rcode ?? this.rcode,
        msg: msg ?? this.msg,
        data: data ?? this.data,
      );

  factory NotificationUserModel.fromRawJson(String str) =>
      NotificationUserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationUserModel.fromJson(Map<String, dynamic> json) =>
      NotificationUserModel(
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
    this.type,
    this.notifiableType,
    this.notifiableId,
    this.data,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? type;
  String? notifiableType;
  int? notifiableId;
  Data? data;
  dynamic? readAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum copyWith({
    String? id,
    String? type,
    String? notifiableType,
    int? notifiableId,
    Data? data,
    dynamic? readAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Datum(
        id: id ?? this.id,
        type: type ?? this.type,
        notifiableType: notifiableType ?? this.notifiableType,
        notifiableId: notifiableId ?? this.notifiableId,
        data: data ?? this.data,
        readAt: readAt ?? this.readAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
        notifiableType:
            json["notifiable_type"] == null ? null : json["notifiable_type"],
        notifiableId:
            json["notifiable_id"] == null ? null : json["notifiable_id"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        readAt: json["read_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type == null ? null : type,
        "notifiable_type": notifiableType == null ? null : notifiableType,
        "notifiable_id": notifiableId == null ? null : notifiableId,
        "data": data == null ? null : data!.toJson(),
        "read_at": readAt,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

class Data {
  Data({
    this.heartrate,
    this.tipe,
    this.judulPesan,
    this.isiPesan,
    this.saturasi,
  });

  String? heartrate;
  String? tipe;
  String? judulPesan;
  String? isiPesan;
  String? saturasi;

  Data copyWith({
    String? heartrate,
    String? tipe,
    String? judulPesan,
    String? isiPesan,
    String? saturasi,
  }) =>
      Data(
        heartrate: heartrate ?? this.heartrate,
        tipe: tipe ?? this.tipe,
        judulPesan: judulPesan ?? this.judulPesan,
        isiPesan: isiPesan ?? this.isiPesan,
        saturasi: saturasi ?? this.saturasi,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        heartrate: json["heartrate"] == null ? null : json["heartrate"],
        tipe: json["tipe"] == null ? null : json["tipe"],
        judulPesan: json["judul_pesan"] == null ? null : json["judul_pesan"],
        isiPesan: json["isi_pesan"] == null ? null : json["isi_pesan"],
        saturasi: json["saturasi"] == null ? null : json["saturasi"],
      );

  Map<String, dynamic> toJson() => {
        "heartrate": heartrate == null ? null : heartrate,
        "tipe": tipe == null ? null : tipe,
        "judul_pesan": judulPesan == null ? null : judulPesan,
        "isi_pesan": isiPesan == null ? null : isiPesan,
        "saturasi": saturasi == null ? null : saturasi,
      };
}
