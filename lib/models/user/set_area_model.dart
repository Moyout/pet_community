import 'package:dio/dio.dart';
import 'package:pet_community/models/response_model.dart';
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

class SetAreaModel extends ResponseModel {
  SetAreaModel({
    dynamic data,
  }) {
    _data = data;
  }

  SetAreaModel.fromJson(dynamic json) {
    code = json['code'];
    msg = json['msg'];
    _data = json['data'];
  }

  dynamic _data;

  SetAreaModel copyWith({
    dynamic data,
  }) =>
      SetAreaModel(
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
