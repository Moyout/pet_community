import 'package:flutter/cupertino.dart';
import 'package:flutter/physics.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshWidget extends StatelessWidget {
  final Widget child;
  const RefreshWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerBuilder: () => CustomHeader(
        builder: (BuildContext context, RefreshStatus? mode) {
          Widget body;
          if (mode == RefreshStatus.idle) {
            body = Row(
              mainAxisSize: MainAxisSize.min,
              children: const [Icon(Icons.arrow_downward_outlined), Text("下拉刷新")],
            );
          } else if (mode == RefreshStatus.refreshing) {
            body = Row(
              mainAxisSize: MainAxisSize.min,
              children: const [RefreshProgressIndicator()],
            );
            // body = Image.asset(
            //   "assets/images/logo.webp",
            //   width: 80.w,
            //   height: 80.w,
            //   color: Theme.of(context).dividerColor,
            //   fit: BoxFit.cover,
            // );
          } else if (mode == RefreshStatus.failed) {
            body = Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.report_rounded),
                Text("请稍后再试"),
              ],
            );
          } else if (mode == RefreshStatus.canRefresh) {
            body = Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.arrow_upward_outlined),
                Text("释放刷新"),
              ],
            );
          } else {
            body = const Text("No more Data");
          }
          return SizedBox(
            height: 50.0.w,
            child: Center(child: body),
          );
        },
      ),
      // Configure the default header indicator. If you have the same header indicator for each page, you need to set this
      footerBuilder: () => CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.arrow_upward_rounded),
                Text("上滑加载更多"),
              ],
            );
          } else if (mode == LoadStatus.loading) {
            body = const CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = const Text("加载失败");
          } else if (mode == LoadStatus.canLoading) {
            body = Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.arrow_downward_rounded),
                Text("释放加载"),
              ],
            );
          } else {
            body = const Text("No more Data");
          }
          return SizedBox(
            height: 55.0.w,
            child: Center(child: body),
          );
        },
      ),

      headerTriggerDistance: 80.0.w,
      // header trigger refresh trigger distance
      footerTriggerDistance: 80.0,
      springDescription: const SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
      // custom spring back animate,the props meaning see the flutter api
      maxOverScrollExtent: 50,
      //The maximum dragging range of the head. Set this property if a rush out of the view area occurs
      maxUnderScrollExtent: 50,
      // Maximum dragging range at the bottom
      enableScrollWhenRefreshCompleted: true,
      //This property is incompatible with PageView and TabBarView. If you need TabBarView to slide left and right, you need to set it to true.
      enableLoadingWhenFailed: true,
      //In the case of load failure, users can still trigger more loads by gesture pull-up.
      hideFooterWhenNotFull: false,
      // Disable pull-up to load more functionality when Viewport is less than one screen
      enableBallisticLoad: true,
      // trigger load more by BallisticScrollActivity
      child: child,
    );
  }
}
