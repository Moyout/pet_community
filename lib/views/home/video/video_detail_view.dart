import 'package:flutter/cupertino.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/home/video_detail_viewmodel.dart';
import 'package:pet_community/views/community/user/user_info_view.dart';
import 'package:pet_community/views/home/video/video_comment_view.dart';
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
              Text(
                "@${widget.userName}",
                style: TextStyle(color: Colors.white.withOpacity(0.5), letterSpacing: 1.2, fontSize: 16.sp),
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
                      onTap: () {
                        showModalBottomSheet(
                            barrierColor: Colors.transparent,
                            isScrollControlled: true,
                            context: context,
                            builder: (c) {
                              return const VideoCommentView();
                            });
                      },
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
                        ShareExtend.share("${widget.content}\n${widget.videoUrl}\n\t\t\t-------??????????????????", "text");
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
        // AnimatedPositioned(
        //   bottom: context.watch<VideoDetailViewModel>().showComment ? 0 : -MediaQuery.of(context).size.height,
        //   duration: const Duration(milliseconds: 200),
        //   child: const VideoCommentView(),
        // )
      ],
    );
  }

  Widget buildUserInfoWidget() {
    return UserInfoView(userId: widget.userId, avatar: widget.avatar);
  }
}
