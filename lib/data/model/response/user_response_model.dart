import 'dart:convert';

import 'package:flutter_attendmate_app/data/model/response/login_response_model.dart';

class UserResponseModel {
  final String? status;
  final User? data;

  UserResponseModel({
    this.status,
    this.data,
  });

  factory UserResponseModel.fromJson(String str) =>
      UserResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserResponseModel.fromMap(Map<String, dynamic> json) =>
      UserResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : User.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data": data?.toMap(),
      };
}
