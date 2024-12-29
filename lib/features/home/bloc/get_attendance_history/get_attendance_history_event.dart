part of 'get_attendance_history_bloc.dart';

@freezed
class GetAttendanceHistoryEvent with _$GetAttendanceHistoryEvent {
  const factory GetAttendanceHistoryEvent.started() = _Started;
  const factory GetAttendanceHistoryEvent.getAttendancesHistory() =
      _GetAttendancesHistory;
}
