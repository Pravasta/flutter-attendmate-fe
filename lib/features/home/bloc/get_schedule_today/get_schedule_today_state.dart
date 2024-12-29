part of 'get_schedule_today_bloc.dart';

@freezed
class GetScheduleTodayState with _$GetScheduleTodayState {
  const factory GetScheduleTodayState.initial() = _Initial;
  const factory GetScheduleTodayState.loading() = _Loading;
  const factory GetScheduleTodayState.error(String error) = _Error;
  const factory GetScheduleTodayState.loaded(Schedule data) = _Loaded;
}
