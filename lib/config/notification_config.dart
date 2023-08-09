import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pet_community/models/chat/chat_record_model.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/views/message/chat/chat_view.dart';

class NotificationConfig {
  static final FlutterLocalNotificationsPlugin np = FlutterLocalNotificationsPlugin();
  static const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  static Future<void> initNotification() async {
    var android = const AndroidInitializationSettings("@mipmap/ic_launcher");
    // var ios = const IOSInitializationSettings();

    await np.initialize(
        InitializationSettings(
          android: android,
        ),
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse);
  }

  static onDidReceiveNotificationResponse(NotificationResponse details) {
    debugPrint("actionId--------->${details.actionId}");
    debugPrint("details--id------->${details.id}");
    debugPrint("details--payload------->${details.payload}");
    debugPrint("details--input------->${details.input}");
    if (details.payload != null) {
      dynamic data = jsonDecode(details.payload!);
      debugPrint("data- 231--- ----->${data}");
      ChatRecordModel? crm = ChatRecordModel.fromJson(data);
      debugPrint("crm- userId--- ----->${crm.userId}");
      if (crm.userId != 0) {
        RouteUtil.pushByCupertino(
          AppUtils.getContext(),
          ChatView(userId: crm.userId),
        );
      }
    }
    debugPrint("details--notificationResponseType------->${details.notificationResponseType}");
  }

  static onDidReceiveBackgroundNotificationResponse(NotificationResponse response) {
    debugPrint("response--------->${response.actionId}");
    debugPrint("response--id------->${response.id}");
    debugPrint("response--payload------->${response.payload}");
    debugPrint("response--input------->${response.input}");
    if (response.payload != null) {
      dynamic data = jsonDecode(response.payload!);
      debugPrint("data- 231--- ----->${data}");
      debugPrint("data- userId--- ----->${data.userId}");
    }
    debugPrint("details--notificationResponseType------->${response.notificationResponseType}");
  }

  static void send(String title, String body, {required int notificationId, String? params}) {
    // 构建描述
    var androidDetails = const AndroidNotificationDetails(
      //区分不同渠道的标识
      'channelId',
      //channelName渠道描述不要随意填写，会显示在手机设置，本app 、通知列表中，
      //规范写法根据业务：比如： 重要通知，一般通知、或者，交易通知、消息通知、等
      '社区消息通知',
      //通知的级别
      importance: Importance.max,
      priority: Priority.max,

      //可以单独设置每次发送通知的图标
      // icon: ''
      //显示进度条 3个参数必须同时设置
      // progress: 19,
      // maxProgress: 100,
      // showProgress: true
    );
    //ios配置选项相对较少
    var details = NotificationDetails(android: androidDetails);

    // 显示通知, 第一个参数是id,id如果一致则会覆盖之前的通知
    // String? payload, 点击时可以拿到的参数
    np.show(notificationId, title, body, details, payload: params);
  }

  static void closeNotification(int id, {String? tag}) {
    np.cancel(id, tag: tag);
  }

  static void cleanNotification() {
    np.cancelAll();
  }
}
