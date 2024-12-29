import 'dart:io';

import 'package:flutter_attendmate_app/core/common/injection/injection.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_attendmate_app/core/common/common.dart';
import 'package:flutter_attendmate_app/data/model/response/schedule_response_model.dart';

import '../../../core/exception/exception.dart';
import '../../../core/exception/failure.dart';
import '../auth_datasources/auth_local_datasource.dart';

abstract class ScheduleRemoteDatasource {
  Future<ScheduleResponseModel> getScheduleToday();
}

class ScheduleRemoteDatasourceImpl implements ScheduleRemoteDatasource {
  final AppEndpoint _appEndpoint;
  final http.Client _client;

  ScheduleRemoteDatasourceImpl({
    required AppEndpoint appEndpoint,
    required http.Client client,
  })  : _appEndpoint = appEndpoint,
        _client = client;

  @override
  Future<ScheduleResponseModel> getScheduleToday() async {
    try {
      final data = await AuthLocalDatasourceImpl().getAuthData();
      final url = _appEndpoint.getScheduleToday();

      final header = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${data.token}'
      };

      final response = await _client.get(
        url,
        headers: header,
      );

      if (response.statusCode == 200) {
        return ScheduleResponseModel.fromJson(response.body);
      } else {
        final message = ScheduleResponseModel.fromJson(response.body);
        throw ApiErrorHandler.handleError(
          statusCode: response.statusCode,
          error: message.status ?? '',
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

  factory ScheduleRemoteDatasourceImpl.create() {
    return ScheduleRemoteDatasourceImpl(
      appEndpoint: AppEndpoint.create(),
      client: Injection.client,
    );
  }
}
