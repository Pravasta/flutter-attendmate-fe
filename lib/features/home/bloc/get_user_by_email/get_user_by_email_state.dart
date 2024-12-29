part of 'get_user_by_email_bloc.dart';

@freezed
class GetUserByEmailState with _$GetUserByEmailState {
  const factory GetUserByEmailState.initial() = _Initial;
  const factory GetUserByEmailState.loading() = _Loading;
  const factory GetUserByEmailState.error(String error) = _Error;
  const factory GetUserByEmailState.loaded(User data) = _Loaded;
}
