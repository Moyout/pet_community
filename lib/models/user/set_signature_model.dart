import 'package:dio/dio.dart';
import 'package:pet_community/util/tools.dart';

class SetSignatureRequest {
  static Future<SetSignatureModel> setUserSignature(int userId, String token, String signature) async {
    String url = ApiConfig.baseUrl + "/user/setUserSignature";
    var response = await BaseRequest().toPost(
      url,
      parameters: {"userId": userId, "signature": signature},
      options: Options(headers: {PublicKeys.token: token}),
      isShowLoading: true,
    );
    SetSignatureModel scModel = SetSignatureModel.fromJson(response);
    // print(userInfoModel.data);
    return scModel;
  }
}

/// code : 0
/// msg : "操作成功"
/// data : null

class SetSignatureModel {
  SetSignatureModel({
    int? code,
    String? msg,
    dynamic data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  SetSignatureModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['data'];
  }
  int? _code;
  String? _msg;
  dynamic _data;
  SetSignatureModel copyWith({
    int? code,
    String? msg,
    dynamic data,
  }) =>
      SetSignatureModel(
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
