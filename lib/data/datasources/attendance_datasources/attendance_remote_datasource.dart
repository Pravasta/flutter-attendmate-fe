import 'dart:io';

import 'package:flutter_attendmate_app/core/common/common.dart';
import 'package:flutter_attendmate_app/core/common/injection/injection.dart';
import 'package:flutter_attendmate_app/data/datasources/auth_datasources/auth_local_datasource.dart';
import 'package:flutter_attendmate_app/data/model/request/attendance_request_model.dart';
import 'package:flutter_attendmate_app/data/model/response/attendance_history_response_model.dart';
import 'package:flutter_attendmate_app/data/model/response/attendance_response_model.dart';

import 'package:http/http.dart' as http;

import '../../../core/exception/exception.dart';
import '../../../core/exception/failure.dart';

abstract class AttendanceRemoteDatasource {
  Future<AttendanceResponseModel> clockIn(AttendanceRequestModel data);
  Future<AttendanceResponseModel> clockOut(AttendanceRequestModel data);
  Future<AttendanceHistoryResponseModel> getAttendanceHistory();
}

class AttendanceRemoteDatasourceImpl implements AttendanceRemoteDatasource {
  final AppEndpoint _appEndpoint;
  final http.Client _client;

  AttendanceRemoteDatasourceImpl({
    required AppEndpoint appEndpoint,
    required http.Client client,
  })  : _appEndpoint = appEndpoint,
        _client = client;

  @override
  Future<AttendanceResponseModel> clockIn(AttendanceRequestModel data) async {
    try {
      final auth = await AuthLocalDatasourceImpl().getAuthData();
      final url =
          _appEndpoint.attendance(data.latitude!, data.longitude!, data.note);

      final headers = {
        'Content-Type': "application/json",
        'Authorization': "Bearer ${auth.token}"
      };

      final response = await _client.post(
        url,
        body: data.toJson(),
        headers: headers,
      );

      if (response.statusCode == 201) {
        return AttendanceResponseModel.fromJson(response.body);
      } else {
        final message = AttendanceResponseModel.fromJson(response.body);
        throw ApiErrorHandler.handleError(
          statusCode: response.statusCode,
          error: message.message ?? '',
        );
      }
    } on SocketException {
      throw ConnectionFailure();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }

  @override
  Future<AttendanceResponseModel> clockOut(AttendanceRequestModel data) async {
    try {
      final auth = await AuthLocalDatasourceImpl().getAuthData();
      final url =
          _appEndpoint.attendance(data.latitude!, data.longitude!, data.note);

      final headers = {
        'Content-Type': "application/json",
        'Authorization': "Bearer ${auth.token}"
      };

      final response = await _client.put(
        url,
        body: data.toJson(),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return AttendanceResponseModel.fromJson(response.body);
      } else {
        final message = AttendanceResponseModel.fromJson(response.body);

        throw ApiErrorHandler.handleError(
          statusCode: response.statusCode,
          error: message.message ?? '',
        );
      }
    } on SocketException {
      throw ConnectionFailure();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }

  @override
  Future<AttendanceHistoryResponseModel> getAttendanceHistory() async {
    try {
      final auth = await AuthLocalDatasourceImpl().getAuthData();
      final url = _appEndpoint.getAttendanceHistory();

      final headers = {
        'Content-Type': "application/json",
        'Authorization': "Bearer ${auth.token}"
      };

      final response = await _client.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        return AttendanceHistoryResponseModel.fromJson(response.body);
      } else {
        final message = AttendanceHistoryResponseModel.fromJson(response.body);
        throw ApiErrorHandler.handleError(
          statusCode: response.statusCode,
          error: message.message ?? '',
        );
      }
    } on SocketException {
      throw ConnectionFailure();
    } on ApiException {
      throw 'Error';
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }

  factory AttendanceRemoteDatasourceImpl.create() {
    return AttendanceRemoteDatasourceImpl(
      appEndpoint: AppEndpoint.create(),
      client: Injection.client,
    );
  }
}
