import 'package:bot_toast/bot_toast.dart';

class ToastUtil {
  static showLoadingToast({int seconds = 1, bool clickClose = true}) {
    return BotToast.showLoading(
      duration: Duration(seconds: seconds),
      clickClose: clickClose,
      crossPage: false,
      backButtonBehavior: BackButtonBehavior.ignore, //拦截返回按键
    );
  }

  ///通知toast
  static showBotToast(String text, {int seconds = 3}) {
    return BotToast.showSimpleNotification(
      title: text,
      hideCloseButton: true,
      duration: Duration(seconds: seconds),
    );
  }

  ///底部toast
  static showBottomToast(String text, {int seconds = 3}) {
    return BotToast.showText(
      text: text,
      duration: Duration(seconds: seconds),
    );
  }

  static closeLoading() {
    return BotToast.cleanAll();
  }
}
