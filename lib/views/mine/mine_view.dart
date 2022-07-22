import 'package:flutter/cupertino.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/mine/mine_viewmodel.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/view_models/sign_login/sign_login_viewmodel.dart';
import 'package:pet_community/view_models/startup_viewmodel.dart';
import 'package:pet_community/views/mine/work/works_tab.dart';
import 'package:pet_community/views/sign_login/sign_login_view.dart';
import 'package:pet_community/widget/delegate/sliver_header_delegate.dart';

class MineView extends StatefulWidget {
  const MineView({Key? key}) : super(key: key);

  @override
  State<MineView> createState() => _MineViewState();
}

class _MineViewState extends State<MineView> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  double tabViewHeight = 150.w;
  bool isShowMore = false;

  @override
  void initState() {
    context.read<MineViewModel>().initViewModel(this);
    context.read<MineViewModel>().getUserWorks(context);
    super.initState();
  }

  EdgeInsetsGeometry horizontalPadding = EdgeInsets.symmetric(horizontal: 16.w);

  TextStyle textStyle = TextStyle(fontSize: 12.sp, color: Colors.grey, overflow: TextOverflow.ellipsis);
  TextStyle textStyle2 = TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    MineViewModel mvModelR = context.read<MineViewModel>();
    MineViewModel mvModelW = context.watch<MineViewModel>();
    return Scaffold(
      body: Listener(
        onPointerDown: (_) => mvModelR.dragState = DragState.dragStateBegin,
        onPointerUp: (_) {
          mvModelR.dragState = DragState.dragStateEnd;
          mvModelR.restWithAnimation(false);
        },
        child: Stack(
          children: [
            CustomScrollView(
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
                          child: GestureDetector(
                            onTap: () => context.read<MineViewModel>().backgroundOnTap(context),
                            child: Transform.scale(
                              scale: 1 + mvModelW.scale,
                              child: CachedNetworkImage(
                                imageUrl: context.watch<NavViewModel>().isLogin
                                    ? context.watch<NavViewModel>().userInfoModel?.data?.background ??
                                        ApiConfig.baseUrl + "/images/pet${context.read<StartUpViewModel>().random}.jpg"
                                    : ApiConfig.baseUrl + "/images/pet${context.read<StartUpViewModel>().random}.jpg",
                                fit: BoxFit.cover,
                                height: 400.w,
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                    const CupertinoActivityIndicator(),
                              ),
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
                                  onTap: () {
                                    if (context.read<NavViewModel>().isLogin) {
                                      showDialog(
                                        context: context,
                                        builder: (c) {
                                          return GestureDetector(
                                            onTap: () => Navigator.pop(context),
                                            child: Scaffold(
                                              backgroundColor: Colors.transparent,
                                              body: Container(
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(horizontal: 50.w),
                                                child: GestureDetector(
                                                  onTap: () {},
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Image.asset(
                                                        "assets/images/backgrounds/likes_background.png",
                                                        fit: BoxFit.cover,
                                                      ),
                                                      Container(
                                                        color: Colors.white,
                                                        width: double.infinity,
                                                        alignment: Alignment.center,
                                                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                                                        height: 80.w,
                                                        child: Text(
                                                          "\"${context.watch<NavViewModel>().userInfoModel?.data?.userName}\"共获得0个赞 ",
                                                          style: TextStyle(fontSize: 14.sp),
                                                        ),
                                                      ),
                                                      Divider(
                                                          height: 0.1,
                                                          thickness: 0.1,
                                                          color: Colors.grey.withOpacity(0.5)),
                                                      GestureDetector(
                                                        onTap: () => Navigator.pop(context),
                                                        child: Container(
                                                          color: Colors.white,
                                                          width: double.infinity,
                                                          alignment: Alignment.center,
                                                          padding: EdgeInsets.symmetric(vertical: 10.w),
                                                          child: const Text("确认"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      context.read<SignLoginViewModel>().initialPage = 1;
                                      RouteUtil.push(context, const SignLoginView(), animation: RouteAnimation.popDown);
                                    }
                                  },
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
                                  child: CachedNetworkImage(
                                    imageUrl: context.watch<NavViewModel>().isLogin
                                        ? context.watch<NavViewModel>().userInfoModel?.data?.avatar ??
                                            ApiConfig.baseUrl +
                                                "/images/pet${context.read<StartUpViewModel>().random}.jpg"
                                        : ApiConfig.baseUrl +
                                            "/images/pet${context.read<StartUpViewModel>().random}.jpg",
                                    width: 70.w,
                                    height: 70.w,
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                                        const CupertinoActivityIndicator(),
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
                                                if (context.watch<NavViewModel>().userInfoModel?.data?.sex != "保密")
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
                                                        context.watch<NavViewModel>().userInfoModel?.data?.sex == "男"
                                                            ? const Icon(Icons.male_outlined,
                                                                color: Colors.blue, size: 14)
                                                            : const Icon(Icons.female, color: Colors.red, size: 14),
                                                        Text(
                                                          " ${context.watch<NavViewModel>().userInfoModel?.data?.sex} ",
                                                          style: textStyle.copyWith(
                                                            fontSize: 10.sp,
                                                            color: ThemeUtil.reversePrimaryColor(context),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                if (context.watch<NavViewModel>().userInfoModel?.data?.area != "未设置")
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
                                                  onTap: () => context.read<NavViewModel>().editData(context),
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
                                      onPressed: () => context.read<NavViewModel>().editData(context),
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
                    child: LayoutBuilder(
                      builder: (context, box) {
                        TextSpan textSpan = TextSpan(
                          text: context.watch<NavViewModel>().userInfoModel?.data?.signature ?? "--",
                          style: textStyle,
                        );
                        TextPainter textPainter =
                            TextPainter(text: textSpan, maxLines: 6, textDirection: TextDirection.ltr);
                        textPainter.layout(maxWidth: box.maxWidth);
                        return Stack(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // ImagePicker picker = ImagePicker();
                                // await picker.pickVideo(source: ImageSource.gallery);
                              },
                              child: Text(
                                context.watch<NavViewModel>().userInfoModel?.data?.signature ?? "--",
                                maxLines: !isShowMore ? 6 : null,
                                style: textStyle.copyWith(overflow: TextOverflow.clip),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: !textPainter.didExceedMaxLines
                                  ? const SizedBox()
                                  : GestureDetector(
                                      onTap: () {
                                        isShowMore = !isShowMore;
                                        setState(() {});
                                      },
                                      child:
                                          Text(!isShowMore ? "更多" : "收起", style: const TextStyle(color: Colors.blue)),
                                    ),
                            )
                          ],
                        );
                      },
                    ),
                    // child: Text(
                    //   context.watch<NavViewModel>().userInfoModel?.data?.signature ?? "--",
                    //   maxLines: 6,
                    //   style: textStyle,
                    // ),
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
                        controller: context.watch<MineViewModel>().tC,
                        onTap: (index) {},
                        tabs: const [Text("作品"), Text("收藏")],
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: Divider(height: 0.1)),
                SliverToBoxAdapter(
                  child: ScrollConfiguration(
                    behavior: OverScrollBehavior(),
                    child: Container(
                      color: ThemeUtil.primaryColor(context),
                      height: tabViewHeight *
                          (((context.watch<MineViewModel>().userArticleModel.data?.length ?? 9) / 3).ceil() < 3
                              ? 3
                              : ((context.watch<MineViewModel>().userArticleModel.data?.length ?? 9) / 3).ceil()),
                      // height: tabViewHeight *
                      //     ((context.watch<MineViewModel>().userArticleModel.data?.length ?? 6) / 3).ceil(),
                      child: TabBarView(
                        controller: context.watch<MineViewModel>().tC,
                        children: [
                          WorksTab(
                            userArticleModel: context.watch<MineViewModel>().userArticleModel,
                            isShowRelease: true,
                            isShowUserInfoView: true,
                          ),
                          const Text(" "),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: Container(height: 55.w, color: ThemeUtil.primaryColor(context))),
              ],
            ),
            Positioned(
              top: kToolbarHeight,
              right: 20.w,
              child: GestureDetector(
                onTap: () => context.read<NavViewModel>().scaffoldKey.currentState?.openEndDrawer(),
                child: const Icon(Icons.settings),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
