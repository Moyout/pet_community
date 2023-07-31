import 'package:dio/dio.dart';
import 'package:pet_community/models/response_model.dart';
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

class SetSexModel extends ResponseModel {
  SetSexModel({
    dynamic data,
  }) {
    _data = data;
  }

  SetSexModel.fromJson(dynamic json) {
    code = json['code'];
    msg = json['msg'];
    _data = json['data'];
  }

  dynamic _data;

  SetSexModel copyWith({
    dynamic data,
  }) =>
      SetSexModel(
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
