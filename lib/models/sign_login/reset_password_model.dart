import 'package:pet_community/util/tools.dart';

class ResetPasswordRequest {
  static Future<ResetPasswordModel> sendResetPasswordCode(String? email) async {
    String url = ApiConfig.baseUrl + "/user/resetUserPassword";
    var response = await BaseRequest().toPost(
      url,
      parameters: {"email": email},
      isShowLoading: true,
    );
    ResetPasswordModel scModel = ResetPasswordModel.fromJson(response);
    return scModel;
  }

  static resetUserLoginPassword(
    String? email,
    String? code,
    String? newPwd,
  ) async {
    String url = ApiConfig.baseUrl + "/user/setUserLoginPassword";
    var response = await BaseRequest().toPost(
      url,
      parameters: {"email": email, "code": code, "newPwd": newPwd},
      isShowLoading: true,
    );
    ResetPasswordModel scModel = ResetPasswordModel.fromJson(response);
    return scModel;
  }
}

class ResetPasswordModel {
  ResetPasswordModel({
    num? code,
    String? msg,
    dynamic data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  ResetPasswordModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['data'];
  }

  num? _code;
  String? _msg;
  dynamic _data;

  ResetPasswordModel copyWith({
    num? code,
    String? msg,
    dynamic data,
  }) =>
      ResetPasswordModel(
        code: code ?? _code,
        msg: msg ?? _msg,
        data: data ?? _data,
      );

  num? get code => _code;

  String? get msg => _msg;

  dynamic get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    map['data'] = _data;
    return map;
  }
}
