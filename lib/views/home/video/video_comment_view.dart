import 'package:pet_community/models/video_comment/video_comment_model.dart';
import 'package:pet_community/util/scroll_util.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/home/video_detail_viewmodel.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/views/community/user_info_bar.dart';
import 'package:pet_community/views/home/video/input_comment_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VideoCommentView extends StatefulWidget {
  final int? videoId;

  const VideoCommentView({Key? key, required this.videoId}) : super(key: key);

  @override
  State<VideoCommentView> createState() => _VideoCommentViewState();
}

class _VideoCommentViewState extends State<VideoCommentView> {
  NavViewModel nvm = AppUtils.getContext().read<NavViewModel>();
  ScrollController sc = ScrollController();
  VideoCommentModel vm = VideoCommentModel(data: Data(videoComments: [], total: 0));
  RefreshController rc = RefreshController();
  int page = 1;

  @override
  void initState() {
    super.initState();
    getVideoComment();
  }

  Future<void> getVideoComment() async {
    var res = await VideoCommentRequest.getComment(videoId: widget.videoId, page: 1);
    if (res.data?.videoComments != null && res.data!.videoComments.isNotEmpty) {
      vm = res;
      page++;
      setState(() {});
    }
  }

  Future<void> loadMoreData() async {
    var res = await VideoCommentRequest.getComment(videoId: widget.videoId, page: page);
    if (res.data?.videoComments != null && res.data!.videoComments.isNotEmpty) {
      for (var element in res.data!.videoComments) {
        vm.data?.videoComments.add(element);
      }
      page++;
      setState(() {});
    } else {
      ToastUtil.showBottomToast("暂无更多");
    }
  }

  onRefresh() {
    getVideoComment().whenComplete(() => rc.refreshCompleted());
  }

  onLoading() {
    loadMoreData().whenComplete(() => rc.loadComplete());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => context.read<VideoDetailViewModel>().closeComment(),
      child: Container(
        alignment: Alignment.bottomCenter,
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width,
        color: ThemeUtil.scaffoldColor(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: ThemeUtil.scaffoldColor(context),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.w),
              child: Text(
                "全部回复",
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: (vm.data?.videoComments.isNotEmpty ?? false)
                  ? buildCommentListView()
                  : Container(
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
            ),

            ///输入bar
            Container(
              color: ThemeUtil.primaryColor(context),
              // color: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                children: [
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
                        // isAlwaysShown: true,
                        controller: context.watch<VideoDetailViewModel>().sc,
                        child: TextField(
                          controller: context.read<VideoDetailViewModel>().textC,
                          readOnly: true,
                          scrollController: context.watch<VideoDetailViewModel>().sc,
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (c) {
                                  return const InputCommentWidget();
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
    );
  }

  Widget buildCommentListView() {
    return SmartRefresher(
      controller: rc,
      onRefresh: () => onRefresh(),
      onLoading: () => onLoading(),
      enablePullUp: true,
      child: ListView.builder(
        controller: sc,
        padding: EdgeInsets.zero,
        itemCount: vm.data?.videoComments.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UserInfoBar(
                      index: index,
                      userId: vm.data?.videoComments[index].userId,
                      publicationTime: vm.data?.videoComments[index].commentTime ?? "",
                    ),
                    if (vm.data?.videoComments[index].userId == nvm.userInfoModel?.data?.userId)
                      Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(4.w),
                        ),
                        child: Text(
                          "作者",
                          style: TextStyle(fontSize: 10.sp, color: ThemeUtil.scaffoldColor(context)),
                        ),
                      ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.w, top: 4.w),
                  width: 0,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: ThemeUtil.primaryColor(context),
                    border: Border(
                      top: BorderSide(color: ThemeUtil.primaryColor(context), width: 8.w),
                      left: BorderSide(color: Colors.transparent, width: 8.w),
                      right: BorderSide(color: Colors.transparent, width: 8.w),
                      bottom: BorderSide(color: Colors.transparent, width: 8.w),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 12.w),
                  padding: EdgeInsets.only(top: 4.w, bottom: 4.w, left: 10.w, right: 10.w),
                  decoration: BoxDecoration(
                    color: ThemeUtil.primaryColor(context),
                    border: Border.all(color: ThemeUtil.primaryColor(context), width: 0),
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                  child: Text(vm.data?.videoComments[index].commentContent ?? ""),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
