import 'package:flutter/cupertino.dart';
import 'package:pet_community/models/video/video_model.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/views/home/video/video_detail_view.dart';

class VideoListView extends StatefulWidget {
  final int? userId;
  static const String routeName = "VideoListView";

  const VideoListView({super.key, this.userId});

  @override
  State<VideoListView> createState() => _VideoListViewState();
}

class _VideoListViewState extends State<VideoListView> {
  List<Videos> videoList = [];

  @override
  void initState() {
    super.initState();
    getUserVideo();
  }

  getUserVideo() async {
    var res = await VideoRequest.getUserVideoList(widget.userId);
    videoList = res;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (videoList.isEmpty)
        ? Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Image.asset(Assets.backgroundsNoData, width: 250.w, height: 250.w),
                Text("空空如也"),
              ],
            ),
          )
        : Wrap(
            runSpacing: 1.w,
            spacing: 1.w,
            children: [
              ...List.generate(videoList.length, (index) {
                return Container(
                  color: ThemeUtil.scaffoldColor(context),
                  width: (MediaQuery.of(context).size.width - 3.w) / 3,
                  height: 149.w,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () => openVideoDetail(index),
                          child: Image.network(
                            videoList[index].cover ?? "",
                            errorBuilder: (context, url, error) => const Icon(Icons.error),
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) => loadingProgress != null
                                ? const Center(
                                    child: CupertinoActivityIndicator(),
                                  )
                                : child,
                          ),
                          // child: false
                          //     ? CachedNetworkImage(
                          //         imageUrl: "widget.data![index].pictures![0]",
                          //         progressIndicatorBuilder: (context, url, downloadProgress) =>
                          //             const CupertinoActivityIndicator(),
                          //         errorWidget: (context, url, error) => const Icon(Icons.error),
                          //         fit: BoxFit.cover,
                          //       )
                          //     : Container(
                          //         padding: EdgeInsets.symmetric(horizontal: 5.w),
                          //         alignment: Alignment.center,
                          //         color: ThemeUtil.reversePrimaryColor(context).withOpacity(0.2),
                          //         child: Text(videoList[index].title ?? ""),
                          //       ),
                        ),
                      ),
                      Positioned(
                        bottom: 5.w,
                        left: 5.w,
                        child: Row(
                          children: [
                            Icon(Icons.favorite_border_rounded, color: Colors.white, size: 14.w),
                            Text(
                              "${videoList[index].likes ?? 0}",
                              style: TextStyle(color: Colors.white, fontSize: 12.sp),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          );
  }

  void openVideoDetail(int index) {
    debugPrint("videoList[index].video---------------------->${videoList[index].video}");
    RouteUtil.pushNamed(
      context,
      VideoDetailView.routeName,
      arguments: {
        "videoId": videoList[index].videoId,
        "videoUrl": videoList[index].video,
        "picUrl": videoList[index].cover,
        "content": videoList[index].content,
        "userId": videoList[index].userId,
        "index": index,
      },
    );
  }
}
