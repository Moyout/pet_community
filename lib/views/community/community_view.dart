import 'package:flutter/cupertino.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/community/community_viewmodel.dart';
import 'package:pet_community/views/community/detail/community_detail_view.dart';
import 'package:pet_community/views/community/user_info_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_extend/share_extend.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({Key? key}) : super(key: key);

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> with AutomaticKeepAliveClientMixin {
  CommunityViewModel cm = AppUtils.getContext().read<CommunityViewModel>();

  @override
  void initState() {
    cm.initViewModel();
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
                onRefresh: () => cm.onRefresh(false),
                onLoading: () => cm.loadMore(),
                child: context.read<CommunityViewModel>().articleModel.data == null
                    ? Center(
                        child: TextButton(
                          onPressed: () => cm.onRefresh(true),
                          child: const Text("重新加载"),
                        ),
                      )
                    : context.read<CommunityViewModel>().articleModel.data!.articles.isEmpty
                        ? Container(
                            alignment: Alignment.topCenter,
                            child:
                                Image.asset(Assets.backgroundsNoData, width: 250.w, height: 250.w, fit: BoxFit.contain),
                          )
                        : ListView.builder(
                            itemCount: context.read<CommunityViewModel>().articleModel.data?.articles.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  debugPrint(
                                      " .content---------------------->${cm.articleModel.data?.articles[index].content}");
                                  RouteUtil.pushNamed(
                                    context,
                                    CommunityDetailView.routeName,
                                    arguments: {
                                      "title": cm.articleModel.data!.articles[index].title ?? "",
                                      "content": cm.articleModel.data?.articles[index].content,
                                      "articleId": cm.articleModel.data!.articles[index].articleId,
                                      "pictures": cm.articleModel.data!.articles[index].pictures!,
                                      "userId": cm.articleModel.data!.articles[index].userId,
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
                                          key: ValueKey(cm.articleModel.hashCode),
                                          userId: cm.articleModel.data!.articles[index].userId,
                                          publicationTime: cm.articleModel.data!.articles[index].publicationTime,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(vertical: 10.w),
                                        child: Text(
                                          cm.articleModel.data!.articles[index].content ?? "",
                                        ),
                                      ),
                                      Wrap(
                                        spacing: 5.w,
                                        runSpacing: 5.w,
                                        children: [
                                          ...List.generate(cm.articleModel.data!.articles[index].pictures!.length,
                                              (index2) {
                                            int count = cm.articleModel.data!.articles[index].pictures!.length;
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
                                              width: (MediaQuery.of(context).size.width - 60.w + padding) / divideBy,
                                              child: Container(
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.w)),

                                                child: CachedNetworkImage(
                                                  imageUrl: cm.articleModel.data!.articles[index].pictures![index2],
                                                  height: height,
                                                  width: width,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, widget) => CupertinoActivityIndicator(),
                                                ),
                                                // child: Image.network(
                                                //   cm.articleModel.data!.articles[index].pictures![index2],
                                                //   height: height,
                                                //   width: width,
                                                //   fit: BoxFit.cover,
                                                //   loadingBuilder: (context, child, loadingProgress) =>
                                                //       loadingProgress != null
                                                //           ? SizedBox(
                                                //               height: 200.w,
                                                //               child: const Center(child: CupertinoActivityIndicator()),
                                                //             )
                                                //           : child,
                                                // ),
                                              ),
                                            );
                                          })
                                        ],
                                      ),
                                      SizedBox(height: 15.w),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () => shareArticle(index),
                                            child:
                                                const Row(children: [Icon(Icons.share_outlined, size: 18), Text("分享")]),
                                          ),
                                          const Row(children: [Icon(Icons.comment_outlined, size: 18)]),
                                          Row(children: [
                                            const Icon(Icons.favorite_border, size: 18),
                                            Text(cm.articleModel.data!.articles[index].likes.toString())
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

  shareArticle(int index) {
    ShareExtend.share(
        "${cm.articleModel.data?.articles[index].title}\n"
            "${cm.articleModel.data?.articles[index].pictures ?? ""}\n"
            "\t\t\t-------来自《宠物社区》",
        "text");
  }

  @override
  bool get wantKeepAlive => true;
}
