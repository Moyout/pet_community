import 'package:dio/dio.dart';
import 'package:pet_community/common/http/base_request.dart';
import 'package:pet_community/common/public_keys.dart';
import 'package:pet_community/config/api_config.dart';
import 'package:pet_community/util/sp_util.dart';

class UserInfoRequest {
  static Future<UserInfoModel> getUserInfo(int userId, String token) async {
    String url = ApiConfig.baseUrl + "/user/getUserInfo";
    var response = await BaseRequest().toPost(
      url,
      parameters: {"userId": userId},
      options: Options(headers: {PublicKeys.token: token}),
      isShowLoading: true,
    );
    UserInfoModel scModel = UserInfoModel.fromJson(response);
    SpUtil.putObject("UserInfoModel", scModel);

    // print(userInfoModel.data);
    return scModel;
  }
}

/// code : 0
/// msg : "操作成功"
/// data : {"userId":100017,"userName":"用户100017","avatar":"","phone":"","email":"1067600623@qq.com","sex":"保密","signature":"这个人很懒，什么都没留下"}

class UserInfoModel {
  UserInfoModel({
    int? code,
    String? msg,
    Data? data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  UserInfoModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  int? _code;
  String? _msg;
  Data? _data;

  UserInfoModel copyWith({
    int? code,
    String? msg,
    Data? data,
  }) =>
      UserInfoModel(
        code: code ?? _code,
        msg: msg ?? _msg,
        data: data ?? _data,
      );

  int? get code => _code;

  String? get msg => _msg;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// userId : 100017
/// userName : "用户100017"
/// avatar : ""
/// phone : ""
/// email : "1067600623@qq.com"
/// sex : "保密"
/// signature : "这个人很懒，什么都没留下"

class Data {
  Data({
    int? userId,
    String? userName,
    String? avatar,
    String? phone,
    String? email,
    String? sex,
    String? signature,
  }) {
    _userId = userId;
    _userName = userName;
    _avatar = avatar;
    _phone = phone;
    _email = email;
    _sex = sex;
    _signature = signature;
  }

  Data.fromJson(dynamic json) {
    _userId = json['userId'];
    _userName = json['userName'];
    _avatar = json['avatar'];
    _phone = json['phone'];
    _email = json['email'];
    _sex = json['sex'];
    _signature = json['signature'];
  }

  int? _userId;
  String? _userName;
  String? _avatar;
  String? _phone;
  String? _email;
  String? _sex;
  String? _signature;

  Data copyWith({
    int? userId,
    String? userName,
    String? avatar,
    String? phone,
    String? email,
    String? sex,
    String? signature,
  }) =>
      Data(
        userId: userId ?? _userId,
        userName: userName ?? _userName,
        avatar: avatar ?? _avatar,
        phone: phone ?? _phone,
        email: email ?? _email,
        sex: sex ?? _sex,
        signature: signature ?? _signature,
      );

  int? get userId => _userId;

  String? get userName => _userName;

  String? get avatar => _avatar;

  String? get phone => _phone;

  String? get email => _email;

  String? get sex => _sex;

  String? get signature => _signature;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['userName'] = _userName;
    map['avatar'] = _avatar;
    map['phone'] = _phone;
    map['email'] = _email;
    map['sex'] = _sex;
    map['signature'] = _signature;
    return map;
  }
}
