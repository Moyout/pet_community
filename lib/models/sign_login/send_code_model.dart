import 'package:pet_community/common/http/base_request.dart';
import 'package:pet_community/config/api_config.dart';
import 'package:pet_community/models/response_model.dart';

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

class SendCodeModel extends ResponseModel {
  SendCodeModel({
    dynamic data,
  }) {
    _data = data;
  }

  SendCodeModel.fromJson(dynamic json) {
    code = json['code'];
    msg = json['msg'];
    _data = json['data'];
  }

  dynamic _data;

  SendCodeModel copyWith({
    dynamic data,
  }) =>
      SendCodeModel(
        data: data ?? _data,
      );

  @override
  dynamic get data => _data;

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['msg'] = msg;
    map['data'] = _data;
    return map;
  }
}
