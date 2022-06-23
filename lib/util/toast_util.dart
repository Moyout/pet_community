import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:pet_community/util/tools.dart';

class ToastUtil {
  ///loading
  static showLoadingToast({int seconds = 1, bool clickClose = true}) {
    return BotToast.showLoading(
      duration: Duration(seconds: seconds),
      clickClose: clickClose,
      crossPage: false,
      backButtonBehavior: BackButtonBehavior.ignore, //拦截返回按键
    );
  }

  ///Custom
  static showCustomLoadingToast({int seconds = 1, bool clickClose = true}) {
    return BotToast.showCustomLoading(toastBuilder: (CancelFunc cancelFunc) {
      return Container(
        alignment: Alignment.center,
        width: 60.w,
        height: 60.w,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: const CupertinoActivityIndicator(color: Colors.white),
      );
    });
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
    return BotToast.closeAllLoading();
  }
}
