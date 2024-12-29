import 'package:flutter_attendmate_app/data/model/request/attendance_request_model.dart';
import 'package:flutter_attendmate_app/data/model/response/attendance_response_model.dart';
import 'package:flutter_attendmate_app/features/attendance/repository/attendance_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'clock_in_event.dart';
part 'clock_in_state.dart';
part 'clock_in_bloc.freezed.dart';

class ClockInBloc extends Bloc<ClockInEvent, ClockInState> {
  final AttendanceRepository _repository;

  ClockInBloc(this._repository) : super(_Initial()) {
    on<_ClockIn>((event, emit) async {
      emit(_Loading());
      await Future.delayed(const Duration(seconds: 2));
      final result = await _repository.clockIn(event.data);

      result.fold(
        (l) => emit(_Error(l.message)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
