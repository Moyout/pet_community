import 'package:flutter/cupertino.dart';
import 'package:pet_community/util/toast_util.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/home/video_detail_viewmodel.dart';
import 'package:pet_community/views/community/user/user_info_view.dart';
import 'package:pet_community/widget/video/video_widget.dart';
import 'package:share_extend/share_extend.dart';

class VideoDetailView extends StatefulWidget {
  final String? userName;
  final String? content;
  final String avatar;
  final String videoUrl;
  final String picUrl;
  final int userId;
  final int index;

  const VideoDetailView({
    Key? key,
    required this.videoUrl,
    required this.picUrl,
    required this.index,
    required this.userName,
    this.content,
    required this.avatar,
    required this.userId,
  }) : super(key: key);

  @override
  State<VideoDetailView> createState() => _VideoDetailViewState();
}

class _VideoDetailViewState extends State<VideoDetailView> {
  PageController pageC = PageController(initialPage: 0);
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    context.read<VideoDetailViewModel>().initViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentPage == 1) pageC.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.ease);
        return currentPage == 0 ? true : false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: ScrollConfiguration(
          behavior: OverScrollBehavior(),
          child: PageView(
            onPageChanged: (int index) {
              currentPage = index;
            },
            controller: pageC,
            children: [
              buildVideoWidget(),
              buildUserInfoWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildVideoWidget() {
    return Column(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              VideoWidget(
                videoUrl: widget.videoUrl,
                picUrl: widget.picUrl,
                index: widget.index,
              ),
              MediaQuery.of(context).viewInsets.bottom != 0 || !context.watch<VideoDetailViewModel>().isShow
                  ? const SizedBox()
                  : Positioned(
                      left: 10.w,
                      right: 10.w,
                      bottom: 50.w,
                      child: IgnorePointer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "@${widget.userName}",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                letterSpacing: 1.2,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(height: 10.w),
                            Text(
                              "${widget.content}\n",
                              style: TextStyle(color: Colors.white, fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
              if (MediaQuery.of(context).viewInsets.bottom == 0 && context.watch<VideoDetailViewModel>().isShow)
                Positioned(
                  right: 5.w,
                  top: 0,
                  bottom: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(flex: 4, child: SizedBox()),
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                pageC.animateToPage(1, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                              },
                              child: Center(
                                child: Hero(
                                  tag: widget.index,
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      width: 50.w,
                                      height: 50.w,
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          const CupertinoActivityIndicator(),
                                      imageUrl: widget.avatar,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(height: 20.w),
                            GestureDetector(
                              onTap: () => showComment(),
                              child: Container(
                                margin: EdgeInsets.only(top: 20.w),
                                child: Icon(const IconData(0xe7d9, fontFamily: "AliIcon"),
                                    color: Colors.white, size: 35.w),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                ShareExtend.share("${widget.content}\n${widget.videoUrl}\n\t\t\t-------《宠物社区》", "text");
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 20.w),
                                child: Icon(const IconData(0xe60f, fontFamily: "AliIcon"),
                                    color: Colors.white, size: 35.w),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              // MediaQuery.of(context).viewInsets.bottom != 0 || !context.watch<VideoDetailViewModel>().isShow
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => context.read<VideoDetailViewModel>().setHideOrShow(),
                child: Icon(
                  context.watch<VideoDetailViewModel>().isShow ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildUserInfoWidget() {
    return UserInfoView(userId: widget.userId, avatar: widget.avatar);
  }

  void showComment() {
    showDialog(
        barrierColor: Colors.transparent,
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return GestureDetector(
            onTap: () => RouteUtil.pop(context),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    const Spacer(),
                    context.watch<VideoDetailViewModel>().isShow
                        ? Container(
                            color: ThemeUtil.primaryColor(context),
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.w),
                            child: Text(
                              "全部回复",
                              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                            ),
                          )
                        : const SizedBox(),
                    context.watch<VideoDetailViewModel>().isShow
                        ? Container(
                            color: ThemeUtil.primaryColor(context),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Icon(
                                  const IconData(0xe623, fontFamily: "AliIcon"),
                                  size: 130.w,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                Text(
                                  "暂无评论",
                                  style: TextStyle(color: ThemeUtil.reversePrimaryColor(context).withOpacity(0.5)),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),

                    ///输入bar
                    Container(
                      color: ThemeUtil.primaryColor(context),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => context.read<VideoDetailViewModel>().setHideOrShow(),
                            child: Icon(
                              context.watch<VideoDetailViewModel>().isShow
                                  ? Icons.arrow_drop_down
                                  : Icons.arrow_drop_up,
                              color: Colors.grey,
                            ),
                          ),
                          // if (context.watch<VideoDetailViewModel>().isShow)
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(vertical: 5.w),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8.w),
                              ),
                              child: TextField(
                                onTap: () {},
                                controller: context.watch<VideoDetailViewModel>().textC,
                                maxLines: context.watch<VideoDetailViewModel>().numLines < 4 ? null : 4,
                                // maxLines: 4,
                                onChanged: (v) => context.read<VideoDetailViewModel>().getTextLines(),
                                textAlign: TextAlign.start,
                                style: const TextStyle(letterSpacing: 1.2),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.fromLTRB(10.w, 10.w, 10.w, 10.w),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.w,
                            width: 50.w,
                            child: TextButton(
                              onPressed: () {
                                ToastUtil.showBottomToast("该作品评论功能未开启");
                                debugPrint(".numLines--------->${context.read<VideoDetailViewModel>().numLines}");
                              },
                              child: Text("发表", style: TextStyle(color: Colors.white, fontSize: 10.sp)),
                              style: TextButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor: Colors.deepPurple,
                                padding: const EdgeInsets.all(0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
