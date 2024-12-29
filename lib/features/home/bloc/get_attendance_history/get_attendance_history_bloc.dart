import 'package:flutter_attendmate_app/features/home/repository/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_attendmate_app/data/model/response/attendance_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_attendance_history_event.dart';
part 'get_attendance_history_state.dart';
part 'get_attendance_history_bloc.freezed.dart';

class GetAttendanceHistoryBloc
    extends Bloc<GetAttendanceHistoryEvent, GetAttendanceHistoryState> {
  final HomeRepository _homeRepository;

  GetAttendanceHistoryBloc(this._homeRepository) : super(_Initial()) {
    on<_GetAttendancesHistory>((event, emit) async {
      emit(_Loading());

      final result = await _homeRepository.getAttendancesHistory();

      result.fold(
        (l) => emit(_Error(l.message)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
