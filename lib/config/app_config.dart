import 'package:pet_community/util/tools.dart';
import 'package:pet_community/widget/toast/ftoast_widget.dart';

class AppConfig {
  /// 初始化持久化数据
  static Future<void> initSp() async => await SpUtil.getInstance();

  /// 初始化Toast
  // static Future<void> initToast(BuildContext context) async => await FToastUtil.getInstance(context);

  ///错误widget
  static void errorWidget() {
    ///错误Widget
    ErrorWidget.builder = (FlutterErrorDetails details) {
      // Toast.showBottomToast(details.exception.toString());
      return Material(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "程序似乎崩溃了\n ${details.exception}",
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: () {
                  ///todo:上报
                },
                child: const Text("上报日志"),
              )
            ],
          ),
        ),
      );
    };
  }

  ///强制竖屏
  static void setScreenOrientations() => SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}
