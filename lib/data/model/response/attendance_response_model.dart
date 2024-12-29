import 'dart:convert';

class AttendanceResponseModel {
  final bool? success;
  final String? message;
  final Attendances? data;

  AttendanceResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory AttendanceResponseModel.fromJson(String str) =>
      AttendanceResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AttendanceResponseModel.fromMap(Map<String, dynamic> json) =>
      AttendanceResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Attendances.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data?.toMap(),
      };
}

class Attendances {
  final int? userId;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final String? latitude;
  final String? longitude;
  final String? note;
  final String? status;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;

  Attendances({
    this.userId,
    this.checkIn,
    this.checkOut,
    this.latitude,
    this.longitude,
    this.note,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Attendances.fromJson(String str) =>
      Attendances.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Attendances.fromMap(Map<String, dynamic> json) => Attendances(
        userId: json["user_id"],
        checkIn:
            json["check_in"] == null ? null : DateTime.parse(json["check_in"]),
        checkOut: json["check_out"] == null
            ? null
            : DateTime.parse(json["check_out"]),
        latitude: json["latitude"],
        longitude: json["longitude"],
        note: json["note"],
        status: json["status"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "user_id": userId,
        "check_in": checkIn?.toIso8601String(),
        "check_out": checkOut,
        "latitude": latitude,
        "longitude": longitude,
        "note": note,
        "status": status,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
