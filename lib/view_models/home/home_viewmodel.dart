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
    videoModel = await VideoRequest.getVideo(page: page);
    notifyListeners();
  }

  ///刷新
  Future<void> onRefresh(bool isShowLoading) async {
    page = 1;
    enablePullUp = true;
    videoModel = await VideoRequest.getVideo(page: page, isShowLoading: isShowLoading)
        .whenComplete(() => refreshC.refreshToIdle());
    notifyListeners();
  }

  ///加载更多//
  Future<void> loadMore() async {
    page++;
    VideoModel model = await VideoRequest.getVideo(page: page).whenComplete(() => refreshC.loadComplete());
    if (model.data!.isNotEmpty) {
      model.data?.forEach((Data item) {
        videoModel.data?.add(item);
      });
      debugPrint("model--------->${model.data}");
    } else {
      enablePullUp = false;
      ToastUtil.showBottomToast("已加载全部");
    }
    notifyListeners();
  }
}
