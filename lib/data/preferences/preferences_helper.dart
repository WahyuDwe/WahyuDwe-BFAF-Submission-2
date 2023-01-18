import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const dailyResto = 'DAILY_RESTO';

  Future<bool> get isDailyRestoActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyResto) ?? false;
  }

  void setDailyResto(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyResto, value);
  }
}