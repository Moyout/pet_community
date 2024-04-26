import 'package:pet_community/models/article/user_article_model.dart';
import 'package:pet_community/models/sign_login/login_model.dart';
import 'package:pet_community/models/sign_login/send_code_model.dart';
import 'package:pet_community/models/sign_login/sign_model.dart';
import 'package:pet_community/models/user/user_info_model.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/mine/mine_viewmodel.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';

class SignLoginViewModel extends ChangeNotifier {
  ///发送验证码
  Future<void> sendVerificationCode(String account, String password) async {
    SendCodeModel sendCodeModel = await SendCodeRequest.sendCode(account, password);
    ToastUtil.showBottomToast(sendCodeModel.msg);
  }

  ///激活注册账号
  Future<bool> sign(String account, String password, String code) async {
    SignModel signModel = await SignRequest.activationAccount(account, password, code);
    ToastUtil.showBottomToast(signModel.msg);

    return signModel.code == 200;
  }

  Future<void> loginAccount(BuildContext context, String account, String password) async {
    LoginModel loginModel = await LoginRequest.loginAccount(account, password);
    ToastUtil.showBottomToast(loginModel.msg);
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

      bool isInit = await context.read<NavViewModel>().initDatabase(loginModel.data?.userId);
      if (isInit) WebSocketUtils().initSocket();

      Navigator.pop(context);

      notifyListeners();
    }
  }
}
