import 'package:flutter_attendmate_app/data/model/response/login_response_model.dart';
import 'package:flutter_attendmate_app/features/auth/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc(this._authRepository) : super(_Initial()) {
    on<_Login>((event, emit) async {
      emit(const _Loading());

      final result = await _authRepository.login(event.email, event.password);

      result.fold(
        (l) => emit(_Error(l.message)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
