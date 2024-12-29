part of 'get_attendance_history_bloc.dart';

@freezed
class GetAttendanceHistoryState with _$GetAttendanceHistoryState {
  const factory GetAttendanceHistoryState.initial() = _Initial;
  const factory GetAttendanceHistoryState.loading() = _Loading;
  const factory GetAttendanceHistoryState.error(String error) = _Error;
  const factory GetAttendanceHistoryState.loaded(List<Attendances> data) =
      _Loaded;
}
