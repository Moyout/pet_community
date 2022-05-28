import 'package:pet_community/config/api_config.dart';
import 'package:pet_community/enums/drag_state_enum.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/mine/mine_viewmodel.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/view_models/startup_viewmodel.dart';
import 'package:pet_community/views/mine/works_tab.dart';
import 'package:pet_community/views/sign_login/sign_login_view.dart';
import 'package:pet_community/widget/common/unripple.dart';
import 'package:pet_community/widget/delegate/sliver_header_delegate.dart';

class MineView extends StatefulWidget {
  const MineView({Key? key}) : super(key: key);

  @override
  State<MineView> createState() => _MineViewState();
}

class _MineViewState extends State<MineView> with SingleTickerProviderStateMixin {
  late TabController tC;
  double tabViewHeight = 300.w;

  @override
  void initState() {
    tC = TabController(length: 2, vsync: this);
    context.read<MineViewModel>().initViewModel();
    super.initState();
  }

  EdgeInsetsGeometry horizontalPadding = EdgeInsets.symmetric(horizontal: 16.w);

  TextStyle textStyle = TextStyle(fontSize: 12.sp, color: Colors.grey, overflow: TextOverflow.ellipsis);
  TextStyle textStyle2 = TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis);

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
                        child: Image.network(
                          context.watch<NavViewModel>().isLogin
                              ? context.watch<NavViewModel>().userInfoModel?.data?.background ??
                                  ApiConfig.baseUrl + "/images/pet${context.read<StartUpViewModel>().random}.jpg"
                              : ApiConfig.baseUrl + "/images/pet${context.read<StartUpViewModel>().random}.jpg",
                          fit: BoxFit.cover,
                          height: 400.w,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -1.w,
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
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () => context.read<MineViewModel>().likesOnTap(context),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("获赞", style: textStyle),
                                  Text("0", style: textStyle2),
                                ],
                              ),
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
                        onTap: () => context.read<MineViewModel>().avatarOnTap(context),
                        child: Container(
                          width: 70.w,
                          height: 70.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50.w)),
                            border: Border.all(color: Colors.white, width: 3.w),
                          ),
                          child: Hero(
                            tag: "avatar",
                            child: ClipOval(
                              child: Image.network(
                                !context.watch<NavViewModel>().isLogin
                                    ? ApiConfig.baseUrl + "/images/pet${context.read<StartUpViewModel>().random}.jpg"
                                    : context.watch<NavViewModel>().userInfoModel?.data?.avatar == "" ||
                                            context.watch<NavViewModel>().userInfoModel?.data?.avatar == null
                                        ? ApiConfig.baseUrl +
                                            "/images/pet${context.read<StartUpViewModel>().random}.jpg"
                                        : context.watch<NavViewModel>().userInfoModel?.data?.avatar ?? "",
                                width: 70.w,
                                height: 70.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (!context.watch<NavViewModel>().isLogin)
                      Positioned(
                        bottom: 6.w,
                        left: 15.w,
                        child: GestureDetector(
                          onTap: () => context.read<MineViewModel>().avatarOnTap(context),
                          child: ClipOval(
                            child: Container(
                              width: 70.w,
                              height: 70.w,
                              color: Colors.black.withOpacity(0.5),
                              alignment: Alignment.center,
                              child: const Text("登录", style: TextStyle(color: Colors.white)),
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
                maxHeight: kToolbarHeight + 10.w,
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
                                    child: Container(
                                      // color: Colors.red,
                                      width: 220.w,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        !context.watch<NavViewModel>().isLogin
                                            ? "--"
                                            : context.watch<NavViewModel>().userInfoModel?.data?.userName ?? "--",
                                        style: textStyle2,
                                      ),
                                    ),
                                  ),
                                  if (context.watch<NavViewModel>().isLogin)
                                    Expanded(
                                      child: Container(
                                        color: ThemeUtil.primaryColor(context),
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if (context.watch<NavViewModel>().userInfoModel?.data!.sex != "保密")
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.w),
                                                margin: EdgeInsets.only(right: 5.w),
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.withOpacity(0.5),
                                                  borderRadius: BorderRadius.circular(2.w),
                                                  // color: ThemeUtil.primaryColor(context),
                                                ),
                                                child: Row(
                                                  children: [
                                                    context.watch<NavViewModel>().userInfoModel?.data!.sex == "男"
                                                        ? const Icon(Icons.male_outlined, color: Colors.blue, size: 14)
                                                        : const Icon(Icons.female, color: Colors.red, size: 14),
                                                    Text(
                                                      " ${context.watch<NavViewModel>().userInfoModel?.data!.sex} ",
                                                      style: textStyle.copyWith(
                                                        fontSize: 10.sp,
                                                        color: ThemeUtil.reversePrimaryColor(context),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            if (context.watch<NavViewModel>().userInfoModel?.data!.area != "未设置")
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.w),
                                                margin: EdgeInsets.only(right: 5.w),
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.withOpacity(0.5),
                                                  borderRadius: BorderRadius.circular(2.w),
                                                  // color: ThemeUtil.primaryColor(context),
                                                ),
                                                child: Text(
                                                  context.watch<NavViewModel>().userInfoModel?.data?.area ?? "--",
                                                  style: textStyle.copyWith(
                                                    fontSize: 10.sp,
                                                    color: ThemeUtil.reversePrimaryColor(context),
                                                  ),
                                                ),
                                              ),
                                            GestureDetector(
                                              onTap: () => context.read<NavViewModel>().isLogin
                                                  ? context.read<NavViewModel>().editData(context)
                                                  : RouteUtil.push(context, const SignLoginView()),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.w),
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.withOpacity(0.5),
                                                  borderRadius: BorderRadius.circular(2.w),
                                                  // color: ThemeUtil.primaryColor(context),
                                                ),
                                                child: Text(
                                                  "+标签",
                                                  style: textStyle.copyWith(
                                                    fontSize: 10.sp,
                                                    color: ThemeUtil.reversePrimaryColor(context),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const Spacer(),
                              SizedBox(
                                width: 80.w,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.grey.withOpacity(0.5),
                                    primary: ThemeUtil.reversePrimaryColor(context),
                                  ),
                                  onPressed: () => context.read<NavViewModel>().isLogin
                                      ? context.read<NavViewModel>().editData(context)
                                      : RouteUtil.push(context, const SignLoginView()),
                                  child: Text("编辑资料", style: TextStyle(fontSize: 12.sp)),
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
                padding: horizontalPadding.add(EdgeInsets.symmetric(vertical: 5.w)),
                color: ThemeUtil.primaryColor(context),
                width: 250.w,
                child: Text(
                  context.watch<NavViewModel>().userInfoModel?.data?.signature ?? "--",
                  maxLines: 6,
                  style: textStyle,
                ),
              ),
            ),
            SliverToBoxAdapter(child: Container(color: ThemeUtil.primaryColor(context), height: 10)),
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
                    onTap: (index) {},
                    tabs: const [Text("作品"), Text("收藏")],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: ThemeUtil.primaryColor(context),
                height: tabViewHeight,
                child: TabBarView(
                  controller: tC,
                  children: [
                    const WorksTab(),
                    Container(
                      child: Text("tabBarView2"),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(child: Container(height: 55.w, color: ThemeUtil.primaryColor(context))),
          ],
        ),
      ),
    );
  }
}
