import '/utils/utils.dart';

class LocalStorage {
  static final LocalStorage instance = LocalStorage._init();
  static late SharedPreferences _prefs;
  LocalStorage._init();

  Future<SharedPreferences> get prefs async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }
}
