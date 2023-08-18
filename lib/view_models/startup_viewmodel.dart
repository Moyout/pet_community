import 'dart:async';
import 'dart:math';

import 'package:pet_community/util/tools.dart';
import 'package:pet_community/views/navigation_view.dart';

class StartUpViewModel extends ChangeNotifier {
  late Timer _timer;
  int seconds = 4; //秒数
  late int jpgFileCount;
  late int random = 1; //随机

  // late Uint8List bytes; //启动图
  ///初始化ViewModel
  void initViewModel(BuildContext context) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    getLaunchImageInfo();
    timerDown(context);
  }

  ///倒计时
  void timerDown(BuildContext context) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds == 0) {
        _timer.cancel();
        pushNewPage(context);
      } else {
        seconds--;
      }

      notifyListeners();
    });
  }

  ///进入主页
  void pushNewPage(BuildContext context) {
    _timer.cancel();
    RouteUtil.pushReplacementNamed(context, NavigationView.routeName);
  }

  ///启动图
  Future<void> getLaunchImageInfo() async {
    var result = await BaseRequest().toGet("${ApiConfig.baseUrl}/open/petPicturesCount/");
    if (result != null) {
      jpgFileCount = result["data"]["jpgFileCount"] ?? 10;
      // random = Random().nextInt(jpgFileCount);
      random = Random().nextInt(jpgFileCount);
      notifyListeners();
    }
    debugPrint("jpgFileCount      $jpgFileCount");
    debugPrint("random--------->${random}");
    // bytes = BaseToUint8List().base64ToImage("");
  }
}
