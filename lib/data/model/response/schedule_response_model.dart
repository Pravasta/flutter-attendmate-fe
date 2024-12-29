import 'dart:convert';

class ScheduleResponseModel {
  final String? status;
  final List<Schedule>? data;

  ScheduleResponseModel({
    this.status,
    this.data,
  });

  factory ScheduleResponseModel.fromJson(String str) =>
      ScheduleResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ScheduleResponseModel.fromMap(Map<String, dynamic> json) =>
      ScheduleResponseModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Schedule>.from(
                json["data"]!.map((x) => Schedule.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Schedule {
  final int? id;
  final int? userId;
  final DateTime? date;
  final String? start;
  final String? end;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Schedule({
    this.id,
    this.userId,
    this.date,
    this.start,
    this.end,
    this.createdAt,
    this.updatedAt,
  });

  factory Schedule.fromJson(String str) => Schedule.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Schedule.fromMap(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        userId: json["user_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        start: json["start"],
        end: json["end"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "start": start,
        "end": end,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
