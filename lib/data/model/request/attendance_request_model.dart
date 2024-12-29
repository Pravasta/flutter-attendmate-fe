import 'dart:convert';

class AttendanceRequestModel {
  final String? latitude;
  final String? longitude;
  final String? note;

  AttendanceRequestModel({
    this.latitude,
    this.longitude,
    this.note,
  });

  factory AttendanceRequestModel.fromJson(String str) =>
      AttendanceRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AttendanceRequestModel.fromMap(Map<String, dynamic> json) =>
      AttendanceRequestModel(
        latitude: json["latitude"],
        longitude: json["longitude"],
        note: json["note"],
      );

  Map<String, dynamic> toMap() => {
        "latitude": latitude,
        "longitude": longitude,
        "note": note,
      };
}
