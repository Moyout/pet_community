import 'package:dio/dio.dart';
import 'package:pet_community/models/response_model.dart';
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

class SetBackgroundModel extends ResponseModel {
  SetBackgroundModel({
    dynamic data,
  }) {
    _data = data;
  }

  SetBackgroundModel.fromJson(dynamic json) {
    code = json['code'];
    msg = json['msg'];
    _data = json['data'];
  }

  dynamic _data;

  SetBackgroundModel copyWith({
    dynamic data,
  }) =>
      SetBackgroundModel(
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
