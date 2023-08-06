import 'package:flutter/cupertino.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/community/user/user_info_viewmodel.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/views/message/chat/chat_view.dart';
import 'package:pet_community/views/mine/background/set_background_view.dart';
import 'package:pet_community/views/mine/work/works_tab.dart';
import 'package:pet_community/widget/delegate/sliver_header_delegate.dart';

class UserInfoView extends StatefulWidget {
  final int userId;
  final String? avatar;

  const UserInfoView({
    Key? key,
    required this.userId,
    required this.avatar,
  }) : super(key: key);

  @override
  State<UserInfoView> createState() => _UserInfoViewState();
}

class _UserInfoViewState extends State<UserInfoView>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  double tabViewHeight = 150.w;
  bool isShowMore = false;
  EdgeInsetsGeometry horizontalPadding = EdgeInsets.symmetric(horizontal: 16.w);

  TextStyle textStyle = TextStyle(fontSize: 12.sp, color: Colors.grey, overflow: TextOverflow.ellipsis);
  TextStyle textStyle2 = TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis);

  @override
  void initState() {
    context.read<UserInfoViewModel>().initViewModel(widget.userId, this);
    debugPrint("userId--------->${widget.userId}");
    debugPrint(".userId2--------->${context.read<NavViewModel>().userInfoModel?.data?.userId}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    UserInfoViewModel mvModelR = context.read<UserInfoViewModel>();
    UserInfoViewModel mvModelW = context.watch<UserInfoViewModel>();
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
                  minHeight: UserInfoViewModel.defaultHeight,
                  maxHeight: UserInfoViewModel.maxHeight,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          RouteUtil.push(
                              context,
                              SetBackgroundView(
                                isOther: context.read<UserInfoViewModel>().userInfoModel.data?.userId ==
                                        context.read<NavViewModel>().userInfoModel?.data?.userId
                                    ? false
                                    : true,
                                background: context.read<UserInfoViewModel>().userInfoModel.data?.background,
                              ),
                              animation: RouteAnimation.popDown);
                        },
                        child: Transform.scale(
                          scale: 1 + mvModelW.scale,
                          child: context.watch<UserInfoViewModel>().userInfoModel.data?.background != null
                              ? CachedNetworkImage(
                                  imageUrl: context.watch<UserInfoViewModel>().userInfoModel.data!.background!,
                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                      const CupertinoActivityIndicator(),
                                  fit: BoxFit.cover,
                                  height: 400.w,
                                )
                              : Image.asset(
                                  "assets/images/backgrounds/pet_bg.png",
                                  fit: BoxFit.cover,
                                  height: 400.w,
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
                                // if (context.read<NavViewModel>().isLogin) {
                                //   showDialog(
                                //     context: context,
                                //     builder: (c) {
                                //       return GestureDetector(
                                //         onTap: () => Navigator.pop(context),
                                //         child: Scaffold(
                                //           backgroundColor: Colors.transparent,
                                //           body: Container(
                                //             alignment: Alignment.center,
                                //             padding: EdgeInsets.symmetric(horizontal: 50.w),
                                //             child: GestureDetector(
                                //               onTap: () {},
                                //               child: Column(
                                //                 mainAxisAlignment: MainAxisAlignment.center,
                                //                 mainAxisSize: MainAxisSize.min,
                                //                 children: [
                                //                   Image.asset(
                                //                     "assets/images/backgrounds/likes_background.png",
                                //                     fit: BoxFit.cover,
                                //                   ),
                                //                   Container(
                                //                     color: Colors.white,
                                //                     width: double.infinity,
                                //                     alignment: Alignment.center,
                                //                     padding: EdgeInsets.symmetric(horizontal: 10.w),
                                //                     height: 80.w,
                                //                     child: Text(
                                //                       "\"${context.watch<NavViewModel>().userInfoModel?.data?.userName}\"共获得0个赞 ",
                                //                       style: TextStyle(fontSize: 14.sp),
                                //                     ),
                                //                   ),
                                //                   Divider(
                                //                       height: 0.1, thickness: 0.1, color: Colors.grey.withOpacity(0.5)),
                                //                   GestureDetector(
                                //                     onTap: () => Navigator.pop(context),
                                //                     child: Container(
                                //                       color: Colors.white,
                                //                       width: double.infinity,
                                //                       alignment: Alignment.center,
                                //                       padding: EdgeInsets.symmetric(vertical: 10.w),
                                //                       child: const Text("确认"),
                                //                     ),
                                //                   ),
                                //                 ],
                                //               ),
                                //             ),
                                //           ),
                                //         ),
                                //       );
                                //     },
                                //   );
                                // } else {
                                //   context.read<SignLoginViewModel>().initialPage = 1;
                                //   RouteUtil.push(context, const SignLoginView(), animation: RouteAnimation.popDown);
                                // }
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
                        onTap: () => context.read<UserInfoViewModel>().avatarOnTap(context, widget.avatar),
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
                              child: context.watch<UserInfoViewModel>().userInfoModel.data?.avatar != null
                                  ? CachedNetworkImage(
                                      imageUrl: context.watch<UserInfoViewModel>().userInfoModel.data!.avatar!,
                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          const CupertinoActivityIndicator(),
                                      width: 70.w,
                                      height: 70.w,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/images/ic_launcher.png",
                                      width: 70.w,
                                      height: 70.w,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
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
                  child: (UserInfoViewModel.offsetY / UserInfoViewModel.maxHeight) >= 1
                      ? const SizedBox()
                      : Container(
                          padding: horizontalPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        // color: Colors.red,
                                        width: 220.w,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          context.watch<UserInfoViewModel>().userInfoModel.data?.userName ?? "--",
                                          style: textStyle2,
                                        ),
                                      ),
                                    ),
                                    if (widget.userId != context.watch<NavViewModel>().userInfoModel?.data?.userId)
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.deepPurple,
                                          shape: const StadiumBorder(),
                                          primary: ThemeUtil.primaryColor(context),
                                          padding: const EdgeInsets.all(0),
                                        ),
                                        onPressed: () {
                                          RouteUtil.pushReplacement(
                                            context,
                                            ChatView(
                                              userId: widget.userId,
                                              name:
                                                  context.read<UserInfoViewModel>().userInfoModel.data?.userName ?? "",
                                            ),
                                          );
                                        },
                                        child: Text("发信息", style: TextStyle(fontSize: 12.sp)),
                                      )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: ThemeUtil.primaryColor(context),
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (context.watch<UserInfoViewModel>().userInfoModel.data?.sex != "保密")
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
                                              context.watch<UserInfoViewModel>().userInfoModel.data?.sex == "男"
                                                  ? const Icon(Icons.male_outlined, color: Colors.blue, size: 14)
                                                  : const Icon(Icons.female, color: Colors.red, size: 14),
                                              Text(
                                                " ${context.watch<UserInfoViewModel>().userInfoModel.data?.sex} ",
                                                style: textStyle.copyWith(
                                                  fontSize: 10.sp,
                                                  color: ThemeUtil.reversePrimaryColor(context),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      if (context.watch<UserInfoViewModel>().userInfoModel.data?.area != "未设置")
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
                                            context.watch<UserInfoViewModel>().userInfoModel.data?.area ?? "--",
                                            style: textStyle.copyWith(
                                              fontSize: 10.sp,
                                              color: ThemeUtil.reversePrimaryColor(context),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
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
                      text: context.watch<UserInfoViewModel>().userInfoModel.data?.signature ?? "--",
                      style: textStyle,
                    );
                    TextPainter textPainter =
                        TextPainter(text: textSpan, maxLines: 6, textDirection: TextDirection.ltr);
                    textPainter.layout(maxWidth: box.maxWidth);
                    return Stack(
                      children: [
                        Text(
                          context.watch<UserInfoViewModel>().userInfoModel.data?.signature ?? "--",
                          maxLines: !isShowMore ? 6 : null,
                          style: textStyle.copyWith(overflow: TextOverflow.clip),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: !textPainter.didExceedMaxLines
                              ? const SizedBox()
                              : !isShowMore
                                  ? GestureDetector(
                                      onTap: () {
                                        isShowMore = true;
                                        setState(() {});
                                      },
                                      child: const Text("更多", style: TextStyle(color: Colors.blue)),
                                    )
                                  : const SizedBox(),
                        )
                      ],
                    );
                  },
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
                    controller: context.watch<UserInfoViewModel>().tC,
                    onTap: (index) {
                      setState(() {});
                    },
                    tabs: [
                      const Text("作品"),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [Text("收藏"), Icon(Icons.lock, size: 18)],
                      )
                    ],
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
                  height: context.watch<UserInfoViewModel>().tC.index == 1
                      ? tabViewHeight * 2.5
                      : tabViewHeight *
                          (((context.watch<UserInfoViewModel>().userArticleModel.data?.length ?? 9) / 3).ceil() < 3
                              ? 3
                              : ((context.watch<UserInfoViewModel>().userArticleModel.data?.length ?? 9) / 3).ceil()),
                  child: TabBarView(
                    controller: context.watch<UserInfoViewModel>().tC,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      WorksTab(
                        userArticleModel: context.watch<UserInfoViewModel>().userArticleModel,
                        isShowRelease: false,
                        isShowUserInfoView: false,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.w),
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            child: const Icon(Icons.lock, size: 35),
                          ),
                          const Text("收藏内容不可见"),
                          Text(
                            "该用户将收藏列表设为私密",
                            style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
