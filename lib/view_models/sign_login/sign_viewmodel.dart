import 'package:pet_community/models/sign_login/send_code_model.dart';
import 'package:pet_community/models/sign_login/sign_model.dart';
import 'package:pet_community/util/email_util.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/verification_model/slide_verification_viewmodel.dart';
import 'package:pet_community/widget/toast/ftoast_widget.dart';
import 'package:pet_community/widget/verification/slide_verification_widget.dart';

class SignViewModel extends ChangeNotifier {
  TextEditingController accountC = TextEditingController();
  TextEditingController verificationC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  bool isSendVerification = false;
  bool isAgree = false;
  bool isShowPassword = false;

  ///初始化
  void initViewModel() {
    accountC.clear();
    verificationC.clear();
    passwordC.clear();
    isSendVerification = false;
    isAgree = false;
    isShowPassword = false;
  }

  void showSendVerificationWidget(BuildContext context, GlobalKey widgetKey) {
    if (EmailUtil.isEmail(accountC.text)) {
      if (passwordC.text.isNotEmpty) {
        verificationC.clear();
        showDialog(context: context, builder: (context) => const SlideVerificationWidget());
      } else {
        FToastUtil.showToast(context, widgetKey: widgetKey, text: "请先输入密码");
      }
    } else {
      ToastUtil.showBottomToast("请输入正确的账号");
    }
  }

  void verificationTextFileOnTap(BuildContext context, GlobalKey widgetKey) {
    if (!context.read<SlideVerificationViewModel>().isPass) {
      FToastUtil.showToast(context, widgetKey: widgetKey, text: "请先发送验证码");
    }
  }

  void showPassword() {
    isShowPassword = !isShowPassword;
    notifyListeners();
  }

  ///发送验证码
  Future<void> sendVerificationCode() async {
    if (accountC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      SendCodeModel sendCodeModel = await SendCodeRequest.sendCode(accountC.text, passwordC.text);
      ToastUtil.showBottomToast(sendCodeModel.msg!);
    } else {
      ToastUtil.showBottomToast("账号或密码不能为空");
    }
  }

  ///激活注册账号
  Future<void> sign(BuildContext context, GlobalKey widgetKey) async {
    if (!isAgree) {
      FToastUtil.showToast(context, widgetKey: widgetKey, text: "请先阅读并同意协议");
      return;
    }
    if (accountC.text.isNotEmpty && passwordC.text.isNotEmpty && verificationC.text.isNotEmpty) {
      SignModel signModel = await SignRequest.activationAccount(accountC.text, passwordC.text, verificationC.text);
      ToastUtil.showBottomToast(signModel.msg!);
    } else {
      ToastUtil.showBottomToast("请填写完整信息");
    }
  }
}
