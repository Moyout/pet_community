import 'dart:async';
import 'dart:math';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/views/navigation_view.dart';

class StartUpViewModel extends ChangeNotifier {
  late Timer _timer;
  int seconds = 4; //秒数
  int random = Random().nextInt(10) + 1; //随机

  // late Uint8List bytes; //启动图
  ///初始化ViewModel
  void initViewModel(BuildContext context) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    // getLaunchImage();
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
    RouteUtil.pushReplacement(context, const NavigationView());
  }

  // ///启动图
  // Future<void> getLaunchImage() async {
  //   // bytes = BaseToUint8List().base64ToImage("");
  // }
}
