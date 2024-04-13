import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  final tag = "SHARED_PREFERENCE_SERVICE";

  late SharedPreferences _prefs;

  Function get clearAllData => _clearAllData;

  Future<bool> getSharedPreferencesInstance() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future setUserMobileNumber({required String mobileNumber}) async {
    await _prefs.setString('mobileNumber', mobileNumber);
  }

  Future<String?> getUserMobileNumber() async {
    return _prefs.getString('mobileNumber');
  }

  Future setLoginStatus({required bool isLogin}) async {
    await _prefs.setBool('isLogin', isLogin);
  }

  Future<bool> getLoginStatus() async {
    return _prefs.getBool('isLogin') ?? false;
  }

  Future _clearAllData() async {
    await _prefs.clear();
  }
}

final SharedPreferenceService sharedPreferenceService =
    SharedPreferenceService();
