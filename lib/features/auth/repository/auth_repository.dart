import 'package:flutter_attendmate_app/core/exception/failure.dart';
import 'package:flutter_attendmate_app/data/datasources/auth_datasources/auth_remote_datasource.dart';
import 'package:flutter_attendmate_app/data/model/response/login_response_model.dart';

import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginModel>> login(String email, String password);
  Future<Either<Failure, String>> logout();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _remoteDatasource;

  AuthRepositoryImpl({
    required AuthRemoteDatasource remoteDatasource,
  }) : _remoteDatasource = remoteDatasource;

  @override
  Future<Either<Failure, LoginModel>> login(
      String email, String password) async {
    try {
      final execute = await _remoteDatasource.login(email, password);
      return Right(execute.data!);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> logout() async {
    try {
      final execute = await _remoteDatasource.logout();
      return Right(execute);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  factory AuthRepositoryImpl.create() {
    return AuthRepositoryImpl(
      remoteDatasource: AuthRemoteDatasourceImpl.create(),
    );
  }
}
