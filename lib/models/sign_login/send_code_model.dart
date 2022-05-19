import 'package:pet_community/common/http/base_request.dart';
import 'package:pet_community/config/api_config.dart';

class SendCodeRequest {
  static Future<SendCodeModel> sendCode(String email, String password) async {
    String url = ApiConfig.baseUrl + "/user/create";
    var response = await BaseRequest().toPost(
      url,
      parameters: {
        "email": email,
        "password": password,
      },
      isShowLoading: true,
    );
    SendCodeModel scModel = SendCodeModel.fromJson(response);
    return scModel;
  }
}

/// code : 200
/// msg : "注册确认链接/验证码已发送"
/// data : null

class SendCodeModel {
  SendCodeModel({
    int? code,
    String? msg,
    dynamic data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  SendCodeModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['data'];
  }

  int? _code;
  String? _msg;
  dynamic _data;

  SendCodeModel copyWith({
    int? code,
    String? msg,
    dynamic data,
  }) =>
      SendCodeModel(
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
