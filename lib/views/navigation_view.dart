import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/views/chat/chat_view.dart';
import 'package:pet_community/views/community/community_view.dart';
import 'package:pet_community/views/home/home_view.dart';
import 'package:pet_community/views/mine/mine_view.dart';

class NavigationView extends StatefulWidget {
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
      body: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: context.watch<NavViewModel>().pageController,
            // onPageChanged: (i) => context.read<NavViewModel>().pageTo(i),///有冲突
            children: const [
              HomeView(),
              CommunityView(),
              ChatView(),
              MineView(),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).padding.bottom + 5.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                color: Colors.white,
              ),
              child: Row(
                children: List.generate(context.watch<NavViewModel>().bottomList.length, (int index) {
                  return Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onPanDown: (v) => context.read<NavViewModel>().onClickBottom(index),
                      onDoubleTap: () => context.read<NavViewModel>().onDoubleTap(index),
                      child: Column(
                        children: [
                          Transform.rotate(
                            alignment: Alignment.bottomCenter,
                            angle: context.watch<NavViewModel>().bottomList[index].isActive
                                ? context.watch<NavViewModel>().animation.value
                                : 0,
                            child: AnimatedScale(
                              duration: const Duration(milliseconds: 100),
                              scale: context.watch<NavViewModel>().bottomList[index].isActive ? 1.2 : 1,
                              child: Image.asset(
                                context.watch<NavViewModel>().bottomList[index].icon,
                                width: 34.w,
                                height: 34.w,
                                color: context.watch<NavViewModel>().bottomList[index].isActive
                                    ? Colors.deepPurpleAccent
                                    : Colors.grey,
                              ),
                            ),
                          ),
                          Text(
                            context.watch<NavViewModel>().bottomList[index].name,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: context.watch<NavViewModel>().bottomList[index].isActive
                                  ? Colors.deepPurpleAccent
                                  : Colors.grey,
                              height: 0.8.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
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
