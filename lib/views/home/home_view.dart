import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/home/home_viewmodel.dart';
import 'package:pet_community/widget/video/video_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<HomeViewModel>().initViewModel();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // body: Center(
      //   child: vpc.value.isInitialized
      //       ? AspectRatio(
      //           aspectRatio: vpc.value.aspectRatio,
      //           child: VideoPlayer(vpc),
      //         )
      //       : SizedBox(),
      // ),
      appBar: AppBar(title: const Text("首页")),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: ScrollConfiguration(
          behavior: OverScrollBehavior(),
          child: SmartRefresher(
            controller: context.watch<HomeViewModel>().refreshC,
            onRefresh: () => context.read<HomeViewModel>().onRefresh(),
            enablePullUp: context.watch<HomeViewModel>().enablePullUp,
            child: MasonryGridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 5.w,
              mainAxisSpacing: 5.w,
              itemCount: context.watch<HomeViewModel>().videoModel.data?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                int d = (index % 10) + 1;

                return GestureDetector(
                  onTap: () {
                    RouteUtil.push(
                      context,
                      VideoWidget(url: context.read<HomeViewModel>().videoModel.data![index].video!),
                    );
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Theme.of(context).appBarTheme.backgroundColor,
                      borderRadius: BorderRadius.circular(5.w),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl: context.watch<HomeViewModel>().videoModel.data![index].cover!,
                          progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
                            height: index % 2 == 0 ? 150.w : 250.w,
                            child: const CupertinoActivityIndicator(),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.w),
                                child: Text(
                                  context.watch<HomeViewModel>().videoModel.data?[index].title ?? "",
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              ),
                              Row(
                                children: [
                                  ClipOval(
                                    child: CachedNetworkImage(
                                      width: 25.w,
                                      height: 25.w,
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          const CupertinoActivityIndicator(),
                                      imageUrl: context.watch<HomeViewModel>().videoModel.data?[index].avatar ??
                                          ApiConfig.baseUrl + "/images/avatar/avatar$d.png",
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                                      child: Text(
                                        context.watch<HomeViewModel>().videoModel.data?[index].userName ?? "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: ThemeUtil.reversePrimaryColor(context).withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.w),
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
