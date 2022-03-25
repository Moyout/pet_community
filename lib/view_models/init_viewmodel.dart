
///
///author: DJT
///created on: 2021/8/2 5:37
///
import 'package:pet_community/util/tools.dart';

class InitAppViewModel extends ChangeNotifier{
  bool isDark = false;

  Future<void> appInitSetting() async {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      isDark = SpUtil.getBool(PublicKeys.darkTheme) ?? false;
       notifyListeners();
    });
  }
}
 
 