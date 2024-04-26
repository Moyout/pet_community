import 'package:pet_community/models/sign_login/reset_password_model.dart';
import 'package:pet_community/util/email_util.dart';
import 'package:pet_community/util/tools.dart';

class ResetPasswordView extends StatefulWidget {
  static const String routeName = "ResetPasswordView";

  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  TextEditingController emailC = TextEditingController();
  TextEditingController codeC = TextEditingController();
  TextEditingController newPwdC = TextEditingController();
  bool isSendCode = false;
  bool isShowPassword = false;

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
                        "重置密碼",
                        style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 6.w, horizontal: 20.w),
                      child: defaultTextField(
                        emailC,
                        maxLength: 40,
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
                    if (isSendCode)
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 6.w, horizontal: 20.w),
                        // height: 50.w,
                        child: defaultTextField(
                          codeC,
                          hintText: "验证码",
                          maxLength: 6,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          ],
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 14.w, right: 14.w),
                            child: Icon(Icons.abc, size: 20.w),
                          ),
                        ),
                      ),
                    if (isSendCode)
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 6.w, horizontal: 20.w),
                        // height: 50.w,
                        child: defaultTextField(
                          newPwdC,
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
                  ],
                ),
              ),
              if (!isSendCode)
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: TextButton(
                    onPressed: !checkIsEmail() ? null : () => sendCode(),
                    style: TextButton.styleFrom(
                      disabledBackgroundColor: Colors.grey,
                      backgroundColor: Colors.blueGrey,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("下一步"),
                  ),
                ),
              if (isSendCode)
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: TextButton(
                    onPressed: !checkConfirm() ? null : () => resetPassword(),
                    style: TextButton.styleFrom(
                      disabledBackgroundColor: Colors.grey,
                      backgroundColor: Colors.blueGrey,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("确定"),
                  ),
                ),
              SizedBox(height: MediaQuery.of(context).padding.bottom)
            ],
          ),
        ),
      ),
    );
  }

  bool checkIsEmail() {
    return EmailUtil.isEmail(emailC.text);
  }

  bool checkConfirm() {
    return EmailUtil.isEmail(emailC.text) && codeC.text.isNotEmpty && newPwdC.text.isNotEmpty;
  }

  sendCode() async {
    ResetPasswordModel model = await ResetPasswordRequest.sendResetPasswordCode(emailC.text.trim());
    if (model.code == 200) {
      isSendCode = true;
    }
    if (model.msg != null) ToastUtil.showBottomToast(model.msg!);
    setState(() {});
  }

  resetPassword() async {
    ResetPasswordModel model = await ResetPasswordRequest.resetUserLoginPassword(
      emailC.text.trim(),
      codeC.text.trim(),
      newPwdC.text.trim(),
    );
    if (model.code == 0) {
      Navigator.pop(context);
    }
    if (model.msg != null) ToastUtil.showBottomToast(model.msg!);
    setState(() {});
  }
}
