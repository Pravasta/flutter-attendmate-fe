import 'dart:convert';
import 'dart:io';

import 'package:flutter_attendmate_app/core/common/common.dart';
import 'package:flutter_attendmate_app/core/common/injection/injection.dart';
import 'package:flutter_attendmate_app/core/exception/api_error_handler.dart';
import 'package:flutter_attendmate_app/core/exception/api_exception.dart';
import 'package:flutter_attendmate_app/core/exception/failure.dart';
import 'package:flutter_attendmate_app/data/datasources/auth_datasources/auth_local_datasource.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_attendmate_app/data/model/response/login_response_model.dart';

abstract class AuthRemoteDatasource {
  Future<LoginResponseModel> login(String email, String password);
  Future<String> logout();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final http.Client _client;
  final AppEndpoint _appEndpoint;

  AuthRemoteDatasourceImpl({
    required http.Client client,
    required AppEndpoint appEndpoint,
  })  : _client = client,
        _appEndpoint = appEndpoint;

  @override
  Future<LoginResponseModel> login(String email, String password) async {
    try {
      final url = _appEndpoint.login();

      final headers = {
        'Content-Type': "application/json",
        'Accept': 'application/json'
      };

      final response = await _client.post(url,
          headers: headers,
          body: json.encode({
            'email': email,
            'password': password,
          }));

      if (response.statusCode == 200) {
        return LoginResponseModel.fromJson(response.body);
      } else {
        final message = LoginResponseModel.fromJson(response.body);
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

  @override
  Future<String> logout() async {
    try {
      final url = _appEndpoint.logout();
      final token = await AuthLocalDatasourceImpl().getAuthData();

      final headers = {
        'Content-Type': "application/json",
        'Authorization': "Bearer ${token.token}"
      };

      final response = await _client.post(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        return 'Logout Success';
      } else {
        throw ApiErrorHandler.handleError(
          statusCode: response.statusCode,
          error: 'Logout Error',
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

  factory AuthRemoteDatasourceImpl.create() {
    return AuthRemoteDatasourceImpl(
      client: Injection.client,
      appEndpoint: AppEndpoint.create(),
    );
  }
}
