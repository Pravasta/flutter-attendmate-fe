part of 'clock_in_bloc.dart';

@freezed
class ClockInEvent with _$ClockInEvent {
  const factory ClockInEvent.started() = _Started;
  const factory ClockInEvent.clockIn(AttendanceRequestModel data) = _ClockIn;
}
