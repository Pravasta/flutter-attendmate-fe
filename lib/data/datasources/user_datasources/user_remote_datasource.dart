import 'dart:io';

import 'package:flutter_attendmate_app/core/common/common.dart';
import 'package:flutter_attendmate_app/core/common/injection/injection.dart';
import 'package:flutter_attendmate_app/data/datasources/auth_datasources/auth_local_datasource.dart';
import 'package:flutter_attendmate_app/data/model/response/user_response_model.dart';
import 'package:http/http.dart' as http;

import '../../../core/exception/exception.dart';
import '../../../core/exception/failure.dart';

abstract class UserRemoteDatasource {
  Future<UserResponseModel> getUserByEmail();
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final AppEndpoint _appEndpoint;
  final http.Client _client;

  UserRemoteDatasourceImpl(
      {required AppEndpoint appEndpoint, required http.Client client})
      : _appEndpoint = appEndpoint,
        _client = client;

  @override
  Future<UserResponseModel> getUserByEmail() async {
    try {
      final data = await AuthLocalDatasourceImpl().getAuthData();
      final url = _appEndpoint.getUserByEmail(data.user!.email ?? '');

      final header = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${data.token}'
      };

      final response = await _client.get(
        url,
        headers: header,
      );

      if (response.statusCode == 200) {
        return UserResponseModel.fromJson(response.body);
      } else {
        final message = UserResponseModel.fromJson(response.body);
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

  factory UserRemoteDatasourceImpl.create() {
    return UserRemoteDatasourceImpl(
      appEndpoint: AppEndpoint.create(),
      client: Injection.client,
    );
  }
}
