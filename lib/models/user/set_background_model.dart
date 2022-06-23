import 'package:dio/dio.dart';
import 'package:pet_community/util/tools.dart';

class SetBackgroundRequest {
  static Future<SetBackgroundModel> setUserBackground(int userId, String token, String filePath) async {
    String url = ApiConfig.baseUrl + "/user/setUserBackground";
    var response = await BaseRequest().toPost(
      url,
      parameters: {"userId": userId, "filePath": filePath},
      options: Options(headers: {PublicKeys.token: token}),
      isShowLoading: true,
    );
    SetBackgroundModel scModel = SetBackgroundModel.fromJson(response);

    // print(userInfoModel.data);
    return scModel;
  }
}

/// code : 0
/// msg : "成功"
/// data : null

class SetBackgroundModel {
  SetBackgroundModel({
    int? code,
    String? msg,
    dynamic data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  SetBackgroundModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['data'];
  }
  int? _code;
  String? _msg;
  dynamic _data;
  SetBackgroundModel copyWith({
    int? code,
    String? msg,
    dynamic data,
  }) =>
      SetBackgroundModel(
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
