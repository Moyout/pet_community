import 'package:pet_community/models/sign_login/login_model.dart';
import 'package:pet_community/models/user/user_info_model.dart';
import 'package:pet_community/util/toast_util.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';

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

        UserInfoModel userInfoModel = await UserInfoRequest.getUserInfo(userId!, token!);
        // if (userInfoModel.code == 0) {
        //   context.read<NavViewModel>().userInfoModel = userInfoModel;
        // }
        Navigator.pop(context);
        notifyListeners();
      }
    } else {
      ToastUtil.showBottomToast("请填写完整信息");
    }
  }
}
