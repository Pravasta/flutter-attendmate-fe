part of 'get_user_by_email_bloc.dart';

@freezed
class GetUserByEmailEvent with _$GetUserByEmailEvent {
  const factory GetUserByEmailEvent.started() = _Started;
  const factory GetUserByEmailEvent.getUserByEmail() = _GetUserByEmail;
}
