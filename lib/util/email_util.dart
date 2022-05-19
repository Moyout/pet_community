class EmailUtil {
  /// 邮箱正则
  static const String regexEmail = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";

  /// 检查是否是邮箱格式
  static bool isEmail(String input) {
    return RegExp(regexEmail).hasMatch(input);
  }
}
