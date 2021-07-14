import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static const String U_ID = 'uId';
  static const String IS_LOGGED = 'isLogged';

  static final SharedPreference _instance = SharedPreference._internal();

  SharedPreferences _sharedPreferences;

  bool isLogged = false;

  var uId = '';

  SharedPreference._internal();

  factory SharedPreference() => _instance;

  Future<SharedPreferences> get _preferences async {
    if (_sharedPreferences != null) {
      return _sharedPreferences;
    } else {
      _sharedPreferences = await SharedPreferences.getInstance();

      isLogged = _sharedPreferences.getBool(IS_LOGGED);
      uId = _sharedPreferences.getString(U_ID);

      if (isLogged == null) {
        isLogged = false;
        uId = '';
      }

      return _sharedPreferences;
    }
  }

  Future<void> savePreference() async {
    await _sharedPreferences.setBool(IS_LOGGED, isLogged);
    await _sharedPreferences.setString(U_ID, uId);
  }

  Future<void> deletePreference() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return await _sharedPreferences?.clear();
  }

  Future<void> deleteResourcePref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.remove(U_ID);
  }

  Future<SharedPreference> init() async {
    _sharedPreferences = await _preferences;
    return this;
  }
}
