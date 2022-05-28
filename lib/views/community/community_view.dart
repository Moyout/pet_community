import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/community/community_viewmodel.dart';
import 'package:pet_community/widget/common/unripple.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("发现")),
      body: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: SmartRefresher(
          controller: context.watch<CommunityViewModel>().refreshC,
          onRefresh: () {},
          child: Center(
            child: Text("Community"),
          ),
        ),
      ),
    );
  }
}
