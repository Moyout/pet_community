import 'package:pet_community/models/sign_login/send_code_model.dart';
import 'package:pet_community/models/sign_login/sign_model.dart';
import 'package:pet_community/util/email_util.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/verification_model/slide_verification_viewmodel.dart';
import 'package:pet_community/widget/toast/ftoast_widget.dart';
import 'package:pet_community/widget/verification/slide_verification_widget.dart';

class SignViewModel extends ChangeNotifier {
  bool isSendVerification = false;
  bool isShowPassword = false;

  ///初始化
  void initViewModel() {
    isSendVerification = false;
    isShowPassword = false;
  }

  void verificationTextFileOnTap(BuildContext context) {
    // if (!context.read<SlideVerificationViewModel>().isPass) {
    //   FToastUtil.showToast(context, widgetKey: widgetKey, text: "请先发送验证码");
    // }
  }

  void showPassword() {
    isShowPassword = !isShowPassword;
    notifyListeners();
  }
}
