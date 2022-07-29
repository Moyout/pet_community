import 'package:pet_community/models/article/user_article_model.dart';
import 'package:pet_community/models/sign_login/login_model.dart';
import 'package:pet_community/models/user/user_info_model.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/mine/mine_viewmodel.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/view_models/sign_login/sign_login_viewmodel.dart';
import 'package:pet_community/views/sign_login/sign_login_view.dart';

class LoginViewModel extends ChangeNotifier {
  TextEditingController accountC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  bool isShowPassword = false;

  void initViewModel() {
    accountC.clear();
    passwordC.clear();
    isShowPassword = false;
  }

  void setShowPassword() {
    isShowPassword = !isShowPassword;
    notifyListeners();
  }

  Future<void> loginAccount(BuildContext context) async {
    if (accountC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      LoginModel loginModel = await LoginRequest.loginAccount(accountC.text, passwordC.text);
      ToastUtil.showBottomToast(loginModel.msg!);
      if (loginModel.code == 200) {
        SpUtil.setString(PublicKeys.token, loginModel.data?.token);
        SpUtil.setInt(PublicKeys.userId, loginModel.data?.userId);
        SpUtil.setBool(PublicKeys.isLogin, true);
        String? token = SpUtil.getString(PublicKeys.token);
        int? userId = SpUtil.getInt(PublicKeys.userId);
        context.read<NavViewModel>().isLogin = true;
        await UserInfoRequest.getUserInfo(userId!, token!);

        context.read<MineViewModel>().userArticleModel = await UserArticleRequest.getUserArticle(userId: userId);
        context.read<MineViewModel>().userArticlePage = 1;
        context.read<MineViewModel>().isAll = false;

        context.read<MineViewModel>().notifyListeners();
        context.read<NavViewModel>().notifyListeners();

        context.read<NavViewModel>().connectWebSocket();

        Navigator.pop(context);
        notifyListeners();
      }
    } else {
      ToastUtil.showBottomToast("请填写完整信息");
    }
  }

  ///token过期处理
  static void tokenExpire({String? msg}) {
    if (msg != null) ToastUtil.showBottomToast(msg);
    SpUtil.remove("UserInfoModel");
    AppUtils.getContext().read<NavViewModel>().isLogin = false;
    SpUtil.setBool(PublicKeys.isLogin, false);
    AppUtils.getContext().read<NavViewModel>().userInfoModel = UserInfoModel();
    AppUtils.getContext().read<MineViewModel>().userArticleModel = UserArticleModel();
    AppUtils.getContext().read<NavViewModel>().notifyListeners();
    AppUtils.getContext().read<MineViewModel>().notifyListeners();
    Future.delayed(const Duration(milliseconds: 300), () {
      AppUtils.getContext().read<SignLoginViewModel>().initialPage = 1;
      RouteUtil.push(AppUtils.getContext(), const SignLoginView(), animation: RouteAnimation.popDown);
    });
  }
}
