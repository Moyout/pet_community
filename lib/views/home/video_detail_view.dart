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
        if (currentPage == 1) pageC.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.ease);
        return currentPage == 0 ? true : false;
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
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
    return GestureDetector(
      onTap: () {},
      child: Stack(
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
                  color: Colors.blueAccent,
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
          Positioned(
            bottom: 0,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => context.read<VideoDetailViewModel>().closeComment(),
              child: AnimatedContainer(
                alignment: Alignment.bottomCenter,
                duration: const Duration(milliseconds: 200),
                height: context.watch<VideoDetailViewModel>().showComment ? MediaQuery.of(context).size.height : 0,
                width: MediaQuery.of(context).size.width,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    // alignment: Alignment.bottomCenter,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(10.w)),
                    ),
                    height: MediaQuery.of(context).size.height / 2,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            // color: ThemeUtil.primaryColor(context),
                            color: Colors.red,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.w),
                            child: Text(
                              "全部回复",
                              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            // color: ThemeUtil.primaryColor(context),
                            color: Colors.blueAccent,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
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
                          ),

                          ///输入bar
                          Container(
                            // color: ThemeUtil.primaryColor(context),
                            color: Colors.green,
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // if (context.watch<VideoDetailViewModel>().isShow)
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(4.w),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                                    margin: EdgeInsets.symmetric(vertical: 5.w),
                                    child: RawScrollbar(
                                      isAlwaysShown: true,
                                      controller: context.watch<VideoDetailViewModel>().sc,
                                      child: TextField(
                                        scrollController: context.watch<VideoDetailViewModel>().sc,
                                        onTap: () {},
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
            ),
          )
          // MediaQuery.of(context).viewInsets.bottom != 0 || !context.watch<VideoDetailViewModel>().isShow
        ],
      ),
    );
  }

  Widget buildUserInfoWidget() {
    return UserInfoView(userId: widget.userId, avatar: widget.avatar);
  }

// void showComment() {
//   showDialog(
//       barrierColor: Colors.transparent,
//       barrierDismissible: false,
//       context: context,
//       builder: (context) {
//         return GestureDetector(
//           onTap: () => RouteUtil.pop(context),
//           child: Scaffold(
//             backgroundColor: Colors.transparent,
//             body: GestureDetector(
//               onTap: () {},
//               child: Column(
//                 children: [
//                   const Spacer(),
//                   context.watch<VideoDetailViewModel>().isShow
//                       ? Container(
//                           color: ThemeUtil.primaryColor(context),
//                           alignment: Alignment.centerLeft,
//                           padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.w),
//                           child: Text(
//                             "全部回复",
//                             style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
//                           ),
//                         )
//                       : const SizedBox(),
//                   context.watch<VideoDetailViewModel>().isShow
//                       ? Container(
//                           color: ThemeUtil.primaryColor(context),
//                           alignment: Alignment.center,
//                           child: Column(
//                             children: [
//                               Icon(
//                                 const IconData(0xe623, fontFamily: "AliIcon"),
//                                 size: 130.w,
//                                 color: Colors.grey.withOpacity(0.5),
//                               ),
//                               Text(
//                                 "暂无评论",
//                                 style: TextStyle(color: ThemeUtil.reversePrimaryColor(context).withOpacity(0.5)),
//                               ),
//                             ],
//                           ),
//                         )
//                       : const SizedBox(),
//
//                   ///输入bar
//                   Container(
//                     color: ThemeUtil.primaryColor(context),
//                     alignment: Alignment.centerLeft,
//                     padding: EdgeInsets.symmetric(horizontal: 10.w),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         // if (context.watch<VideoDetailViewModel>().isShow)
//                         Expanded(
//                           child: Container(
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                               color: Colors.grey.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(4.w),
//                             ),
//                             padding: EdgeInsets.symmetric(horizontal: 10.w),
//                             margin: EdgeInsets.symmetric(vertical: 5.w),
//                             child: RawScrollbar(
//                               isAlwaysShown: true,
//                               controller: context.watch<VideoDetailViewModel>().sc,
//                               child: TextField(
//                                 scrollController: context.watch<VideoDetailViewModel>().sc,
//                                 onTap: () {},
//                                 scrollPadding: EdgeInsets.zero,
//                                 maxLines: 5,
//                                 minLines: 1,
//                                 textAlign: TextAlign.start,
//                                 style: TextStyle(fontSize: 16.sp, letterSpacing: 1),
//                                 decoration: InputDecoration(
//                                   isCollapsed: true,
//                                   contentPadding: EdgeInsets.symmetric(vertical: 6.w),
//                                   border: InputBorder.none,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//
//                         SizedBox(
//                           height: 30.w,
//                           width: 50.w,
//                           child: TextButton(
//                             onPressed: () {
//                               ToastUtil.showBottomToast("该作品评论功能未开启");
//                               debugPrint(".numLines--------->${context.read<VideoDetailViewModel>().numLines}");
//                             },
//                             child: Text("发表", style: TextStyle(color: Colors.white, fontSize: 10.sp)),
//                             style: TextButton.styleFrom(
//                               shape: const StadiumBorder(),
//                               backgroundColor: Colors.deepPurple,
//                               padding: const EdgeInsets.all(0),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       });
// }
}
