import 'package:flutter/cupertino.dart';
import 'package:pet_community/models/user/user_info_model.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/community/community_detail_viewmodel.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/widget/dialog/cupertino_dialog.dart';

class CommentItem extends StatefulWidget {
  final int userId;
  final int index;
  final int commentatorId;

  const CommentItem({Key? key, required this.userId, required this.index, required this.commentatorId})
      : super(key: key);

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  UserInfoModel? userInfoModel;

  @override
  void initState() {
    super.initState();
    // context.read<CommunityDetailViewModel>().getComment(widget.articleId);
    getUserAvatar();
  }

  void getUserAvatar() async {
    userInfoModel = await UserInfoRequest.getOtherUserInfo(widget.commentatorId, false);
    debugPrint("userInfoModel--------->${userInfoModel}");
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: userInfoModel?.data?.avatar != null
                    ? CachedNetworkImage(
                        width: 40.w,
                        height: 40.w,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            const CupertinoActivityIndicator(),
                        imageUrl: userInfoModel!.data!.avatar!,
                      )
                    : Image.asset(
                        "assets/images/ic_launcher.png",
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
                                      ?.articleComments[widget.index]
                                      .userId ||
                              context
                                      .watch<CommunityDetailViewModel>()
                                      .commentModel
                                      .data
                                      ?.articleComments[widget.index]
                                      .userId ==
                                  context.watch<NavViewModel>().userInfoModel?.data?.userId) &&
                          context
                                  .watch<CommunityDetailViewModel>()
                                  .commentModel
                                  .data
                                  ?.articleComments[widget.index]
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
                                        ?.articleComments[widget.index]
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
                                        ?.articleComments[widget.index]
                                        .userId
                                ? "楼主"
                                : (context
                                                .watch<CommunityDetailViewModel>()
                                                .commentModel
                                                .data
                                                ?.articleComments[widget.index]
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
                          "${userInfoModel?.data?.userName}",
                          style: TextStyle(fontSize: 12.sp),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${context.read<CommunityDetailViewModel>().commentModel.data!.articleComments[widget.index].commentTime}",
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
                  "${context.read<CommunityDetailViewModel>().commentModel.data!.articleComments[widget.index].commentContent}",
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
                                  ?.articleComments[widget.index]
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
                                              .articleComments[widget.index]
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
  }
}
