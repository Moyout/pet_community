import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/sign_login/login_viewmodel.dart';
import 'package:pet_community/view_models/sign_login/sign_login_viewmodel.dart';
import 'package:pet_community/widget/textFiled/textfiled_widget.dart';

class LoginView extends StatefulWidget {
  static const String routeName = 'LoginView';

  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
    context.read<LoginViewModel>().initViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: AutofillGroup(
            child: Column(
              children: [
                const Spacer(),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "登录",
                    style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 6.w),
                  // height: 50.w,
                  child: TextFileWidget(
                    controller: context.watch<LoginViewModel>().accountC,
                    hintText: "请输入邮箱",
                    autofillHints: const [AutofillHints.username],
                    maxLength: 23,
                    inputFormatter: [
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9@_.]")),
                    ],
                    leftIcon: Padding(
                      padding: EdgeInsets.only(left: 14.w),
                      child: GestureDetector(
                        onTap: () => ToastUtil.showBottomToast("目前仅支持邮箱登录"),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.email, size: 20.w),
                            Icon(Icons.keyboard_arrow_down, color: ThemeUtil.reversePrimaryColor(context), size: 18.w),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 6.w),
                  // height: 50.w,
                  child: TextFileWidget(
                    controller: context.watch<LoginViewModel>().passwordC,
                    isHide: !context.watch<LoginViewModel>().isShowPassword,
                    hintText: "请输入密码",
                    maxLength: 16,
                    autofillHints: const [AutofillHints.password],
                    inputFormatter: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-z]")),
                    ],
                    leftIcon: Padding(
                      padding: EdgeInsets.only(left: 14.w, right: 14.w),
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(Icons.lock, size: 20.w),
                      ),
                    ),
                    rightIcon: GestureDetector(
                      onTap: () => context.read<LoginViewModel>().setShowPassword(),
                      child: context.watch<LoginViewModel>().isShowPassword
                          ? const Icon(Icons.visibility_off_outlined)
                          : const Icon(Icons.remove_red_eye_outlined),
                    ),
                  ),
                ),
                const Spacer(flex: 5),
                DefaultTextStyle(
                  style: TextStyle(
                    color: ThemeUtil.reversePrimaryColor(context).withOpacity(0.8),
                    fontSize: 12.sp,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => context.read<SignLoginViewModel>().pageC.jumpToPage(0),
                        child: const Text("注册账号"),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text("忘记密码"),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.w),
                SafeArea(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    // margin: EdgeInsets.symmetric(vertical: 10.w),
                    child: TextButton(
                      onPressed: () => context.read<LoginViewModel>().loginAccount(context),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        foregroundColor: Colors.white,
                      ),
                      child: Text("登录"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
