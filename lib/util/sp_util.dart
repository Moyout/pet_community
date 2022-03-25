///
///author: DJT
///created on: 2021/8/2 5:05
///
import 'package:pet_community/util/tools.dart';

class SpUtil {
  static SpUtil? _singleton;
  static SharedPreferences? _prefs;
  static final Lock _lock = Lock();

  static Future<SpUtil> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          // 保持本地实例直到完全初始化。
          var singleton = SpUtil._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton!;
  }

  SpUtil._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  ///存储String
  static Future<bool>? setString(String key, String value) {
    if (_prefs == null) return null;
    return _prefs!.setString(key, value);
  }

  ///存储StringList
  static Future<bool>? setStringList(String key, List<String> value) {
    if (_prefs == null) return null;
    return _prefs?.setStringList(key, value);
  }

  ///获取String
  static String? getString(String key) {
    if (_prefs == null) return null;
    String? status = _prefs?.getString(key);
    if (status == null) return "";
    return status;
  }

  ///获取String
  static List<String>? getStringList(String key) {
    if (_prefs == null) return null;
    List<String>? status = _prefs?.getStringList(key);
    if (status == null) return [];
    return status;
  }

  ///获取bool
  /// 根据key获取bool类型
  static bool? getBool(String key) {
    if (_prefs == null) return null;
    return _prefs?.getBool(key);
  }

  /// 根据key存储bool类型
  static Future<bool>? setBool(String key, bool value) {
    if (_prefs == null) return null;
    return _prefs?.setBool(key, value);
  }

  ///获取value
  static dynamic getValue(String key) {
    debugPrint("取值${_prefs?.getStringList(key)}");

    if (_prefs == null) return null;
    return _prefs?.get(key);
  }

  ///获取所有key
  static Set<String>? getKeys() {
    if (_prefs == null) return null;
    return _prefs?.getKeys();
  }

  /// 删除key
  static Future<bool>? remove(String key) {
    if (_prefs == null) return null;
    return _prefs?.remove(key);
  }
}
