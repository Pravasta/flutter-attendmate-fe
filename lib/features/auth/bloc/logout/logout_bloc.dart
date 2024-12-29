import 'package:flutter_attendmate_app/features/auth/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'logout_event.dart';
part 'logout_state.dart';
part 'logout_bloc.freezed.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthRepository _authRepository;

  LogoutBloc(this._authRepository) : super(const _Initial()) {
    on<_Logout>((event, emit) async {
      emit(const _Loading());

      final result = await _authRepository.logout();

      result.fold(
        (l) => emit(_Error(l.message)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
