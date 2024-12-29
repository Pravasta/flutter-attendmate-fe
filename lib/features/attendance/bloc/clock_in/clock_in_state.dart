part of 'clock_in_bloc.dart';

@freezed
class ClockInState with _$ClockInState {
  const factory ClockInState.initial() = _Initial;
  const factory ClockInState.loading() = _Loading;
  const factory ClockInState.error(String error) = _Error;
  const factory ClockInState.success(Attendances data) = _Success;
}
