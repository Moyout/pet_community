import 'package:pet_community/models/article/article_model.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommunityViewModel extends ChangeNotifier {
  RefreshController refreshC = RefreshController();
  ArticleModel articleModel = ArticleModel();
  int page = 1;

  ///初始化
  Future<void> initViewModel() async {
    page = 1;
    articleModel = await ArticleRequest.getArticle(page: page);
    notifyListeners();
  }

  ///刷新
  Future<void> onRefresh() async {
    articleModel = await ArticleRequest.getArticle(page: 1).whenComplete(() => refreshC.refreshToIdle());
  }
}
