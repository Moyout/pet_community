import 'dart:async';

import 'package:pet_community/models/article/user_article_model.dart';
import 'package:pet_community/models/chat/chat_record_model.dart';
import 'package:pet_community/models/user/user_info_model.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/init_viewmodel.dart';
import 'package:pet_community/view_models/mine/mine_viewmodel.dart';
import 'package:pet_community/views/mine/edit_data/edit_data_view.dart';
import 'package:pet_community/views/navigation_view.dart';
import 'package:pet_community/views/sign_login/sign_login_view.dart';
import 'package:pet_community/views/startup_view.dart';

class NavViewModel extends ChangeNotifier {
  PageController pageController = PageController();
  late ConnectivityResult netMode = ConnectivityResult.wifi; //网络
  StreamSubscription<ConnectivityResult>? subscription;
  UserInfoModel? userInfoModel = UserInfoModel();
  bool isLogin = false;
  var scaffoldKey = GlobalKey<ScaffoldState>(); //将Scaffold设置为全局变量
  int cacheSize = 0;

  Map<int, List<ChatRecordModel>> contactList = {}; //聊天记录列表

  ///页面控制器
  late AnimationController animationController;

  ///控制器
  late Animation animation;
  List<NavBottomModel> bottomList = [
    ///导航栏
    NavBottomModel(name: "首页", icon: "assets/icons/home.png", isActive: true),
    NavBottomModel(name: "发现", icon: "assets/icons/community.png"),
    NavBottomModel(name: "直播", icon: "assets/icons/paw.png"),
    NavBottomModel(name: "信息", icon: "assets/icons/chat.png"),
    NavBottomModel(name: "我的", icon: "assets/icons/mine.png"),
  ];

