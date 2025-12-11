import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const _subscribedKey = 'is_subscribed';
  final SharedPreferences _prefs;

  LocalStorage._(this._prefs);

  static Future<LocalStorage> init() async {
    final prefs = await SharedPreferences.getInstance();
    return LocalStorage._(prefs);
  }

  bool get isSubscribed => _prefs.getBool(_subscribedKey) ?? false;
  //bool get isSubscribed => false;

  Future<void> setSubscribed(bool value) async {
    await _prefs.setBool(_subscribedKey, value);
  }
}
