import '../../core.dart';

class AppEndpoint {
  final String _baseUrl;

  AppEndpoint({required String baseUrl}) : _baseUrl = baseUrl;

  Uri login() {
    return UriHelper.createUrl(
      host: _baseUrl,
      path: '/api/user/login',
    );
  }

  Uri logout() {
    return UriHelper.createUrl(
      host: _baseUrl,
      path: '/api/user/logout',
    );
  }

  Uri getUserByEmail(String email) {
    return UriHelper.createUrl(
      host: _baseUrl,
      path: '/api/user/$email',
    );
  }

  Uri getScheduleToday() {
    return UriHelper.createUrl(
      host: _baseUrl,
      path: '/api/schedule/get-today',
    );
  }

  Uri attendance(String lat, String lng, String? notes) {
    return UriHelper.createUrl(
      host: _baseUrl,
      path: '/api/attendance',
    );
  }

  Uri checkStatusCheckIn() {
    return UriHelper.createUrl(
      host: _baseUrl,
      path: '/api/attendance/check-in-status',
    );
  }

  Uri getAttendanceHistory() {
    return UriHelper.createUrl(
      host: _baseUrl,
      path: '/api/attendance/get-attendance-history',
    );
  }

  factory AppEndpoint.create() {
    return AppEndpoint(baseUrl: Variable.baseUrl);
  }
}
