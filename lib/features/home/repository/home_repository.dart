import 'package:dartz/dartz.dart';
import 'package:flutter_attendmate_app/core/exception/failure.dart';
import 'package:flutter_attendmate_app/data/datasources/attendance_datasources/attendance_remote_datasource.dart';
import 'package:flutter_attendmate_app/data/datasources/schedule_datasources/schedule_remote_datasource.dart';
import 'package:flutter_attendmate_app/data/datasources/user_datasources/user_remote_datasource.dart';
import 'package:flutter_attendmate_app/data/model/response/login_response_model.dart';
import 'package:flutter_attendmate_app/data/model/response/schedule_response_model.dart';

import '../../../data/model/response/attendance_response_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, User>> getUserByEmail();
  Future<Either<Failure, Schedule>> getScheduleToday();
  Future<Either<Failure, List<Attendances>>> getAttendancesHistory();
}

class HomeRepositoryImpl implements HomeRepository {
  final UserRemoteDatasource _remoteDatasource;
  final ScheduleRemoteDatasource _scheduleRemoteDatasource;
  final AttendanceRemoteDatasource _attendanceRemoteDatasource;
  HomeRepositoryImpl(
      {required UserRemoteDatasource remoteDatasource,
      required ScheduleRemoteDatasource scheduleRemoteDatasource,
      required AttendanceRemoteDatasource attendanceRemoteDatasource})
      : _remoteDatasource = remoteDatasource,
        _scheduleRemoteDatasource = scheduleRemoteDatasource,
        _attendanceRemoteDatasource = attendanceRemoteDatasource;

  @override
  Future<Either<Failure, User>> getUserByEmail() async {
    try {
      final execute = await _remoteDatasource.getUserByEmail();
      return Right(execute.data!);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Schedule>> getScheduleToday() async {
    try {
      final execute = await _scheduleRemoteDatasource.getScheduleToday();
      return Right(execute.data!.first);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Attendances>>> getAttendancesHistory() async {
    try {
      final execute = await _attendanceRemoteDatasource.getAttendanceHistory();
      return Right(execute.data ?? []);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  factory HomeRepositoryImpl.create() {
    return HomeRepositoryImpl(
      remoteDatasource: UserRemoteDatasourceImpl.create(),
      scheduleRemoteDatasource: ScheduleRemoteDatasourceImpl.create(),
      attendanceRemoteDatasource: AttendanceRemoteDatasourceImpl.create(),
    );
  }
}
