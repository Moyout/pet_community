import 'package:pet_community/models/video/video_model.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeViewModel extends ChangeNotifier {
  VideoModel videoModel = VideoModel();
  RefreshController refreshC = RefreshController();
  int page = 1;
  bool enablePullUp = true;

  ///初始化ViewModel
  Future<void> initViewModel() async {
    page = 1;
    enablePullUp = true;
    videoModel = await VideoRequest.getVideo(page: page, count: 10);
    notifyListeners();
  }

  ///刷新
  Future<void> onRefresh() async {
    page = 1;
    enablePullUp = true;
    videoModel = await VideoRequest.getVideo(page: page, count: 10).whenComplete(() => refreshC.refreshToIdle());
    notifyListeners();
  }
}
