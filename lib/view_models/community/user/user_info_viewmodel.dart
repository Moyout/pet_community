import 'package:pet_community/models/article/user_article_model.dart' as article_model;
import 'package:pet_community/models/article/user_article_model.dart';
import 'package:pet_community/models/user/user_info_model.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/views/mine/avatar/set_avatar_view.dart';

class UserInfoViewModel extends ChangeNotifier {
  late TabController tC;
  static double offsetY = 0;
  static double defaultHeight = 220.w;
  static double maxHeight = 320.w;
  static double distance = maxHeight - defaultHeight;
  final ScrollController controller = ScrollController(initialScrollOffset: distance - 10);
  DragState dragState = DragState.dragStateIdle;
  double scale = 0;
  UserArticleModel userArticleModel = UserArticleModel();
  UserInfoModel userInfoModel = UserInfoModel();
  int userArticlePage = 1;
  bool isAll = false;

  /// 初始化viewModel
  void initViewModel(int userId, TickerProvider tickerProvider) {
    userArticlePage = 1;
    isAll = false;
    userInfoModel = UserInfoModel();
    getUserInfoModel(userId);
    getUserWorks(userId);
    tC = TabController(length: 2, vsync: tickerProvider);
    controller.addListener(() async {
      offsetY = controller.offset;
      if (offsetY == 0.0) restWithAnimation(true);
      if (offsetY < distance) scale = (1 - offsetY / distance).abs();
      if (tC.index == 0) {
        ///滑到底部
        if (controller.position.maxScrollExtent == offsetY) {
          // if (AppUtils.getContext().read<NavViewModel>().isLogin) {
          if (!isAll) {
            userArticlePage++;
            UserArticleModel model = await UserArticleRequest.getUserArticle(
              userId: userId,
              page: userArticlePage,
            );
            if (model.data!.isNotEmpty) {
              model.data?.forEach((article_model.Data item) {
                userArticleModel.data?.add(item);
              });
            } else {
              isAll = true;
              ToastUtil.showBottomToast("已加载全部");
            }
            notifyListeners();
          }
          // }
        }
      }
      notifyListeners();
    });
  }

  //缩放
  void restWithAnimation(bool delay) {
    Future.delayed(Duration(milliseconds: delay ? 200 : 0)).then((value) {
      if (controller.offset < distance && dragState == DragState.dragStateEnd) {
        dragState = DragState.dragStateIdle;
        controller.animateTo(distance, duration: const Duration(milliseconds: 300), curve: Curves.linear);
        return;
      }
    });
  }

  ///点击头像
  void avatarOnTap(BuildContext context, String avatar) {
    RouteUtil.push(
        context,
        SetAvatarView(
          isOther:
              userInfoModel.data?.userId == context.read<NavViewModel>().userInfoModel?.data?.userId ? false : true,
          avatar: userInfoModel.data?.avatar ?? avatar,
        ),
        animation: RouteAnimation.popDown);
  }

  Future<void> getUserInfoModel(int userId) async {
    UserInfoModel model = await UserInfoRequest.getOtherUserInfo(userId);
    if (model.code == 0) {
      userInfoModel = model;
    } else {}
    notifyListeners();
  }

  ///获取作品
  Future<void> getUserWorks(int userId) async {
    UserArticleModel model = await UserArticleRequest.getUserArticle(userId: userId);
    if (model.code == 0) {
      userArticleModel = model;
      notifyListeners();
    } else {
      ToastUtil.showBottomToast(model.msg);
    }
  }
}
