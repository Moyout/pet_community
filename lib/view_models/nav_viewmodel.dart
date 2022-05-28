import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:pet_community/models/user/user_info_model.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/views/mine/edit_data/edit_data_view.dart';
import 'package:pet_community/views/navigation_view.dart';
import 'package:vibration/vibration.dart';

class NavViewModel extends ChangeNotifier {
  PageController pageController = PageController();
  late ConnectivityResult netMode = ConnectivityResult.wifi; //网络
  StreamSubscription<ConnectivityResult>? subscription;
  UserInfoModel? userInfoModel = UserInfoModel();
  bool isLogin = false;

  ///页面控制器
  late AnimationController animationController;

  ///控制器
  late Animation animation;
  List<NavBottomModel> bottomList = [
    ///导航栏
    NavBottomModel(name: "首页", icon: "assets/icons/home.png", isActive: true),
    NavBottomModel(name: "发现", icon: "assets/icons/community.png"),
    NavBottomModel(name: "信息", icon: "assets/icons/chat.png"),
    NavBottomModel(name: "我的", icon: "assets/icons/mine.png"),
  ];

  ///初始化viewModel
  void initViewModel(TickerProvider tickerProvider) {
    initAnimation(tickerProvider);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      getSpUserInfoModel();
    });
  }

  void getSpUserInfoModel() {
    // isLogin = SpUtil.getBool(PublicKeys.isLogin) ?? false;
    isLogin = SpUtil.getBool(PublicKeys.isLogin) ?? false;
    print("isLogin-------$isLogin");
    if (isLogin) {
      try {
        Map userInfoMap = SpUtil.getObj("UserInfoModel");
        userInfoModel = UserInfoModel.fromJson(userInfoMap);
      } catch (e) {
        print(e);
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
      TweenSequenceItem<double>(tween: Tween(begin: 0, end: -0.3), weight: 1),
      TweenSequenceItem<double>(tween: Tween(begin: -0.3, end: 0), weight: 1),
      TweenSequenceItem<double>(tween: Tween(begin: 0, end: 0.3), weight: 1),
      TweenSequenceItem<double>(tween: Tween(begin: 0.3, end: 0), weight: 1),
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
        Vibration.vibrate(duration: 60);
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
        // Toast.showBottomToast("当前为流量连接,请注意使用");
      } else if (result == ConnectivityResult.wifi) {
      } else if (result == ConnectivityResult.none) {
        // Toast.showBottomToast("网络错误");
      }
      netMode = result;
      notifyListeners();
    });
  }

  Future<void> editData(BuildContext context) async {
    if (isLogin) {
      String? token = SpUtil.getString(PublicKeys.token);
      int? userId = SpUtil.getInt(PublicKeys.userId);
      userInfoModel = await UserInfoRequest.getUserInfo(userId!, token!);
      RouteUtil.push(context, EditDataView());
    } else {}
  }
}
