import '/utils/utils.dart';

class LocalStorage {
  static final LocalStorage instance = LocalStorage._init();
  static SharedPreferences? _prefs;
  LocalStorage._init();

  Future<SharedPreferences> get prefs async {
    if (_prefs != null) return _prefs!;
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<String> getDisplayName() async {
    String deviceId = (await PlatformDeviceId.getDeviceId)!;
    final pref = await instance.prefs;
    return pref.getString('displayName') ?? 'User $deviceId';
  }
}
