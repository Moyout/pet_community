import 'package:pet_community/common/http/base_request.dart';
import 'package:pet_community/config/api_config.dart';

class SignRequest {
  static Future<SignModel> activationAccount(
    String email,
    String password,
    String verificationCode,
  ) async {
    String url = ApiConfig.baseUrl + "/user/checkVerificationCode";
    var response = await BaseRequest().toGet(
      url,
      parameters: {"email": email, "password": password, "verificationCode": verificationCode},
      isShowLoading: true,
    );
    SignModel scModel = SignModel.fromJson(response);
    return scModel;
  }
}

/// code : 1005
/// msg : "账号已存在"
/// data : null

class SignModel {
  SignModel({
    int? code,
    String? msg,
    dynamic data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  SignModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['data'];
  }

  int? _code;
  String? _msg;
  dynamic _data;

  SignModel copyWith({
    int? code,
    String? msg,
    dynamic data,
  }) =>
      SignModel(
        code: code ?? _code,
        msg: msg ?? _msg,
        data: data ?? _data,
      );

  int? get code => _code;

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
