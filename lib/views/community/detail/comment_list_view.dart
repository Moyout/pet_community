import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/community/community_detail_viewmodel.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/widget/dialog/cupertino_dialog.dart';

class CommentListView extends StatefulWidget {
  final int articleId;
  final int userId;

  const CommentListView({Key? key, required this.articleId, required this.userId}) : super(key: key);

  @override
  State<CommentListView> createState() => _CommentListViewState();
}

class _CommentListViewState extends State<CommentListView> {
  @override
  void initState() {
    super.initState();
    // context.read<CommunityDetailViewModel>().getComment(widget.articleId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(context.read<CommunityDetailViewModel>().commentModel.data!.articleComments.length, (index) {
          int d = (index % 10) + 1;
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: "",
                        width: 40.w,
                        height: 40.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if ((widget.userId ==
                                        context
                                            .watch<CommunityDetailViewModel>()
                                            .commentModel
                                            .data
                                            ?.articleComments[index]
                                            .userId ||
                                    context
                                            .watch<CommunityDetailViewModel>()
                                            .commentModel
                                            .data
                                            ?.articleComments[index]
                                            .userId ==
                                        context.watch<NavViewModel>().userInfoModel?.data?.userId) &&
                                context
                                        .watch<CommunityDetailViewModel>()
                                        .commentModel
                                        .data
                                        ?.articleComments[index]
                                        .userId !=
                                    null)
                              Container(
                                height: 12.w,
                                width: 20.w,
                                margin: EdgeInsets.only(right: 3.w),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: widget.userId ==
                                          context
                                              .watch<CommunityDetailViewModel>()
                                              .commentModel
                                              .data
                                              ?.articleComments[index]
                                              .userId
                                      ? Colors.red
                                      : Colors.blue,
                                  borderRadius: BorderRadius.circular(3.w),
                                ),
                                child: Text(
                                  widget.userId ==
                                          context
                                              .watch<CommunityDetailViewModel>()
                                              .commentModel
                                              .data
                                              ?.articleComments[index]
                                              .userId
                                      ? "楼主"
                                      : (context
                                                      .watch<CommunityDetailViewModel>()
                                                      .commentModel
                                                      .data
                                                      ?.articleComments[index]
                                                      .userId ==
                                                  context.watch<NavViewModel>().userInfoModel?.data?.userId) &&
                                              context.watch<NavViewModel>().userInfoModel?.data?.userId != null
                                          ? "自己"
                                          : "",
                                  style: TextStyle(fontSize: 8.sp, color: Colors.white),
                                ),
                              ),
                            Container(
                              // width: 150.w,
                              alignment: Alignment.centerLeft,
                              constraints: BoxConstraints(maxWidth: 150.w, minWidth: 0),
                              child: Text(
                                " commentator}",
                                style: TextStyle(fontSize: 12.sp),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${context.read<CommunityDetailViewModel>().commentModel.data!.articleComments[index].commentTime}",
                          style: TextStyle(
                            color: ThemeUtil.reversePrimaryColor(context).withOpacity(0.5),
                            fontSize: 10.sp,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 45.w),
                  padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 5.w),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: ThemeUtil.reversePrimaryColor(context).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4.w)),
                  child: Stack(
                    children: [
                      SelectableText(
                        "${context.read<CommunityDetailViewModel>().commentModel.data!.articleComments[index].commentContent}",
                        style: TextStyle(
                          letterSpacing: 1.0,
                          fontSize: 13.sp,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: (context
                                        .watch<CommunityDetailViewModel>()
                                        .commentModel
                                        .data
                                        ?.articleComments[index]
                                        .userId ==
                                    context.watch<NavViewModel>().userInfoModel?.data?.userId &&
                                context.watch<NavViewModel>().userInfoModel?.data?.userId != null)
                            ? InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (buildContext) {
                                        return CupertinoDialog(
                                          content: "是否删除此评论",
                                          onYes: () async {
                                            Navigator.pop(AppUtils.getContext());
                                            await AppUtils.getContext().read<CommunityDetailViewModel>().deleteComment(
                                                AppUtils.getContext()
                                                    .read<CommunityDetailViewModel>()
                                                    .commentModel
                                                    .data!
                                                    .articleComments[index]
                                                    .commentId);
                                            // if (delete) Navigator.pop(AppUtils.getContext());
                                          },
                                        );
                                      });
                                },
                                child: Text(
                                  "删除",
                                  style: TextStyle(color: Colors.blue, fontSize: 12.sp),
                                ),
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        })
      ],
    );
  }
}
