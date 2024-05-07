import 'package:dio/dio.dart';
import 'package:pet_community/models/response_model.dart';
import 'package:pet_community/util/tools.dart';

class SetGenderRequest {
  static Future<SetGenderModel> setUserGender(int userId, String token, String gender) async {
    String url = ApiConfig.baseUrl + "/user/setUserGender";
    var response = await BaseRequest().toPost(
      url,
      parameters: {"userId": userId, "gender": gender},
      options: Options(headers: {PublicKeys.token: token}),
      isShowLoading: true,
    );
    SetGenderModel scModel = SetGenderModel.fromJson(response);
    return scModel;
  }
}

/// code : 0
/// msg : "操作成功"
/// data : null

class SetGenderModel extends ResponseModel {
  SetGenderModel({
    dynamic data,
  }) {
    _data = data;
  }

  SetGenderModel.fromJson(dynamic json) {
    code = json['code'];
    msg = json['msg'];
    _data = json['data'];
  }

  dynamic _data;

  SetGenderModel copyWith({
    dynamic data,
  }) =>
      SetGenderModel(
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
