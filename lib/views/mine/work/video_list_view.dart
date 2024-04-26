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
  NavViewModel nvm = AppUtils.getContext().read<NavViewModel>();
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
                      if (widget.userId == nvm.userInfoModel?.data?.userId)
                        Positioned(
                          bottom: 5.w,
                          right: 5.w,
                          child: GestureDetector(
                            onTap: () => deleteVideo(index),
                            child: Icon(Icons.delete, color: Colors.redAccent, size: 20.w),
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

  void deleteVideo(int index) async {
    var res = await showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: const Text("是否删除此视频"),
            actions: [
              CupertinoDialogAction(child: const Text("取消"), onPressed: () => Navigator.pop(context)),
              CupertinoDialogAction(
                child: const Text("确定", style: TextStyle(color: Colors.redAccent)),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          );
        });
    if (res ?? false) {
      String? token = SpUtil.getString(PublicKeys.token);

      DeleteVideoModel model = await VideoRequest.deleteVideo(
        videoId: videoList[index].videoId,
        userId: nvm.userInfoModel?.data?.userId,
        token: token,
      );
      if (model.code == 0) {
        if (model.msg != null) ToastUtil.showBottomToast(model.msg!);
        getUserVideo();
      }
    }
  }
}
