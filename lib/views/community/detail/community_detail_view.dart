import 'package:flutter/cupertino.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/community/community_detail_viewmodel.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/views/community/detail/comment_list_view.dart';
import 'package:pet_community/views/community/user/user_info_view.dart';
import 'package:pet_community/widget/dialog/cupertino_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommunityDetailView extends StatefulWidget {
  final int articleId;
  final int userId;
  final String title;
  final String content;
  final String avatar;
  final List<String> pictures;
  final bool isShowUserInfoView;

  const CommunityDetailView({
    Key? key,
    required this.title,
    required this.content,
    required this.articleId,
    required this.avatar,
    required this.pictures,
    required this.userId,
    required this.isShowUserInfoView,
  }) : super(key: key);

  @override
  State<CommunityDetailView> createState() => _CommunityDetailViewState();
}

class _CommunityDetailViewState extends State<CommunityDetailView> {
  double textFiledHeight = 50.w;
  PageController pageC = PageController();

  @override
  void initState() {
    super.initState();
    context.read<CommunityDetailViewModel>().getComment(widget.articleId);
    context.read<CommunityDetailViewModel>().textC.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: PageView(
          controller: pageC,
          physics: widget.userId != context.read<NavViewModel>().userInfoModel?.data?.userId
              ? widget.isShowUserInfoView
                  ? null
                  : const NeverScrollableScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          children: [
            Column(
              children: [
                AppBar(
                  leading: GestureDetector(
                    onTap: () => RouteUtil.pop(context),
                    child: Icon(Icons.arrow_back_ios, color: ThemeUtil.reversePrimaryColor(context)),
                  ),
                  title: Text(widget.title),
                  actions: [
                    if (widget.isShowUserInfoView)
                      widget.userId != context.read<NavViewModel>().userInfoModel?.data?.userId
                          ? Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 8.w),
                              child: GestureDetector(
                                onTap: () {
                                  pageC.animateToPage(1,
                                      duration: const Duration(milliseconds: 500), curve: Curves.ease);
                                },
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: widget.avatar,
                                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                                        const CupertinoActivityIndicator(),
                                    width: 40.w,
                                    height: 40.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: 80.w,
                                      // padding: EdgeInsets.symmetric(vertical: 10.w),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(10.w)),
                                      ),
                                      child: Column(
                                        children: ["删除", "取消"].map((e) {
                                          return Expanded(
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: TextButton(
                                                child: Text(
                                                  e.toString(),
                                                  style: TextStyle(color: e == "删除" ? Colors.red : Colors.grey),
                                                ),
                                                style: TextButton.styleFrom(
                                                  primary: Colors.black,
                                                  backgroundColor: Colors.white,
                                                ),
                                                onPressed: e == "取消"
                                                    ? () => Navigator.pop(context)
                                                    : () {
                                                        if (e == "删除") {
                                                          Navigator.pop(context);
                                                          showDialog(
                                                              context: context,
                                                              builder: (BuildContext showDialogContext) {
                                                                return CupertinoDialog(
                                                                  content: "确认删除此图文",
                                                                  onYes: () async {
                                                                    Navigator.pop(AppUtils.getContext());
                                                                    bool delete = await AppUtils.getContext()
                                                                        .read<CommunityDetailViewModel>()
                                                                        .deleteArticle(context, widget.articleId);
                                                                    if (delete) Navigator.pop(AppUtils.getContext());
                                                                  },
                                                                );
                                                              }).then((value) {
                                                            debugPrint("value--------->$value");
                                                          });
                                                        }
                                                      },
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 8.w),
                                child: Icon(
                                  Icons.more_vert_rounded,
                                  color: ThemeUtil.reversePrimaryColor(context),
                                ),
                              ),
                            ),
                  ],
                ),
                Expanded(
                  child: SmartRefresher(
                    enablePullUp: context.watch<CommunityDetailViewModel>().enablePullUp,
                    controller: context.watch<CommunityDetailViewModel>().refreshC,
                    onRefresh: () => context.read<CommunityDetailViewModel>().onRefresh(widget.articleId),
                    onLoading: () => context.read<CommunityDetailViewModel>().loadMore(widget.articleId),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                            child: SelectableText(
                              widget.content,
                              style: const TextStyle(letterSpacing: 1.2),
                            ),
                          ),
                          ...List.generate(widget.pictures.length, (index) {
                            return GestureDetector(
                              onTap: () => context.read<CommunityDetailViewModel>().pushShowPicture(
                                    context,
                                    widget.pictures,
                                    index,
                                  ),
                              child: CachedNetworkImage(
                                imageUrl: widget.pictures[index],
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                    const CupertinoActivityIndicator(),
                                fit: BoxFit.fitWidth,
                              ),
                            );
                          }),
                          Padding(padding: EdgeInsets.symmetric(vertical: 5.w)),
                          DefaultTextStyle(
                            style: TextStyle(fontSize: 10.sp, color: ThemeUtil.reversePrimaryColor(context)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    children: const [
                                      Icon(IconData(0xe607, fontFamily: "AliIcon"), color: Colors.green, size: 30),
                                      Text("分享"),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    children: const [
                                      Icon(IconData(0xe66a, fontFamily: "AliIcon"), color: Colors.blue, size: 30),
                                      Text("分享"),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    children: const [
                                      Icon(IconData(0xe651, fontFamily: "AliIcon"), color: Colors.grey, size: 30),
                                      Text("赞"),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    children: const [
                                      Icon(IconData(0xe629, fontFamily: "AliIcon"), color: Colors.grey, size: 28),
                                      Text("踩"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(color: Colors.grey.withOpacity(0.2), thickness: 8.w),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.w),
                            child: Text(
                              "全部回复",
                              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                            ),
                          ),

                          ///暂无评论widget
                          if (context.watch<CommunityDetailViewModel>().commentModel.data != null)
                            if (context.watch<CommunityDetailViewModel>().commentModel.data!.isEmpty)
                              Column(
                                children: [
                                  Icon(
                                    const IconData(0xe623, fontFamily: "AliIcon"),
                                    size: 130.w,
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                  Text(
                                    "暂无评论",
                                    style: TextStyle(color: ThemeUtil.reversePrimaryColor(context).withOpacity(0.5)),
                                  )
                                ],
                              ),
                          if (context.watch<CommunityDetailViewModel>().commentModel.data != null)
                            if (context.watch<CommunityDetailViewModel>().commentModel.data!.isNotEmpty)
                              CommentListView(articleId: widget.articleId, userId: widget.userId),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(color: Colors.grey.withOpacity(0.2), thickness: 1.w, height: 0),
                Container(
                  height: textFiledHeight,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(vertical: 5.w),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8.w),
                          ),
                          child: TextField(
                            controller: context.watch<CommunityDetailViewModel>().textC,
                            expands: true,
                            maxLines: null,
                            style: const TextStyle(letterSpacing: 1.2),
                            onChanged: (v) {
                              context.read<CommunityDetailViewModel>().textC.text.length > 18
                                  ? textFiledHeight = 100.w
                                  : textFiledHeight = 50.w;
                              setState(() {});
                            },
                            textAlign: TextAlign.start,
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
                          onPressed: () =>
                              context.read<CommunityDetailViewModel>().releaseComment(context, widget.articleId),
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
            UserInfoView(
              userId: widget.userId,
              avatar: widget.avatar,
            ),
          ],
        ),
      ),
    );
  }
}
