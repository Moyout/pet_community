import 'package:flutter/cupertino.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/community/community_viewmodel.dart';
import 'package:pet_community/views/community/detail/community_detail_view.dart';
import 'package:pet_community/views/community/user_info_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({Key? key}) : super(key: key);

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context.read<CommunityViewModel>().initViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: ThemeUtil.brightness(context) == Brightness.light ? Colors.grey.withOpacity(0.1) : null,
      appBar: AppBar(title: Text("发现", style: TextStyle(fontSize: 15.sp))),
      body: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: Column(
          children: [
            Expanded(
              child: SmartRefresher(
                enablePullUp: context.watch<CommunityViewModel>().enablePullUp,
                controller: context.watch<CommunityViewModel>().refreshC,
                onRefresh: () => context.read<CommunityViewModel>().onRefresh(false),
                onLoading: () => context.read<CommunityViewModel>().loadMore(),
                child: context.watch<CommunityViewModel>().articleModel.data == null
                    ? Center(
                        child: TextButton(
                          onPressed: () => context.read<CommunityViewModel>().onRefresh(true),
                          child: const Text("重新加载"),
                        ),
                      )
                    : ListView.builder(
                        itemCount: context.watch<CommunityViewModel>().articleModel.data?.articles.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              debugPrint(
                                  " .content---------------------->${context.read<CommunityViewModel>().articleModel.data?.articles[index].content}");
                              RouteUtil.pushNamed(
                                context,
                                CommunityDetailView.routeName,
                                arguments: {
                                  "title":
                                      context.read<CommunityViewModel>().articleModel.data!.articles[index].title ?? "",
                                  "content":
                                      context.read<CommunityViewModel>().articleModel.data?.articles[index].content,
                                  "articleId":
                                      context.read<CommunityViewModel>().articleModel.data!.articles[index].articleId,
                                  "pictures":
                                      context.read<CommunityViewModel>().articleModel.data!.articles[index].pictures!,
                                  "userId":
                                      context.read<CommunityViewModel>().articleModel.data!.articles[index].userId,
                                  "isShowUserInfoView": true,
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).appBarTheme.backgroundColor,
                                borderRadius: BorderRadius.circular(6.w),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 15.w),
                              margin: EdgeInsets.symmetric(vertical: 10.w, horizontal: 5.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 50.w,
                                    child: UserInfoBar(
                                      index: index,
                                      userId:
                                          context.read<CommunityViewModel>().articleModel.data!.articles[index].userId,
                                      publicationTime: context
                                          .read<CommunityViewModel>()
                                          .articleModel
                                          .data!
                                          .articles[index]
                                          .publicationTime,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10.w),
                                    child: Text(
                                      context.watch<CommunityViewModel>().articleModel.data!.articles[index].content ??
                                          "",
                                    ),
                                  ),
                                  Wrap(
                                    spacing: 5.w,
                                    runSpacing: 5.w,
                                    children: [
                                      ...List.generate(
                                          context
                                              .watch<CommunityViewModel>()
                                              .articleModel
                                              .data!
                                              .articles[index]
                                              .pictures!
                                              .length, (index2) {
                                        int count = context
                                            .watch<CommunityViewModel>()
                                            .articleModel
                                            .data!
                                            .articles[index]
                                            .pictures!
                                            .length;
                                        int divideBy = 1;
                                        count >= 3 ? divideBy = 3 : divideBy = count;
                                        double? width, height, padding;
                                        count == 4 ? padding = 10.w : padding = 0;
                                        count <= 2
                                            ? width = 180.w
                                            : width = (MediaQuery.of(context).size.width - 50.w) / divideBy;
                                        count >= 3 ? height = 110.w : height = 180.w;
                                        return Container(
                                          alignment: Alignment.centerLeft,
                                          width: (MediaQuery.of(context).size.width - 50.w + padding) / divideBy,
                                          child: Container(
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.w)),
                                            child: CachedNetworkImage(
                                              imageUrl: context
                                                  .watch<CommunityViewModel>()
                                                  .articleModel
                                                  .data!
                                                  .articles[index]
                                                  .pictures![index2],
                                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                  const CupertinoActivityIndicator(),
                                              height: height,
                                              width: width,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      })
                                    ],
                                  ),
                                  SizedBox(height: 15.w),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: const [Icon(Icons.share_outlined, size: 18), Text("分享")]),
                                      Row(children: const [Icon(Icons.comment_outlined, size: 18), Text("0")]),
                                      Row(children: [
                                        const Icon(Icons.favorite_border, size: 18),
                                        Text(context
                                            .watch<CommunityViewModel>()
                                            .articleModel
                                            .data!
                                            .articles[index]
                                            .likes
                                            .toString())
                                      ]),
                                    ],
                                  ),
                                  SizedBox(height: 2.w),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
            // Container(color: Colors.transparent, height: 50.w)
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
