import 'package:pet_community/models/article/delete_article_model.dart';
import 'package:pet_community/models/article_comment/comment_model.dart';
import 'package:pet_community/models/article_comment/comment_model.dart' as comment_model_data;
import 'package:pet_community/models/article_comment/delete_comment_model.dart';
import 'package:pet_community/models/article_comment/release_comment_model.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/community/community_viewmodel.dart';
import 'package:pet_community/view_models/mine/mine_viewmodel.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/view_models/sign_login/login_viewmodel.dart';
import 'package:pet_community/view_models/startup_viewmodel.dart';
import 'package:pet_community/views/community/detail/show_picture_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommunityDetailViewModel extends ChangeNotifier {
  late PageController pc;
  int currentIndex = 0;
  int commentPage = 1;
  bool enablePullUp = true;
  CommentModel commentModel = CommentModel();
  RefreshController refreshC = RefreshController();
  TextEditingController textC = TextEditingController();

  ///初始化viewmodel
  void initViewModel(int index) {
    currentIndex = index;
  }

  ///初始化page控制器
  void initPageController(int index) {
    pc = PageController(initialPage: index);
  }

  ///push展示picture页
  void pushShowPicture(BuildContext context, List<String> list, int index) {
    RouteUtil.pushNamed(context, ShowPictureView.routeName, arguments: {
      "picUrlList": list,
      "index": index,
    });
  }

  ///页面改变时
  void pageOnPageChanged(int index) {
    currentIndex = index;
    notifyListeners();
  }

  ///获取评论
  Future<void> getComment(int articleId) async {
    commentPage = 1;
    enablePullUp = true;
    commentModel = CommentModel();
    CommentModel model = await CommentRequest.getComment(articleId: articleId, page: commentPage);
    if (model.code == 0) commentModel = model;
    notifyListeners();
  }

  ///刷新评论
  Future<void> onRefresh(int articleId) async {
    commentModel = CommentModel();
    commentPage = 1;
    enablePullUp = true;
    CommentModel model = await CommentRequest.getComment(articleId: articleId, page: commentPage)
        .whenComplete(() => refreshC.refreshToIdle());
    if (model.code == 0) commentModel = model;
    notifyListeners();
  }

  ///加载更多//
  Future<void> loadMore(int articleId) async {
    commentPage++;
    CommentModel model = await CommentRequest.getComment(articleId: articleId, page: commentPage)
        .whenComplete(() => refreshC.loadComplete());
    if (model.data!.articleComments.isNotEmpty) {
      model.data?.articleComments.forEach((comment_model_data.ArticleComments item) {
        commentModel.data?.articleComments.add(item);
      });
    } else {
      enablePullUp = false;
      ToastUtil.showBottomToast("已加载全部");
    }
    notifyListeners();
  }

  ///发表评论
  Future<void> releaseComment(BuildContext context, int articleId) async {
    if (context.read<NavViewModel>().isLogin) {
      if (textC.text.trimRight().isNotEmpty) {
        String? token = SpUtil.getString(PublicKeys.token);
        int? userId = SpUtil.getInt(PublicKeys.userId);
        String commentator = context.read<NavViewModel>().userInfoModel?.data?.userName ?? "";

        ReleaseCommentModel releaseCommentModel = await CommentRequest.releaseComment(
          commentator: commentator,
          commentContent: textC.text.trimRight(),
          articleId: articleId,
          userId: userId!,
          token: token!,
        );
        if (releaseCommentModel.code == 0) {
          if (!enablePullUp) {
            commentModel.data?.articleComments.add(
              comment_model_data.ArticleComments(
                articleId: articleId,
                userId: context.read<NavViewModel>().userInfoModel!.data!.userId,
                commentContent: textC.text.trimRight(),
                commentTime: DateTime.now().toString().substring(0, 19),
                commentId: releaseCommentModel.data!.commentId!,
              ),
            );
          }
          enablePullUp = true;
          textC.clear();
          FocusScope.of(context).unfocus();
          ToastUtil.showBottomToast(releaseCommentModel.msg!);
          onRefresh(articleId);
        } else if (releaseCommentModel.code == 1007) {
          LoginViewModel.tokenExpire(msg: releaseCommentModel.msg!);
        }
      }
    } else {
      LoginViewModel.tokenExpire();
    }
    notifyListeners();
  }

  ///删除评论
  Future<bool> deleteComment(int commentId) async {
    bool isDelete = false;
    String? token = SpUtil.getString(PublicKeys.token);
    int? userId = SpUtil.getInt(PublicKeys.userId);
    DeleteCommentModel deleteCommentModel =
        await CommentRequest.deleteComment(commentId: commentId, userId: userId!, token: token!);
    if (deleteCommentModel.code == 0) {
      commentModel.data?.articleComments.removeWhere((element) => element.commentId == commentId);
      isDelete = true;
      notifyListeners();
    } else if (deleteCommentModel.code == 1007) {
      LoginViewModel.tokenExpire();
    }
    ToastUtil.showBottomToast(deleteCommentModel.msg!);
    notifyListeners();
    return isDelete;
  }

  ///删除article
  Future<bool> deleteArticle(BuildContext context, int articleId) async {
    bool isSuccess = false;
    String? token = SpUtil.getString(PublicKeys.token);
    int? userId = SpUtil.getInt(PublicKeys.userId);
    DeleteArticleModel model = await DeleteArticleRequest.deleteArticle(
      articleId: articleId,
      userId: userId!,
      token: token!,
    );
    if (model.code == 0) {
      isSuccess = true;
      AppUtils.getContext()
          .read<MineViewModel>()
          .userArticleModel
          .data
          ?.removeWhere((element) => articleId == element.articleId);
      AppUtils.getContext()
          .read<CommunityViewModel>()
          .articleModel
          .data
          ?.articles
          .removeWhere((element) => articleId == element.articleId);
      AppUtils.getContext().read<MineViewModel>().notifyListeners();
      AppUtils.getContext().read<CommunityViewModel>().notifyListeners();
    } else if (model.code == 1007) {
      LoginViewModel.tokenExpire();
    }
    ToastUtil.showBottomToast(model.msg!);
    return isSuccess;
  }
}
