import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/init_viewmodel.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/views/Live/live_view.dart';
import 'package:pet_community/views/community/community_view.dart';
import 'package:pet_community/views/home/home_view.dart';
import 'package:pet_community/views/mine/mine_view.dart';
import 'package:pet_community/widget/painters/live_button_painter.dart';

import 'message/message_view.dart';

class NavigationView extends StatefulWidget {
  static const String routeName = '/';

  const NavigationView({Key? key}) : super(key: key);

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    context.read<NavViewModel>().initViewModel(this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.watch<NavViewModel>().scaffoldKey,
      resizeToAvoidBottomInset: false,
      endDrawer: Drawer(
        child: buildDrawer(context),
      ),
      body: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: context.watch<NavViewModel>().pageController,
            // onPageChanged: (i) => context.read<NavViewModel>().pageTo(i),///有冲突
            children: const [
              HomeView(),
              CommunityView(),
              LiveView(),
              MessageView(),
              MineView(),
            ],
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom == 0 ? 10.w : MediaQuery.of(context).padding.bottom / 2 + 5.w,
            left: 20.w,
            // height: 70.w,
            right: 20.w,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 10.w, 0, 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w),
                color: ThemeUtil.primaryColor(context),
                // color: Colors.red,
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  context.watch<NavViewModel>().bottomList.length,
                  (int index) {
                    return Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onPanDown: (v) => context.read<NavViewModel>().onClickBottom(index),
                        onDoubleTap: () => context.read<NavViewModel>().onDoubleTap(index),
                        child: CustomPaint(
                          painter: context.watch<NavViewModel>().bottomList[index].isActive
                              ? LiveButtonPainter(
                                  paddingHeight: 10.w,
                                  primaryColor: ThemeUtil.primaryColor(context),
                                )
                              : null,
                          // size: Size(150, 150),
                          child: Container(
                            // padding: EdgeInsets.fromLTRB(0, 10.w, 0, 10.w),
                            child: Transform.rotate(
                              alignment: Alignment.bottomCenter,
                              angle: context.watch<NavViewModel>().bottomList[index].isActive
                                  ? context.watch<NavViewModel>().animation.value
                                  : 0,
                              child: AnimatedScale(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.bounceOut,
                                scale: context.watch<NavViewModel>().bottomList[index].isActive ? 1.1 : 1,
                                child: Image.asset(
                                  context.watch<NavViewModel>().bottomList[index].icon,
                                  width: 30.w,
                                  height: 30.w,
                                  fit: BoxFit.contain,
                                  color: context.watch<NavViewModel>().bottomList[index].isActive
                                      ? Colors.blueAccent
                                      : ThemeUtil.reversePrimaryColor(context),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDrawer(BuildContext context) {
    context.read<NavViewModel>().getCacheSize();
    return SafeArea(
      child: Column(
        children: [
          SwitchListTile(
            title: const Text("夜间模式"),
            value: context.watch<InitAppViewModel>().isDark,
            onChanged: (bool value) => context.read<NavViewModel>().setThemeMode(value, context),
          ),
          ListTile(
            onTap: context.watch<NavViewModel>().cacheSize > 0 ? () => context.read<NavViewModel>().clearCache() : null,
            title: Text(
              "清理缓存(${(context.watch<NavViewModel>().cacheSize / 1024 / 1024).roundToDouble()}M)",
              style: TextStyle(color: context.watch<NavViewModel>().cacheSize > 0 ? Colors.blue : Colors.grey),
            ),
          ),
          const Spacer(),
          if (context.read<NavViewModel>().isLogin)
            Container(
              width: double.infinity,
              color: ThemeUtil.reversePrimaryColor(context),
              height: 35.w,
              child: TextButton(
                onPressed: () => context.read<NavViewModel>().loginOut(context),
                child: const Text("退出登录", style: TextStyle(color: Colors.red)),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildLiveButton(int index) {
    return Container(
      // width: 70.w,
      // height: 30.w,
      // color: Colors.brown,
      child: Image.asset(
        context.watch<NavViewModel>().bottomList[index].icon,
        width: 30.w,
        height: 30.w,
        fit: BoxFit.contain,
        color: context.watch<NavViewModel>().bottomList[index].isActive
            ? Colors.blueAccent
            : ThemeUtil.reversePrimaryColor(context),
      ),
    );
  }
}

class NavBottomModel {
  String name;
  String icon;
  bool isActive;

  NavBottomModel({
    required this.name,
    required this.icon,
    this.isActive = false,
  });
}
