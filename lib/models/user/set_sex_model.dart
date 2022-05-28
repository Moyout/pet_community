import 'package:dio/dio.dart';
import 'package:pet_community/util/tools.dart';

class SetSexRequest {
  static Future<SetSexModel> setUserSex(int userId, String token, String sex) async {
    String url = ApiConfig.baseUrl + "/user/setUserSex";
    var response = await BaseRequest().toPost(
      url,
      parameters: {"userId": userId, "sex": sex},
      options: Options(headers: {PublicKeys.token: token}),
      isShowLoading: true,
    );
    SetSexModel scModel = SetSexModel.fromJson(response);
    return scModel;
  }
}

/// code : 0
/// msg : "操作成功"
/// data : null

class SetSexModel {
  SetSexModel({
    int? code,
    String? msg,
    dynamic data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  SetSexModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['data'];
  }

  int? _code;
  String? _msg;
  dynamic _data;

  SetSexModel copyWith({
    int? code,
    String? msg,
    dynamic data,
  }) =>
      SetSexModel(
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
