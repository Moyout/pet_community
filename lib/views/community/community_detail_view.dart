import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/community/community_detail_viewmodel.dart';
import 'package:pet_community/view_models/community/community_viewmodel.dart';
import 'package:pet_community/widget/common/unripple.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommunityDetailView extends StatefulWidget {
  final int index;
  final String title;
  final String content;

  const CommunityDetailView({
    Key? key,
    required this.title,
    required this.content,
    required this.index,
  }) : super(key: key);

  @override
  State<CommunityDetailView> createState() => _CommunityDetailViewState();
}

class _CommunityDetailViewState extends State<CommunityDetailView> {
  RefreshController refreshC = RefreshController();

  @override
  void initState() {
    context.read<CommunityDetailViewModel>().initViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int d = (widget.index % 10) + 1;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => RouteUtil.pop(context),
          child: Icon(Icons.arrow_back_ios, color: ThemeUtil.reversePrimaryColor(context)),
        ),
        title: Text(widget.title),
        actions: [
          Center(
            child: ClipOval(
              child: Image.network(
                context.watch<CommunityViewModel>().articleModel.data![widget.index].avatar ??
                    ApiConfig.baseUrl + "/images/avatar/avatar$d.png",
                width: 40.w,
                height: 40.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: SmartRefresher(
          controller: refreshC,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                  child: SelectableText(
                    widget.content,
                    style: const TextStyle(letterSpacing: 1.2),
                  ),
                ),
                ...List.generate(context.watch<CommunityViewModel>().articleModel.data![widget.index].pictures!.length,
                    (index) {
                  return Image.network(
                    context.watch<CommunityViewModel>().articleModel.data![widget.index].pictures![index],
                    fit: BoxFit.fitWidth,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
