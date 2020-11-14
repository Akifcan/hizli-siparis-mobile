import 'package:shared_preferences/shared_preferences.dart';

class SharedManager {
  static final SharedManager _sharedManager = SharedManager._internal();

  factory SharedManager() {
    return _sharedManager;
  }

  SharedManager._internal();

  save(String key, dynamic value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  getValue(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }
}
