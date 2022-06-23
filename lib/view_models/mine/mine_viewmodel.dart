import 'package:pet_community/enums/drag_state_enum.dart';
import 'package:pet_community/models/article/user_article_model.dart';
import 'package:pet_community/util/toast_util.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/view_models/sign_login/sign_login_viewmodel.dart';
import 'package:pet_community/view_models/startup_viewmodel.dart';
import 'package:pet_community/views/mine/avatar/set_avatar_view.dart';
import 'package:pet_community/views/mine/background/set_background_view.dart';
import 'package:pet_community/views/mine/work/release_work_view.dart';
import 'package:pet_community/views/sign_login/sign_login_view.dart';

class MineViewModel extends ChangeNotifier {
  late TabController tC;
  static double offsetY = 0;
  static double defaultHeight = 220.w;
  static double maxHeight = 320.w;
  static double distance = maxHeight - defaultHeight;
  final ScrollController controller = ScrollController(initialScrollOffset: distance - 10);
  DragState dragState = DragState.dragStateIdle;
  double scale = 0;
  UserArticleModel userArticleModel = UserArticleModel();
  int userArticlePage = 1;
  bool isAll = false;

  /// 初始化viewModel
  void initViewModel(TickerProvider tickerProvider) {
    userArticlePage = 1;
    isAll = false;
    tC = TabController(length: 2, vsync: tickerProvider);

    controller.addListener(() async {
      offsetY = controller.offset;
      if (offsetY == 0.0) restWithAnimation(true);
      if (offsetY < distance) scale = (1 - offsetY / distance).abs();
      if (tC.index == 0) {
        ///滑到底部
        if (controller.position.maxScrollExtent == offsetY) {
          if (AppUtils.getContext().read<NavViewModel>().isLogin) {
            if (!isAll) {
              int userId = SpUtil.getInt(PublicKeys.userId)!;
              userArticlePage++;
              UserArticleModel model = await UserArticleRequest.getUserArticle(userId: userId, page: userArticlePage);
              if (model.data!.isNotEmpty) {
                model.data?.forEach((Data item) {
                  userArticleModel.data?.add(item);
                });
              } else {
                isAll = true;
                ToastUtil.showBottomToast("已加载全部");
              }
              notifyListeners();
            }
          }
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
  void avatarOnTap(BuildContext context) {
    bool isLogin = context.read<NavViewModel>().isLogin;
    if (isLogin) {
      RouteUtil.push(
          context,
          SetAvatarView(
            avatar: context.read<NavViewModel>().userInfoModel?.data?.avatar ??
                ApiConfig.baseUrl + "/images/pet${context.read<StartUpViewModel>().random}.jpg",
          ),
          animation: RouteAnimation.popDown);
    } else {
      context.read<SignLoginViewModel>().initialPage = 1;
      RouteUtil.push(context, const SignLoginView(), animation: RouteAnimation.popDown);
    }
  }

  ///点击背景
  void backgroundOnTap(BuildContext context) {
    RouteUtil.push(
        context,
        SetBackgroundView(
          background: context.read<NavViewModel>().userInfoModel?.data?.background ??
              ApiConfig.baseUrl + "/images/pet${context.read<StartUpViewModel>().random}.jpg",
        ),
        animation: RouteAnimation.popDown);
  }

  ///发作品
  void releaseWork(BuildContext context) {
    if (context.read<NavViewModel>().isLogin) {
      RouteUtil.push(
        context,
        const ReleaseWorkView(),
        animation: RouteAnimation.popDown,
        millisecond: 200,
      );
    } else {
      RouteUtil.push(context, const SignLoginView(), animation: RouteAnimation.popDown);
    }
  }

  ///获取作品
  Future<void> getUserWorks(BuildContext context) async {
    if (context.read<NavViewModel>().isLogin) {
      int userId = SpUtil.getInt(PublicKeys.userId)!;
      UserArticleModel model = await UserArticleRequest.getUserArticle(userId: userId);
      if (model.code == 0) {
        userArticleModel = model;
        notifyListeners();
      } else {
        ToastUtil.showBottomToast(model.msg!);
      }
    }
  }
}
