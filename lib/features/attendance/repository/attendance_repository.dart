import 'package:dartz/dartz.dart';
import 'package:flutter_attendmate_app/core/exception/failure.dart';
import 'package:flutter_attendmate_app/data/datasources/attendance_datasources/attendance_remote_datasource.dart';
import 'package:flutter_attendmate_app/data/model/request/attendance_request_model.dart';
import 'package:flutter_attendmate_app/data/model/response/attendance_response_model.dart';

abstract class AttendanceRepository {
  Future<Either<Failure, Attendances>> clockIn(AttendanceRequestModel data);
  Future<Either<Failure, Attendances>> clockOut(AttendanceRequestModel data);
}

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDatasource _attendanceRemoteDatasource;

  AttendanceRepositoryImpl({
    required AttendanceRemoteDatasource attendanceRemoteDatasource,
  }) : _attendanceRemoteDatasource = attendanceRemoteDatasource;

  @override
  Future<Either<Failure, Attendances>> clockIn(
      AttendanceRequestModel data) async {
    try {
      final execute = await _attendanceRemoteDatasource.clockIn(data);
      return Right(execute.data!);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Attendances>> clockOut(
      AttendanceRequestModel data) async {
    try {
      final execute = await _attendanceRemoteDatasource.clockOut(data);
      return Right(execute.data!);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  factory AttendanceRepositoryImpl.create() {
    return AttendanceRepositoryImpl(
      attendanceRemoteDatasource: AttendanceRemoteDatasourceImpl.create(),
    );
  }
}
