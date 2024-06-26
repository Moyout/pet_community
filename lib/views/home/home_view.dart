import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/home/home_viewmodel.dart';
import 'package:pet_community/views/home/video/video_detail_view.dart';
import 'package:pet_community/widget/video/avatar_username_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AutomaticKeepAliveClientMixin {
  HomeViewModel hvm = AppUtils.getContext().read<HomeViewModel>();

  @override
  void initState() {
    super.initState();
    hvm.initViewModel();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: Text("首页", style: TextStyle(fontSize: 15.sp))),
      body: Container(
        // padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: ScrollConfiguration(
          behavior: OverScrollBehavior(),
          child: SmartRefresher(
            controller: context.watch<HomeViewModel>().refreshC,
            onRefresh: () => hvm.onRefresh(false),
            onLoading: () => hvm.loadMore(),
            enablePullUp: context.watch<HomeViewModel>().enablePullUp,
            child: context.watch<HomeViewModel>().videoModel.data == null
                ? Center(
                    child: TextButton(
                      onPressed: () => hvm.onRefresh(true),
                      child: const Text("重新加载"),
                    ),
                  )
                : context.watch<HomeViewModel>().videoModel.data!.videos.isEmpty
                    ? Container(
                        alignment: Alignment.topCenter,
                        child: Image.asset(Assets.backgroundsNoData, width: 250.w, height: 250.w, fit: BoxFit.contain),
                      )
                    : MasonryGridView.builder(
                        itemCount: context.watch<HomeViewModel>().videoModel.data?.videos.length ?? 0,
                        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        itemBuilder: (context2, index) {
                          return GestureDetector(
                            onTap: () {
                              RouteUtil.pushNamed(
                                context,
                                VideoDetailView.routeName,
                                arguments: {
                                  "videoId": hvm.videoModel.data?.videos[index].videoId,
                                  "videoUrl": hvm.videoModel.data!.videos[index].video!,
                                  "picUrl": hvm.videoModel.data!.videos[index].cover!,
                                  "content": hvm.videoModel.data?.videos[index].content,
                                  "userId": hvm.videoModel.data!.videos[index].userId,
                                  "index": index,
                                },
                              );
                            },
                            child: Container(
                              // margin: EdgeInsets.only(right: 2.w, left: 2.w),
                              margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.w),
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: ThemeUtil.brightness(context) == Brightness.light
                                    ? Colors.white
                                    : Theme.of(context).appBarTheme.backgroundColor,
                                borderRadius: BorderRadius.circular(5.w),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (context.watch<HomeViewModel>().videoModel.data != null)
                                    Hero(
                                      tag: "cover$index",
                                      child: CachedNetworkImage(
                                        imageUrl: hvm.videoModel.data!.videos[index].cover!,
                                        placeholder: (c, w) => SizedBox(
                                          height: index % 2 == 0 ? 150.w : 250.w,
                                          child: const Center(child: CupertinoActivityIndicator()),
                                        ),
                                      ),
                                      // child: Image.network(
                                      //   context.watch<HomeViewModel>().videoModel.data!.videos[index].cover ?? "",
                                      //   loadingBuilder: (context, child, loadingProgress) {
                                      //     if (loadingProgress != null) {
                                      //       return SizedBox(
                                      //         height: index % 2 == 0 ? 150.w : 250.w,
                                      //         child: const Center(child: CupertinoActivityIndicator()),
                                      //       );
                                      //     }
                                      //     return child;
                                      //   },
                                      // ),
                                    ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (context.watch<HomeViewModel>().videoModel.data?.videos[index].title != null)
                                          SizedBox(height: 5.w),
                                        if (context.watch<HomeViewModel>().videoModel.data?.videos[index].title != null)
                                          Text(
                                            context.watch<HomeViewModel>().videoModel.data?.videos[index].title ?? "",
                                            textAlign: TextAlign.start,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 12.sp),
                                          ),
                                        Container(
                                          padding: EdgeInsets.symmetric(vertical: 5.w),
                                          child: UserAvatarName(
                                            key: ValueKey(hvm.videoModel.hashCode),
                                            index: index,
                                            userId:
                                                context.watch<HomeViewModel>().videoModel.data!.videos[index].userId,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
