import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/sign_login/sign_login_viewmodel.dart';
import 'package:pet_community/view_models/sign_login/sign_viewmodel.dart';
import 'package:pet_community/view_models/verification_model/slide_verification_viewmodel.dart';
import 'package:pet_community/widget/textFiled/textfiled_widget.dart';

class SignView extends StatefulWidget {
  static const String routeName = 'SignView';

  const SignView({Key? key}) : super(key: key);

  @override
  State<SignView> createState() => _SignViewState();
}

class _SignViewState extends State<SignView> {
  GlobalKey checkboxKey = GlobalKey();
  GlobalKey sendIconKey = GlobalKey();
  GlobalKey passwordTextFiledKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    context.read<SignViewModel>().initViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Column(
            children: [
              const Spacer(),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "注册",
                  style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              Container(
                margin: EdgeInsets.symmetric(vertical: 6.w),
                // height: 50.w,
                child: TextFileWidget(
                  controller: context.watch<SignViewModel>().accountC,
                  hintText: "请输入邮箱",
                  maxLength: 23,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9@_.]")),
                  ],
                  leftIcon: Padding(
                    padding: EdgeInsets.only(left: 14.w),
                    child: GestureDetector(
                      onTap: () => ToastUtil.showBottomToast("目前仅支持邮箱注册"),
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
                  controller: context.watch<SignViewModel>().passwordC,
                  isHide: !context.watch<SignViewModel>().isShowPassword,
                  hintText: "请输入密码",
                  maxLength: 16,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-z]")),
                  ],
                  leftIcon: Padding(
                    padding: EdgeInsets.only(left: 14.w, right: 14.w),
                    child: GestureDetector(
                      onTap: () {},
                      child: Icon(Icons.lock, key: passwordTextFiledKey, size: 20.w),
                    ),
                  ),
                  rightIcon: GestureDetector(
                    onTap: () => context.read<SignViewModel>().showPassword(),
                    child: context.watch<SignViewModel>().isShowPassword
                        ? const Icon(Icons.visibility_off_outlined)
                        : const Icon(Icons.remove_red_eye_outlined),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 6.w),
                // height: 50.w,
                child: TextFileWidget(
                  controller: context.watch<SignViewModel>().verificationC,
                  readOnly: !context.watch<SlideVerificationViewModel>().isPass,
                  onTap: () => context.read<SignViewModel>().verificationTextFileOnTap(context, sendIconKey),
                  hintText: "验证码",
                  maxLength: 6,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                  ],
                  leftIcon: Padding(
                    padding: EdgeInsets.only(left: 14.w, right: 14.w),
                    child: Icon(Icons.abc, size: 20.w),
                  ),
                  rightIcon: GestureDetector(
                    key: sendIconKey,
                    onTap: () =>
                        context.read<SignViewModel>().showSendVerificationWidget(context, passwordTextFiledKey),
                    child: const Icon(Icons.send, color: Colors.green),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DefaultTextStyle(
                  style: TextStyle(color: Colors.blue, fontSize: 12.sp),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      SizedBox(
                        height: 30.w,
                        child: Checkbox(
                          key: checkboxKey,
                          shape: const StadiumBorder(),
                          value: context.watch<SignViewModel>().isAgree,
                          onChanged: (bool? v) {
                            context.read<SignViewModel>().isAgree = v!;
                            setState(() {});
                          },
                        ),
                      ),
                      Text(
                        "已经阅读并同意",
                        style: TextStyle(color: ThemeUtil.reversePrimaryColor(context)),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text("《用户协议》"),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text("《隐私政策》"),
                      ),
                    ],
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
                      onTap: () {
                        context.read<SignLoginViewModel>().pageC.jumpToPage(1);
                      },
                      child: const Text("已有账号"),
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
                    onPressed: () => context.read<SignViewModel>().sign(context, checkboxKey),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      foregroundColor: Colors.white,
                    ),
                    child: Text("注册"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
