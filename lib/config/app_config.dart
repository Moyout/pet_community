// import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:pet_community/util/tools.dart';

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
  static void setScreenOrientations() =>
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  ///初始化极光推送
  static void startJPush() {
    // JPush jpush = JPush();
    //配置jpush(不要省略）
    //debug就填debug:true，生产环境production:true
    // jpush.setup(appKey: '5248bceabc505fc3c349b32a', channel: 'developer-default', production: true, debug: true);
    //监听jpush(ios必须配置)
    // jpush.applyPushAuthority(
    //     const NotificationSettingsIOS(sound: true, alert: true, badge: true));
    // jpush.addEventHandler(
    //   onReceiveNotification: (Map<String, dynamic> message) async {
    //     print('message11:$message');
    //   },
    //   onOpenNotification: (Map<String, dynamic> message) async {
    //     点击通知栏消息，在此时通常可以做一些页面跳转等
    // print('message22:$message');
    // },
    // );
  }
}
