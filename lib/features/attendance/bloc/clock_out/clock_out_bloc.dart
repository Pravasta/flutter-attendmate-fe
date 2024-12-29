import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/model/request/attendance_request_model.dart';
import '../../../../data/model/response/attendance_response_model.dart';
import '../../repository/attendance_repository.dart';

part 'clock_out_event.dart';
part 'clock_out_state.dart';
part 'clock_out_bloc.freezed.dart';

class ClockOutBloc extends Bloc<ClockOutEvent, ClockOutState> {
  final AttendanceRepository _repository;
  ClockOutBloc(this._repository) : super(_Initial()) {
    on<_ClockOut>((event, emit) async {
      emit(_Loading());

      await Future.delayed(const Duration(seconds: 2));

      final result = await _repository.clockOut(event.data);

      result.fold(
        (l) => emit(_Error(l.message)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
