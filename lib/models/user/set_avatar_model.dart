import 'package:dio/dio.dart';
import 'package:pet_community/models/response_model.dart';
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

class SetAvatarModel extends ResponseModel {
  SetAvatarModel({
    dynamic data,
  }) {
    _data = data;
  }

  SetAvatarModel.fromJson(dynamic json) {
    code = json['code'];
    msg = json['msg'];
    _data = json['data'];
  }

  dynamic _data;

  SetAvatarModel copyWith({
    dynamic data,
  }) =>
      SetAvatarModel(
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
