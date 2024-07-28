import 'package:campus_square_app/logic/login_data/types/login_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDataCache {
  Future<void> saveLoginData(LoginData loginData) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('userName', loginData.userName);
    await prefs.setString('password', loginData.password);
  }

  Future<LoginData?> getLoginData() async {
    final prefs = await SharedPreferences.getInstance();

    final userName = prefs.getString('userName');
    final password = prefs.getString('password');

    if (userName == null || password == null) {
      return null;
    }
    return LoginData(
      userName: userName,
      password: password,
    );
  }

  Future<void> deleteLoginData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('userName');
    await prefs.remove('password');
  }
}