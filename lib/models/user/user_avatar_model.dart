import 'package:pet_community/models/response_model.dart';
import 'package:pet_community/util/tools.dart';

class UserAvatarRequest {
  static Future<UserAvatarModel> getUserAvatar(int userId, String token) async {
    String url = ApiConfig.baseUrl + "/user/getUserAvatar/$userId";
    var response = await BaseRequest().toGet(url);
    UserAvatarModel scModel = UserAvatarModel.fromJson(response);
    // print(userInfoModel.data);
    return scModel;
  }
}

/// code : 0
/// msg : "成功"
/// data : "http://localhost:8081/images/100027/avatar/avatar9.png"

class UserAvatarModel extends ResponseModel {
  UserAvatarModel({
    String? data,
  }) {
    _data = data;
  }

  UserAvatarModel.fromJson(dynamic json) {
    code = json['code'];
    msg = json['msg'];
    _data = json['data'];
  }

  String? _data;

  UserAvatarModel copyWith({
    String? data,
  }) =>
      UserAvatarModel(
        data: data ?? _data,
      );

  @override
  String? get data => _data;

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['msg'] = msg;
    map['data'] = _data;
    return map;
  }
}
