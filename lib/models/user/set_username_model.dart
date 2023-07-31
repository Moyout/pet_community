import 'package:dio/dio.dart';
import 'package:pet_community/models/response_model.dart';
import 'package:pet_community/util/tools.dart';

class SetUserNameRequest {
  static Future<SetUsernameModel> setUserName(int userId, String token, String userName) async {
    String url = ApiConfig.baseUrl + "/user/setUserName";
    var response = await BaseRequest().toPost(
      url,
      parameters: {"userId": userId, "userName": userName},
      options: Options(headers: {PublicKeys.token: token}),
      isShowLoading: true,
    );
    SetUsernameModel scModel = SetUsernameModel.fromJson(response);

    // print(userInfoModel.data);
    return scModel;
  }
}

/// code : 0
/// msg : "操作成功"
/// data : null

class SetUsernameModel extends ResponseModel {
  SetUsernameModel({
    dynamic data,
  }) {
    _data = data;
  }

  SetUsernameModel.fromJson(dynamic json) {
    code = json['code'];
    msg = json['msg'];
    _data = json['data'];
  }

  dynamic _data;

  SetUsernameModel copyWith({
    dynamic data,
  }) =>
      SetUsernameModel(
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
