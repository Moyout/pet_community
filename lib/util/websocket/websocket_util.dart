import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:pet_community/models/chat/chat_record_model.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/message/chat_record_viewmodel.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/view_models/sign_login/login_viewmodel.dart';
import 'package:pet_community/views/message/chat/chat_view.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:synchronized/synchronized.dart';
import 'package:synchronized/extension.dart';

class WebSocketUtils {
  WebSocketUtils._internal();

  static final WebSocketUtils _socketUtils = WebSocketUtils._internal();
  IOWebSocketChannel? channel;
  StreamSubscription? subscription;
  static final Lock lock = Lock();

  factory WebSocketUtils() {
    return _socketUtils;
  }

  void initSocket() {
    bool? isLogin = SpUtil.getBool(PublicKeys.isLogin) ?? false;
    if (isLogin) {
      String? token = SpUtil.getString(PublicKeys.token);
      int? userId = SpUtil.getInt(PublicKeys.userId);
      if (token != null && userId != null) {
        if (AppUtils.getContext().read<NavViewModel>().netMode != ConnectivityResult.none) {
          debugPrint("尝试连接webSocket---------> ${ApiConfig.wsUrl}/chat?userId=$userId");

          channel ??= IOWebSocketChannel.connect(
            Uri.parse("${ApiConfig.wsUrl}/chat?userId=$userId"),
            protocols: [token],
            pingInterval: const Duration(seconds: 20),
          );

          subscription = channel?.stream.listen(
            _onData,
            onError: _onError,
            onDone: _onDone,
          );
        }
      }
    }
  }

  _onData(msg) async {
    NavViewModel nvm = AppUtils.getContext().read<NavViewModel>();
    int? userId = SpUtil.getInt(PublicKeys.userId);

    debugPrint("msg--------->$msg");
    dynamic data = jsonDecode(msg);
    ChatRecordModel crm = ChatRecordModel.fromJson(data);
    debugPrint("msg--fromJson----crm--------》》${crm.data}");
    if (crm.data != null || crm.msg != null) {
      if (crm.receiverId == userId) {
        if (nvm.contactList[crm.userId] == null) {
          nvm.contactList.addAll({crm.userId: []});
        }
        nvm.contactList[crm.userId]?.add(crm);

        if (await Permission.notification.request().isGranted) {
           if (AppRoute.currRoute != ChatView.routeName) {
            NotificationConfig.send("你有一条来自社区的信息", crm.data, notificationId: crm.userId, params: msg);
          }
        }
        // bool showTime = false;
        // lock.synchronized(() async {
        //   showTime = await ChatRecordDB.isShowTimeByRecentlyRecord(userId, crm.userId, crm.sendTime);
        // });
        // debugPrint("lock--1------->${lock.inLock}");
        // lock.synchronized(() async {
          await ChatRecordDB.insertData(userId!, crm, crm.userId );
        // });

        AppUtils.getContext().read<ChatRecordViewModel>().wsInsertRecord(crm, crm.userId);
        nvm.sortChatList();
      }
    }

    if (crm.code == -2 || crm.code == 1007 || crm.code == 1008) {
      LoginViewModel.tokenExpire(msg: crm.msg);
    }
    debugPrint("chatList--------------》》${nvm.contactList}");
  }

  _onDone() {
    debugPrint("消息关闭");
    dispose();
  }

  _onError(err) {
    debugPrint("消息错误$err");
    dispose();
  }

  void send(dynamic data) {
    if (channel == null) {
      initSocket();
    }
    channel?.sink.add(data);
  }

  void dispose() {
    subscription?.cancel();
    channel?.sink.close();
    channel = null;
    debugPrint("socket通道关闭");
    debugPrint("    channel?.stream-2-------->${channel?.stream}");
  }
}
