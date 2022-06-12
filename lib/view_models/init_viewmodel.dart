import 'package:pet_community/util/tools.dart';

class InitAppViewModel extends ChangeNotifier {
  bool isDark = false;

  ///初始化设置
  Future<void> appInitSetting() async {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      isDark = SpUtil.getBool(PublicKeys.darkTheme) ?? false;
      notifyListeners();
    });
  }
}
