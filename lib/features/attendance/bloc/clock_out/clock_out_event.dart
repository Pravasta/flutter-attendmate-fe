part of 'clock_out_bloc.dart';

@freezed
class ClockOutEvent with _$ClockOutEvent {
  const factory ClockOutEvent.started() = _Started;
  const factory ClockOutEvent.clockOut(AttendanceRequestModel data) = _ClockOut;
}
