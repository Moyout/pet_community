import 'package:dio/dio.dart';
import 'package:pet_community/util/tools.dart';

class SetAreaRequest {
  static Future<SetAreaModel> setUserArea(int userId, String token, String area) async {
    String url = ApiConfig.baseUrl + "/user/setUserArea";
    var response = await BaseRequest().toPost(
      url,
      parameters: {"userId": userId, "area": area},
      options: Options(headers: {PublicKeys.token: token}),
      isShowLoading: true,
    );
    SetAreaModel scModel = SetAreaModel.fromJson(response);
    return scModel;
  }
}

/// code : 0
/// msg : "操作成功"
/// data : null

class SetAreaModel {
  SetAreaModel({
    int? code,
    String? msg,
    dynamic data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  SetAreaModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['data'];
  }
  int? _code;
  String? _msg;
  dynamic _data;
  SetAreaModel copyWith({
    int? code,
    String? msg,
    dynamic data,
  }) =>
      SetAreaModel(
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
