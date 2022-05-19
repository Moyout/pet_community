import 'package:pet_community/enums/drag_state_enum.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/mine/mine_viewmodel.dart';
import 'package:pet_community/views/sign_login/sign_login_view.dart';
import 'package:pet_community/views/sign_login/sign_view.dart';
import 'package:pet_community/widget/common/unripple.dart';
import 'package:pet_community/widget/delegate/sliver_header_delegate.dart';

class MineView extends StatefulWidget {
  const MineView({Key? key}) : super(key: key);

  @override
  State<MineView> createState() => _MineViewState();
}

class _MineViewState extends State<MineView> with SingleTickerProviderStateMixin {
  late TabController tC;
  double tabViewHeight = 300;

  @override
  void initState() {
    tC = TabController(length: 2, vsync: this);
    context.read<MineViewModel>().initViewModel();
    super.initState();
  }

  EdgeInsetsGeometry horizontalPadding = EdgeInsets.symmetric(horizontal: 16.w);

  TextStyle textStyle = TextStyle(
    fontSize: 10.sp,
    color: Colors.grey,
    overflow: TextOverflow.ellipsis,
  );
  TextStyle textStyle2 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    overflow: TextOverflow.ellipsis,
  );

  @override
  Widget build(BuildContext context) {
    MineViewModel mvModelR = context.read<MineViewModel>();
    MineViewModel mvModelW = context.watch<MineViewModel>();
    return Scaffold(
      body: Listener(
        onPointerDown: (_) => mvModelR.dragState = DragState.dragStateBegin,
        onPointerUp: (_) {
          mvModelR.dragState = DragState.dragStateEnd;
          mvModelR.restWithAnimation(false);
        },
        child: CustomScrollView(
          controller: mvModelW.controller,
          scrollBehavior: OverScrollBehavior(),
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                constraints: BoxConstraints(
                  minHeight: MineViewModel.defaultHeight,
                  maxHeight: MineViewModel.maxHeight,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      child: Transform.scale(
                        scale: 1 + mvModelW.scale,
                        child: Image.asset("assets/images/launch_images/pet5.jpg", fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 60.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10.w)),
                          // color: ThemeUtil.primaryColor(context),
                          gradient: LinearGradient(
                            colors: [
                              ThemeUtil.primaryColor(context),
                              ThemeUtil.primaryColor(context).withOpacity(0.6),
                            ],
                            stops: const [0.3, 1],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("获赞", style: textStyle),
                                Text("0", style: textStyle2),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("关注", style: textStyle),
                                Text("0", style: textStyle2),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("粉丝", style: textStyle),
                                Text("0", style: textStyle2),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 6.w,
                      left: 15.w,
                      child: GestureDetector(
                        onTap: () {
                          RouteUtil.push(context, SignLoginView());
                        },
                        child: Container(
                          width: 70.w,
                          height: 70.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50.w)),
                            border: Border.all(color: Colors.white, width: 3.w),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              "assets/images/launch_images/pet5.jpg",
                              width: 70.w,
                              height: 70.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            SliverPersistentHeader(
              pinned: true,
              delegate: SliverHeaderDelegate(
                minHeight: kToolbarHeight,
                maxHeight: kToolbarHeight,
                child: Container(
                  alignment: Alignment.centerLeft,
                  color: ThemeUtil.primaryColor(context),
                  child: (MineViewModel.offsetY / MineViewModel.maxHeight) >= 1
                      ? const SizedBox()
                      : Container(
                          padding: horizontalPadding,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      width: 150.w,
                                      child: Text("userName ", style: textStyle2),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: 250.w,
                                      child: Text(
                                        "signature signaturesignature signaturesignature signaturesignature se signaturesignature se signaturesignature signaturesignature signature  ",
                                        style: textStyle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Container(
                                width: 80.w,
                                height: 30.w,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.grey.withOpacity(0.5),
                                    primary: ThemeUtil.reversePrimaryColor(context),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "编辑资料",
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Container(
                color: ThemeUtil.primaryColor(context),
                alignment: Alignment.centerLeft,
                padding: horizontalPadding,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.w),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(2.w),
                    // color: ThemeUtil.primaryColor(context),
                  ),
                  child: Text(
                    " 地区 ",
                    style: textStyle.copyWith(
                      fontSize: 10.sp,
                      color: ThemeUtil.reversePrimaryColor(context),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(color: ThemeUtil.primaryColor(context), height: 10),
            ),
            // if ((MineViewModel.offsetY / MineViewModel.maxHeight) >= 1)
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverHeaderDelegate(
                minHeight: 30.w,
                maxHeight: 30.w,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ThemeUtil.primaryColor(context),
                  ),
                  child: TabBar(
                    controller: tC,
                    onTap: (index) {
                      if (tC.index == 1) {
                        tabViewHeight = 500;
                      } else {
                        tabViewHeight = 300;
                      }
                      setState(() {});
                    },
                    tabs: [
                      Text("作品"),
                      Text("收藏"),
                    ],
                  ),
                ),
              ),
            ),

            SliverFillRemaining(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Container(
                    color: ThemeUtil.primaryColor(context),
                    height: tabViewHeight,
                    child: TabBarView(
                      controller: tC,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/backgrounds/noContent.png"),
                              const Text("无内容"),
                            ],
                          ),
                        ),
                        Container(
                          child: Text("tabBarView2"),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
