import 'package:flutter/cupertino.dart';
import 'package:pet_community/models/article/user_article_model.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/mine/mine_viewmodel.dart';
import 'package:pet_community/views/community/detail/community_detail_view.dart';

class WorksTab extends StatefulWidget {
  final UserArticleModel userArticleModel;
  final bool isShowRelease;
  final bool isShowUserInfoView;

  const WorksTab({
    Key? key,
    required this.userArticleModel,
    required this.isShowRelease,
    required this.isShowUserInfoView,
  }) : super(key: key);

  @override
  State<WorksTab> createState() => _WorksTabState();
}

class _WorksTabState extends State<WorksTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 1.w,
      spacing: 1.w,
      children: [
        if (widget.isShowRelease)
          Container(
            width: (MediaQuery.of(context).size.width - 3.w) / 3,
            height: 149.w,
            color: ThemeUtil.reversePrimaryColor(context).withOpacity(0.2),
            child: TextButton(
              onPressed: () => context.read<MineViewModel>().releaseWork(context),
              style: TextButton.styleFrom(primary: ThemeUtil.reversePrimaryColor(context)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Icon(Icons.camera_alt), Text("发作品")],
              ),
            ),
          ),
        ...List.generate(widget.userArticleModel.data?.length ?? 0, (index) {
          int d = (index % 10) + 1;
          return SizedBox(
            width: (MediaQuery.of(context).size.width - 3.w) / 3,
            height: 149.w,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      RouteUtil.pushByCupertino(
                        context,
                        CommunityDetailView(
                          title: widget.userArticleModel.data![index].title ?? "",
                          content: widget.userArticleModel.data![index].content ?? "",
                          articleId: widget.userArticleModel.data![index].articleId,
                          pictures: widget.userArticleModel.data![index].pictures!,
                          userId: widget.userArticleModel.data![index].userId,
                          isShowUserInfoView: widget.isShowUserInfoView,
                        ),
                      );
                    },
                    child: widget.userArticleModel.data![index].pictures!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: widget.userArticleModel.data![index].pictures![0],
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                const CupertinoActivityIndicator(),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                            fit: BoxFit.cover,
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            alignment: Alignment.center,
                            color: ThemeUtil.reversePrimaryColor(context).withOpacity(0.2),
                            child: Text(widget.userArticleModel.data?[index].content ?? ""),
                          ),
                  ),
                ),
                Positioned(
                  bottom: 5.w,
                  left: 5.w,
                  child: Row(
                    children: [
                      Icon(Icons.favorite_border_rounded, color: Colors.white, size: 14.w),
                      Text(
                        "${widget.userArticleModel.data?[index].likes ?? 0}",
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
