import 'package:pet_community/common/http/base_request.dart';
import 'package:pet_community/config/api_config.dart';
import 'package:pet_community/models/response_model.dart';

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

class SignModel extends ResponseModel {
  SignModel({
    dynamic data,
  }) {
    _data = data;
  }

  SignModel.fromJson(dynamic json) {
    code = json['code'];
    msg = json['msg'];
    _data = json['data'];
  }

  dynamic _data;

  SignModel copyWith({
    dynamic data,
  }) =>
      SignModel(
        data: data ?? _data,
      );

  dynamic get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['msg'] = msg;
    map['data'] = _data;
    return map;
  }
}
