import 'package:flutter_attendmate_app/data/model/response/login_response_model.dart';
import 'package:flutter_attendmate_app/features/home/repository/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_user_by_email_event.dart';
part 'get_user_by_email_state.dart';
part 'get_user_by_email_bloc.freezed.dart';

class GetUserByEmailBloc
    extends Bloc<GetUserByEmailEvent, GetUserByEmailState> {
  final HomeRepository _repository;

  GetUserByEmailBloc(this._repository) : super(const _Initial()) {
    on<_GetUserByEmail>((event, emit) async {
      emit(_Loading());

      await Future.delayed(const Duration(seconds: 2));

      final result = await _repository.getUserByEmail();

      result.fold(
        (l) => emit(_Error(l.message)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
