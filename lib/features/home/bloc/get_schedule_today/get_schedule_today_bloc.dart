import 'package:flutter_attendmate_app/features/home/repository/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_attendmate_app/data/model/response/schedule_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_schedule_today_event.dart';
part 'get_schedule_today_state.dart';
part 'get_schedule_today_bloc.freezed.dart';

class GetScheduleTodayBloc
    extends Bloc<GetScheduleTodayEvent, GetScheduleTodayState> {
  final HomeRepository _homeRepository;

  GetScheduleTodayBloc(this._homeRepository) : super(const _Initial()) {
    on<_GetScheduleToday>((event, emit) async {
      emit(_Loading());

      final result = await _homeRepository.getScheduleToday();

      result.fold(
        (l) => emit(_Error(l.message)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
