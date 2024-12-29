import 'package:shared_preferences/shared_preferences.dart';

import '../../model/response/login_response_model.dart';

abstract class AuthLocalDatasource {
  Future<void> saveAuthData(LoginModel data);
  Future<void> removeAuthData();
  Future<LoginModel> getAuthData();
  Future<bool> isLogin();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  @override
  Future<bool> isLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('auth_data');
  }

  @override
  Future<void> removeAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_data');
  }

  @override
  Future<LoginModel> getAuthData() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString('auth_data');
    if (data != null) {
      return LoginModel.fromJson(data);
    } else {
      throw Exception('Data not found');
    }
  }

  @override
  Future<void> saveAuthData(LoginModel data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_data', data.toJson());
  }
}
