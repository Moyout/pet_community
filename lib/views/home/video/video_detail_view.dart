import 'package:flutter/cupertino.dart';
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
  PageController pageC2 = PageController(initialPage: 1);

  @override
  void initState() {
    super.initState();
    context.read<VideoDetailViewModel>().initViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (context.read<VideoDetailViewModel>().showComment) {
          context.read<VideoDetailViewModel>().closeComment();
          return false;
        }
        if (currentPage == 1) {
          pageC.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.ease);
          return false;
        }
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: ScrollConfiguration(
          behavior: OverScrollBehavior(),
          child: PageView(
            physics: context.watch<VideoDetailViewModel>().showComment ? const NeverScrollableScrollPhysics() : null,
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
    return Stack(
      alignment: Alignment.center,
      children: [
        VideoWidget(videoUrl: widget.videoUrl, picUrl: widget.picUrl, index: widget.index),
        Positioned(
          left: 10.w,
          right: 10.w,
          bottom: 30.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // color: Colors.blueAccent,
                child: Text(
                  "@${widget.userName}",
                  style: TextStyle(color: Colors.white.withOpacity(0.5), letterSpacing: 1.2, fontSize: 16.sp),
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
        Positioned(
          right: 5.w,
          top: 0,
          bottom: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
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
                      onTap: () => context.read<VideoDetailViewModel>().openComment(),
                      child: Container(
                        margin: EdgeInsets.only(top: 20.w),
                        child: Icon(
                          const IconData(0xe7d9, fontFamily: "AliIcon"),
                          color: Colors.white,
                          size: 35.w,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        ShareExtend.share("${widget.content}\n${widget.videoUrl}\n\t\t\t-------《宠物社区》", "text");
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 20.w),
                        child: Icon(
                          const IconData(0xe60f, fontFamily: "AliIcon"),
                          color: Colors.white,
                          size: 35.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        AnimatedPositioned(
          bottom: context.watch<VideoDetailViewModel>().showComment ? 0 : -MediaQuery.of(context).size.height,
          duration: const Duration(milliseconds: 200),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => context.read<VideoDetailViewModel>().closeComment(),
            child: Container(
              alignment: Alignment.bottomCenter,
              // height: context.watch<VideoDetailViewModel>().showComment ? MediaQuery.of(context).size.height : 0,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  // alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: ThemeUtil.primaryColor(context),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10.w)),
                  ),
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: ThemeUtil.primaryColor(context),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.w),
                        child: Text(
                          "全部回复",
                          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        color: ThemeUtil.primaryColor(context),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              const IconData(0xe623, fontFamily: "AliIcon"),
                              size: 120.w,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            Text(
                              "暂无评论",
                              style: TextStyle(color: ThemeUtil.reversePrimaryColor(context).withOpacity(0.5)),
                            ),
                          ],
                        ),
                      ),

                      ///输入bar
                      Container(
                        color: ThemeUtil.primaryColor(context),
                        // color: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          children: [
                            // if (context.watch<VideoDetailViewModel>().isShow)
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(4.w),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                margin: EdgeInsets.symmetric(vertical: 5.w),
                                child: RawScrollbar(
                                  isAlwaysShown: true,
                                  controller: context.watch<VideoDetailViewModel>().sc,
                                  child: TextField(
                                    controller: context.read<VideoDetailViewModel>().textC,
                                    readOnly: true,
                                    scrollController: context.watch<VideoDetailViewModel>().sc,
                                    onTap: () {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (c) {
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.withOpacity(0.2),
                                                    borderRadius: BorderRadius.circular(4.w),
                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                                  margin: EdgeInsets.symmetric(vertical: 5.w),
                                                  child: RawScrollbar(
                                                    isAlwaysShown: true,
                                                    controller: context.watch<VideoDetailViewModel>().sc,
                                                    child: TextField(
                                                      focusNode: context.watch<VideoDetailViewModel>().focusNode,
                                                      controller: context.read<VideoDetailViewModel>().textC,
                                                      scrollPadding: EdgeInsets.zero,
                                                      maxLines: 5,
                                                      minLines: 1,
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(fontSize: 16.sp, letterSpacing: 1),
                                                      decoration: InputDecoration(
                                                        isCollapsed: true,
                                                        contentPadding: EdgeInsets.symmetric(vertical: 6.w),
                                                        border: InputBorder.none,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(height: MediaQuery.of(context).viewInsets.bottom)
                                              ],
                                            );
                                          });
                                    },
                                    scrollPadding: EdgeInsets.zero,
                                    maxLines: 5,
                                    minLines: 1,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 16.sp, letterSpacing: 1),
                                    decoration: InputDecoration(
                                      isCollapsed: true,
                                      contentPadding: EdgeInsets.symmetric(vertical: 6.w),
                                      border: InputBorder.none,
                                    ),
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
            ),
          ),
        )
      ],
    );
  }

  Widget buildUserInfoWidget() {
    return UserInfoView(userId: widget.userId, avatar: widget.avatar);
  }
}
