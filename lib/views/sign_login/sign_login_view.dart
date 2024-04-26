import 'package:flutter/gestures.dart';
import 'package:pet_community/util/email_util.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/sign_login/sign_login_viewmodel.dart';
import 'package:pet_community/views/sign_login/privacy_policy_view.dart';
import 'package:pet_community/views/sign_login/reset_password_view.dart';
import 'package:pet_community/widget/verification/slide_verification_widget.dart';

class SignLoginView extends StatefulWidget {
  static const String routeName = 'SignLoginView';

  const SignLoginView({Key? key}) : super(key: key);

  @override
  State<SignLoginView> createState() => _SignLoginViewState();
}

class _SignLoginViewState extends State<SignLoginView> {
  TextEditingController accountC = TextEditingController();
  TextEditingController verificationC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  bool isLoginMode = true;
  bool isAgree = false;
  bool isShowPassword = false;
  SignLoginViewModel slvm = AppUtils.getContext().read<SignLoginViewModel>();

  @override
  void initState() {
    super.initState();
  }

  TextField defaultTextField(
    TextEditingController controller, {
    inputFormatters,
    maxLength,
    hintText,
    prefixIcon,
    bool? obscureText,
    suffixIcon,
  }) {
    return TextField(
      controller: controller,
      onChanged: (v) => setState(() {}),
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.all(0).add(EdgeInsets.symmetric(horizontal: 5.w)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.w),
        ),
        counter: const SizedBox(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      height: 50.w,
                      child: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 50.w, bottom: 40.w, left: 20.w, right: 20.w),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        isLoginMode ? "登录" : "注册",
                        style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 6.w, horizontal: 20.w),
                      child: defaultTextField(
                        accountC,
                        maxLength: 23,
                        hintText: "请输入邮箱",
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9@_.]")),
                        ],
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 14.w),
                          child: GestureDetector(
                            onTap: () => ToastUtil.showBottomToast("目前仅支持邮箱"),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.email, size: 20.w),
                                Icon(Icons.keyboard_arrow_down,
                                    color: ThemeUtil.reversePrimaryColor(context), size: 18.w),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 6.w, horizontal: 20.w),
                      // height: 50.w,
                      child: defaultTextField(
                        passwordC,
                        obscureText: !isShowPassword,
                        hintText: "请输入密码",
                        maxLength: 16,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-z]")),
                        ],
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 14.w, right: 14.w),
                          child: Icon(Icons.lock, size: 20.w),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            isShowPassword = !isShowPassword;
                            setState(() {});
                          },
                          child: !isShowPassword
                              ? const Icon(Icons.visibility_off_outlined)
                              : const Icon(Icons.remove_red_eye_outlined),
                        ),
                      ),
                    ),
                    if (!isLoginMode)
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 6.w, horizontal: 20.w),
                        // height: 50.w,
                        child: defaultTextField(
                          verificationC,
                          hintText: "验证码",
                          maxLength: 6,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          ],
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 14.w, right: 14.w),
                            child: Icon(Icons.abc, size: 20.w),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: sendCodeCheck()
                                ? () => sliderVerification()
                                : () => ToastUtil.showBottomToast("请填写正确的信息"),
                            child: const Icon(Icons.send, color: Colors.green),
                          ),
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12.w, horizontal: 20.w),
                      child: DefaultTextStyle(
                        style: TextStyle(
                          color: ThemeUtil.reversePrimaryColor(context).withOpacity(0.8),
                          fontSize: 12.sp,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                isLoginMode = !isLoginMode;
                                setState(() {});
                              },
                              child: isLoginMode ? const Text("注册账号") : const Text("已有账号"),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(context, ResetPasswordView.routeName),
                              child: const Text("忘记密码"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SafeArea(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          isAgree = !isAgree;
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 16.w),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 6.w),
                                width: 14.w,
                                height: 14.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: !isAgree ? null : Colors.blue,
                                  border: Border.all(
                                    color: isAgree ? Colors.white : Colors.black,
                                    width: 1.2,
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                  ),
                                ),
                                // child: Icon(Icons.check_circle_outline),
                              ),
                              Container(
                                // height: 20.w,
                                // alignment: Alignment.centerLeft,
                                // color: Colors.blue,
                                constraints: BoxConstraints(maxWidth: 260.w),
                                child: Text.rich(
                                  TextSpan(
                                    text: "已经阅读并同意",
                                    children: [
                                      TextSpan(
                                        text: "《用户协议》",
                                        style: const TextStyle(color: Colors.blue),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => Navigator.pushNamed(context, PrivacyPolicyView.routeName),
                                      ),
                                      TextSpan(
                                        text: "《隐私政策》",
                                        style: const TextStyle(color: Colors.blue),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => Navigator.pushNamed(context, PrivacyPolicyView.routeName),
                                      ),
                                    ],
                                  ),
                                  style: TextStyle(fontSize: 12.sp),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                          onPressed: check() ? () => signOrLogin() : null,
                          style: TextButton.styleFrom(
                            disabledBackgroundColor: Colors.grey,
                            backgroundColor: Colors.blueGrey,
                            foregroundColor: Colors.white,
                          ),
                          child: isLoginMode ? const Text("登录") : const Text("注册"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool check() {
    if (isLoginMode) {
      if (EmailUtil.isEmail(accountC.text) && passwordC.text.isNotEmpty && isAgree) return true;
      return false;
    } else {
      if (EmailUtil.isEmail(accountC.text) && passwordC.text.isNotEmpty && verificationC.text.isNotEmpty && isAgree) {
        return true;
      }
      return false;
    }
  }

  bool sendCodeCheck() {
    if (EmailUtil.isEmail(accountC.text) && passwordC.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  void sliderVerification() async {
    var res = await showDialog(context: context, builder: (context) => const SlideVerificationWidget());
    if (res ?? false) {
      slvm.sendVerificationCode(accountC.text.trim(), passwordC.text.trim());
    }
  }

  void signOrLogin() {
    isLoginMode
        ? slvm.loginAccount(context, accountC.text.trim(), passwordC.text.trim())
        : slvm.sign(accountC.text.trim(), passwordC.text.trim(), verificationC.text.trim());
  }
}
