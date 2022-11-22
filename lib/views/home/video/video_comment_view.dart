import 'package:pet_community/util/scroll_util.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/home/video_detail_viewmodel.dart';
import 'package:pet_community/views/home/video/input_comment_widget.dart';

class VideoCommentView extends StatefulWidget {
  const VideoCommentView({Key? key}) : super(key: key);

  @override
  State<VideoCommentView> createState() => _VideoCommentViewState();
}

class _VideoCommentViewState extends State<VideoCommentView> {
  ScrollController sc = ScrollController();
  ScrollUtils scrollUtils = ScrollUtils();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => context.read<VideoDetailViewModel>().closeComment(),
      child: Container(
        alignment: Alignment.bottomCenter,
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width,
        child: Column(
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
            Expanded(
              child: Container(
                color: ThemeUtil.primaryColor(context),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  controller: sc,
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
                        isAlwaysShown: true,
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
}