  ///初始化viewModel
  Future<void> initViewModel(TickerProvider tickerProvider) async {
    initAnimation(tickerProvider);
    getCacheSize();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getSpUserInfoModel();
    });
    WebSocketUtils().initSocket(); //websocket
  }

  ///初始化登录信息
  void getSpUserInfoModel() {
    isLogin = SpUtil.getBool(PublicKeys.isLogin) ?? false;
    debugPrint("isLogin-------$isLogin");
    if (isLogin) {
      try {
        Map? userInfoMap = SpUtil.getObj("UserInfoModel");
        if (userInfoMap != null) userInfoModel = UserInfoModel.fromJson(userInfoMap);
        initDatabase(userInfoModel?.data?.userId);
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      userInfoModel = null;
    }
    notifyListeners();
  }

  ///初始化动画
  void initAnimation(TickerProvider tickerProvider) {
    animationController = AnimationController(vsync: tickerProvider, duration: const Duration(milliseconds: 300));
    animation = TweenSequence<double>([
      TweenSequenceItem<double>(tween: Tween(begin: 0, end: -0.4), weight: 1),
      TweenSequenceItem<double>(tween: Tween(begin: -0.4, end: 0), weight: 1),
      TweenSequenceItem<double>(tween: Tween(begin: 0, end: 0.4), weight: 1),
      TweenSequenceItem<double>(tween: Tween(begin: 0.4, end: 0), weight: 1),
    ]).animate(animationController);
    animationController.addListener(() {
      notifyListeners();
    });
    animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
      }
    });
  }

  void pageTo(int index) {
    pageController.jumpToPage(index);
    // pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.linear);
    notifyListeners();
  }

  void onClickBottom(int index) {
    if (bottomList[index].isActive) {
      ///刷新
    } else {
      for (var element in bottomList) {
        element.isActive = false;
      }
      bottomList[index].isActive = true;
    }
    pageTo(index);
    notifyListeners();
  }

  ///双击导航栏
  Future<void> onDoubleTap(int index) async {
    if (bottomList[index].isActive) {
      animationController.reset();
      animationController.forward();
      if (await Vibration.hasVibrator() == true) {
        Vibration.vibrate(duration: 50);
      }
    } else {
      onClickBottom(index);
      pageTo(index);
    }
  }

  ///检查网络状态
  void checkNet() async {
    netMode = await Connectivity().checkConnectivity();
    subscription ??= Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile) {
        ToastUtil.showBottomToast(PublicKeys.netMobile);
      } else if (result == ConnectivityResult.wifi) {
      } else if (result == ConnectivityResult.none) {
        WebSocketUtils().dispose();
        ToastUtil.showBotToast(PublicKeys.netError, bgColor: PublicKeys.errorColor);
      }
      netMode = result;
      // if (AppRoute.currRoute != StartUpView.routeName) connectWebSocket();
      if (AppRoute.currRoute != StartUpView.routeName) WebSocketUtils().initSocket();
      notifyListeners();
      debugPrint("netMode--------->$netMode");
    });
  }

  ///编辑资料
  Future<void> editData(BuildContext context) async {
    if (isLogin) {
      String? token = SpUtil.getString(PublicKeys.token);
      int? userId = SpUtil.getInt(PublicKeys.userId);
      userInfoModel = await UserInfoRequest.getUserInfo(userId!, token!);
      if (userInfoModel?.code == 0) RouteUtil.pushNamed(context, EditDataView.routeName);
    } else {
      RouteUtil.pushNamed(context, SignLoginView.routeName);
    }
  }

  ///退出登录
  void loginOut(BuildContext context) {
    SpUtil.remove("UserInfoModel");
    SpUtil.remove(PublicKeys.token);
    AppUtils.getContext().read<NavViewModel>().isLogin = false;
    SpUtil.setBool(PublicKeys.isLogin, false);
    AppUtils.getContext().read<NavViewModel>().userInfoModel = UserInfoModel();
    AppUtils.getContext().read<MineViewModel>().userArticleModel = UserArticleModel();
    contactList.clear();

    AppUtils.getContext().read<MineViewModel>().notifyListeners();
    RouteUtil.pop(context);
    WebSocketUtils().dispose();

    notifyListeners();
  }

  ///设置日/夜间模式
  Future<void> setThemeMode(bool isDark, BuildContext context) async {
    context.read<InitAppViewModel>().isDark = isDark;
    context.read<InitAppViewModel>().notifyListeners();
    await SpUtil.setBool(PublicKeys.darkTheme, isDark);
    notifyListeners();
  }

  ///获取缓存
  Future<void> getCacheSize() async {
    cacheSize = await CacheUtil.total();
    notifyListeners();
  }

  ///清理缓存
  Future<void> clearCache() async {
    CacheUtil.clear();
    cacheSize = await CacheUtil.total();
    notifyListeners();
  }

  ///链接webSocket服务
  // Future<void> connectWebSocket() async {
  //   isLogin = SpUtil.getBool(PublicKeys.isLogin) ?? false;
  //
  //   if (isLogin) {
  //     String? token = SpUtil.getString(PublicKeys.token);
  //     int? userId = SpUtil.getInt(PublicKeys.userId);
  //     // if (token != null && userId != null) {
  //     //   try {
  //     //     if (ws == null) {
  //     //       ws = await WebSocket.connect(
  //     //         '${ApiConfig.wsUrl}/chat?userId=$userId',
  //     //         protocols: [token],
  //     //       );
  //     //       if (ws != null) {
  //     //         wsChannel = IOWebSocketChannel(ws!);
  //     //         wsChannel?.stream.listen(
  //     //           (dynamic msg) async {
  //     //             debugPrint("msg--------->${msg}");
  //     //             dynamic data = jsonDecode(msg);
  //     //             ChatRecordModel crm = ChatRecordModel.fromJson(data);
  //     //             debugPrint("code--------------》》${crm.code}");
  //     //             debugPrint("data--------------》》${crm.data}");
  //     //             debugPrint("userId--------------》》${crm.userId}");
  //     //             debugPrint("userInfoModel.id--------------》》${userInfoModel?.data?.userId}");
  //     //             if (crm.data != null || crm.msg != null) {
  //     //               if (crm.receiverId == userId) {
  //     //                 if (contactList[crm.userId] == null) {
  //     //                   contactList.addAll({crm.userId: []});
  //     //                 }
  //     //                 contactList[crm.userId]?.add(crm);
  //     //
  //     //                 if (await Permission.notification.request().isGranted) {
  //     //                   debugPrint("AppRoute.currRoute--------->${AppRoute.currRoute}");
  //     //                   if (AppRoute.currRoute != ChatView.routeName) {
  //     //                     NotificationConfig.send("你有一条来自社区的信息2", crm.data, notificationId: crm.userId, params: msg);
  //     //                   }
  //     //                 }
  //     //                 ChatRecordDB.insertData(userId, crm, crm.userId);
  //     //                 AppUtils.getContext().read<ChatRecordViewModel>().wsInsertRecord(crm, crm.userId);
  //     //                 sortChatList();
  //     //                 notifyListeners();
  //     //               }
  //     //             }
  //     //
  //     //             if (crm.code == -2 || crm.code == 1007 || crm.code == 1008) {
  //     //               LoginViewModel.tokenExpire(msg: crm.msg);
  //     //             }
  //     //             debugPrint("chatList--------------》》$contactList");
  //     //           },
  //     //           onDone: () {
  //     //             ws?.close();
  //     //             ws = null;
  //     //             wsChannel?.sink.close();
  //     //             wsChannel = null;
  //     //             // connectWebSocket();
  //     //             debugPrint("ws-onDone-onDone-------------》 ");
  //     //           },
  //     //           onError: (e) {
  //     //             debugPrint("ws 出错  --------------》》$e");
  //     //           },
  //     //         );
  //     //       }
  //     //     }
  //     //   } on SocketException catch (e) {
  //     //     debugPrint("SocketException--------------》》$e");
  //     //     connectWebSocket();
  //     //   }
  //     // }
  //   }
  // }

  ///初始化数据库
  Future<bool> initDatabase(int? userId) async {
    Database? db;
    if (isLogin) {
      if (userId != null) {
        db = await ChatRecordDB.initDatabase(userId);
      }
    }

    return db != null ? true : false;
  }

  ///聊天降序
  void sortChatList() {
    contactList = Map.fromEntries(contactList.entries.toList()
      ..sort((a1, a2) {
        return a2.value.last.sendTime.compareTo(a1.value.last.sendTime);
      }));
    notifyListeners();
  }
}
