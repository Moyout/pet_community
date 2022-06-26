import 'package:pet_community/models/article/article_model.dart';
import 'package:pet_community/util/toast_util.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommunityViewModel extends ChangeNotifier {
  RefreshController refreshC = RefreshController();
  ArticleModel articleModel = ArticleModel();
  int page = 1;
  bool enablePullUp = true;

  ///初始化
  Future<void> initViewModel() async {
    page = 1;
    enablePullUp = true;
    articleModel = await ArticleRequest.getArticle(page: page);
    notifyListeners();
  }

  ///刷新
  Future<void> onRefresh(bool isShowLoading) async {
    page = 1;
    enablePullUp = true;
    articleModel = await ArticleRequest.getArticle(
      page: 1,
      isShowLoading: isShowLoading,
    ).whenComplete(() => refreshC.refreshToIdle());
    notifyListeners();
  }

  ///加载更多//
  Future<void> loadMore() async {
    page++;
    ArticleModel article = await ArticleRequest.getArticle(page: page).whenComplete(() => refreshC.loadComplete());
    if (article.data!.isNotEmpty) {
      article.data?.forEach((Data item) {
        articleModel.data?.add(item);
      });
      debugPrint("articleModel--------->${articleModel.data}");
    } else {
      enablePullUp = false;
      ToastUtil.showBottomToast("已加载全部");
    }
    notifyListeners();
  }
}
