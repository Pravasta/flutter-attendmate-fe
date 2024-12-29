part of 'clock_out_bloc.dart';

@freezed
class ClockOutState with _$ClockOutState {
  const factory ClockOutState.initial() = _Initial;
  const factory ClockOutState.loading() = _Loading;
  const factory ClockOutState.error(String error) = _Error;
  const factory ClockOutState.success(Attendances data) = _Success;
}
