import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/community/community_viewmodel.dart';
import 'package:pet_community/views/community/detail/community_detail_view.dart';
import 'package:pet_community/widget/common/unripple.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({Key? key}) : super(key: key);

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
  @override
  void initState() {
    context.read<CommunityViewModel>().initViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeUtil.brightness(context) == Brightness.light ? Colors.grey.withOpacity(0.1) : null,
      appBar: AppBar(title: const Text("发现")),
      body: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: Column(
          children: [
            Expanded(
              child: SmartRefresher(
                enablePullUp: context.watch<CommunityViewModel>().enablePullUp,
                controller: context.watch<CommunityViewModel>().refreshC,
                onRefresh: () => context.read<CommunityViewModel>().onRefresh(),
                onLoading: () => context.read<CommunityViewModel>().loadMore(),
                child: context.watch<CommunityViewModel>().articleModel.data == null
                    ? const SizedBox()
                    : ListView.builder(
                        itemCount: context.watch<CommunityViewModel>().articleModel.data?.length,
                        itemBuilder: (BuildContext context, int index) {
                          int d = (index % 10) + 1;
                          return GestureDetector(
                            onTap: () {
                              RouteUtil.pushByCupertino(
                                context,
                                CommunityDetailView(
                                  title: context.read<CommunityViewModel>().articleModel.data![index].title ?? "",
                                  content: context.read<CommunityViewModel>().articleModel.data![index].content ?? "",
                                  avatar: context.read<CommunityViewModel>().articleModel.data?[index].avatar ??
                                      ApiConfig.baseUrl + "/images/avatar/avatar$d.png",
                                  articleId: context.read<CommunityViewModel>().articleModel.data![index].articleId!,
                                  pictures: context.read<CommunityViewModel>().articleModel.data![index].pictures!,
                                  userId: context.read<CommunityViewModel>().articleModel.data![index].userId!,
                                  isShowUserInfoView: true,
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).appBarTheme.backgroundColor,
                                borderRadius: BorderRadius.circular(6.w),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
                              margin: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 50.w,
                                    child: Row(
                                      children: [
                                        ClipOval(
                                          child: CachedNetworkImage(
                                            width: 45.w,
                                            height: 45.w,
                                            fit: BoxFit.cover,
                                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                const CupertinoActivityIndicator(),
                                            imageUrl:
                                                context.watch<CommunityViewModel>().articleModel.data?[index].avatar ??
                                                    ApiConfig.baseUrl + "/images/avatar/avatar$d.png",
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 250.w,
                                              child: Text(
                                                context.watch<CommunityViewModel>().articleModel.data![index].author!,
                                                style: TextStyle(fontSize: 15.sp),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                            Text(
                                              context
                                                  .watch<CommunityViewModel>()
                                                  .articleModel
                                                  .data![index]
                                                  .publicationTime!,
                                              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10.w),
                                    child: Text(
                                        context.watch<CommunityViewModel>().articleModel.data![index].content ?? ""),
                                  ),
                                  Wrap(
                                    spacing: 5.w,
                                    runSpacing: 5.w,
                                    children: [
                                      ...List.generate(
                                          context
                                              .watch<CommunityViewModel>()
                                              .articleModel
                                              .data![index]
                                              .pictures!
                                              .length, (index2) {
                                        int count = context
                                            .watch<CommunityViewModel>()
                                            .articleModel
                                            .data![index]
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
                                                  .data![index]
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
                                            .data![index]
                                            .likes!
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
            Container(color: Colors.transparent, height: 50.w)
          ],
        ),
      ),
    );
  }
}
