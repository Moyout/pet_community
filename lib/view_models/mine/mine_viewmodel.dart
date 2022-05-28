import 'package:pet_community/enums/drag_state_enum.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/mine/avatar/set_avatar_view.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/view_models/sign_login/sign_login_viewmodel.dart';
import 'package:pet_community/views/sign_login/sign_login_view.dart';

class MineViewModel extends ChangeNotifier {
  static double offsetY = 0;
  static double defaultHeight = 220.w;
  static double maxHeight = 320.w;
  static double distance = maxHeight - defaultHeight;
  final ScrollController controller = ScrollController(initialScrollOffset: distance - 10);
  DragState dragState = DragState.dragStateIdle;
  double scale = 0;

  /// 初始化viewModel
  void initViewModel() {
    controller.addListener(() {
      offsetY = controller.offset;
      if (offsetY == 0.0) {
        restWithAnimation(true);
      }
      if (offsetY < distance) {
        scale = (1 - offsetY / distance).abs();
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
      debugPrint("isLogin--------->${isLogin}");
      RouteUtil.push(context, const SetAvatarView());
    } else {
      context.read<SignLoginViewModel>().initialPage = 1;
      RouteUtil.push(context, const SignLoginView());
    }
  }

  void likesOnTap(BuildContext context) {
    bool isLogin = context.read<NavViewModel>().isLogin;

    if (isLogin) {
      showDialog(
        context: context,
        builder: (c) {
          return GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: GestureDetector(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/backgrounds/likes_background.png",
                        fit: BoxFit.cover,
                      ),
                      Container(
                        color: Colors.white,
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        height: 80.w,
                        child: Text(
                          "\"${context.watch<NavViewModel>().userInfoModel?.data?.userName}\"共获得0个赞 ",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ),
                      const Divider(height: 1),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          color: Colors.white,
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 10.w),
                          child: const Text("确认"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      context.read<SignLoginViewModel>().initialPage = 1;
      RouteUtil.push(context, const SignLoginView());
    }
  }
}
