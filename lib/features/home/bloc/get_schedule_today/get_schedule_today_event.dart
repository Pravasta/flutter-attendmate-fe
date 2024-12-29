part of 'get_schedule_today_bloc.dart';

@freezed
class GetScheduleTodayEvent with _$GetScheduleTodayEvent {
  const factory GetScheduleTodayEvent.started() = _Started;
  const factory GetScheduleTodayEvent.getScheduleToday() = _GetScheduleToday;
}
