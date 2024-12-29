import 'dart:convert';

import 'package:flutter_attendmate_app/data/model/response/attendance_response_model.dart';

class AttendanceHistoryResponseModel {
  final bool? success;
  final String? message;
  final List<Attendances>? data;

  AttendanceHistoryResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory AttendanceHistoryResponseModel.fromJson(String str) =>
      AttendanceHistoryResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AttendanceHistoryResponseModel.fromMap(Map<String, dynamic> json) =>
      AttendanceHistoryResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Attendances>.from(
                json["data"]!.map((x) => Attendances.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}
