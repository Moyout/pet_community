import 'package:dio/dio.dart';
import 'package:pet_community/util/tools.dart';

class SetAvatarRequest {
  static Future<SetAvatarModel> setUserAvatar(int userId, String token, String filePath) async {
    String url = ApiConfig.baseUrl + "/user/setUserAvatar";
    var response = await BaseRequest().toPost(
      url,
      parameters: {"userId": userId, "filePath": filePath},
      options: Options(headers: {PublicKeys.token: token}),
      isShowLoading: true,
    );
    SetAvatarModel scModel = SetAvatarModel.fromJson(response);

    // print(userInfoModel.data);
    return scModel;
  }
}

/// code : 0
/// msg : "操作成功"
/// data : null

class SetAvatarModel {
  SetAvatarModel({
    int? code,
    String? msg,
    dynamic data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  SetAvatarModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['data'];
  }
  int? _code;
  String? _msg;
  dynamic _data;
  SetAvatarModel copyWith({
    int? code,
    String? msg,
    dynamic data,
  }) =>
      SetAvatarModel(
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
