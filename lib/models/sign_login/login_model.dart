import 'package:pet_community/common/http/base_request.dart';
import 'package:pet_community/config/api_config.dart';

class LoginRequest {
  static Future<LoginModel> loginAccount(String email, String password) async {
    String url = ApiConfig.baseUrl + "/user/login";
    var response = await BaseRequest().toPost(
      url,
      parameters: {"email": email, "password": password},
      isShowLoading: true,
    );
    LoginModel scModel = LoginModel.fromJson(response);
    return scModel;
  }
}

/// code : 200
/// msg : "账号登录成功"
/// data : {"userInfo":{"phone":"","signature":"这个人很懒，什么都没留下","sex":"保密","avatar":"","userName":"用户100017","userId":100017,"email":"1067600623@qq.com"},"token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMDY3NjAwNjIzQHFxLmNvbSIsImV4cCI6MTY1MzY2Njc2NiwiaW5mbyI6eyJwaG9uZSI6IiIsInNpZ25hdHVyZSI6Iui_meS4quS6uuW-iOaHku-8jOS7gOS5iOmDveayoeeVmeS4iyIsInNleCI6IuS_neWvhiIsImF2YXRhciI6IiIsInVzZXJOYW1lIjoi55So5oi3MTAwMDE3IiwidXNlcklkIjoxMDAwMTcsImVtYWlsIjoiMTA2NzYwMDYyM0BxcS5jb20ifX0.JFhlMELkmMcsUiR2f7o0AW2jA1-WK0DYvrrdYyObVpc"}

class LoginModel {
  LoginModel({
    int? code,
    String? msg,
    Data? data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  LoginModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? _code;
  String? _msg;
  Data? _data;
  LoginModel copyWith({
    int? code,
    String? msg,
    Data? data,
  }) =>
      LoginModel(
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

/// userInfo : {"phone":"","signature":"这个人很懒，什么都没留下","sex":"保密","avatar":"","userName":"用户100017","userId":100017,"email":"1067600623@qq.com"}
/// token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMDY3NjAwNjIzQHFxLmNvbSIsImV4cCI6MTY1MzY2Njc2NiwiaW5mbyI6eyJwaG9uZSI6IiIsInNpZ25hdHVyZSI6Iui_meS4quS6uuW-iOaHku-8jOS7gOS5iOmDveayoeeVmeS4iyIsInNleCI6IuS_neWvhiIsImF2YXRhciI6IiIsInVzZXJOYW1lIjoi55So5oi3MTAwMDE3IiwidXNlcklkIjoxMDAwMTcsImVtYWlsIjoiMTA2NzYwMDYyM0BxcS5jb20ifX0.JFhlMELkmMcsUiR2f7o0AW2jA1-WK0DYvrrdYyObVpc"

class Data {
  Data({
    UserInfo? userInfo,
    String? token,
  }) {
    _userInfo = userInfo;
    _token = token;
  }

  Data.fromJson(dynamic json) {
    _userInfo = json['userInfo'] != null ? UserInfo.fromJson(json['userInfo']) : null;
    _token = json['token'];
  }
  UserInfo? _userInfo;
  String? _token;
  Data copyWith({
    UserInfo? userInfo,
    String? token,
  }) =>
      Data(
        userInfo: userInfo ?? _userInfo,
        token: token ?? _token,
      );
  UserInfo? get userInfo => _userInfo;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_userInfo != null) {
      map['userInfo'] = _userInfo?.toJson();
    }
    map['token'] = _token;
    return map;
  }
}

/// phone : ""
/// signature : "这个人很懒，什么都没留下"
/// sex : "保密"
/// avatar : ""
/// userName : "用户100017"
/// userId : 100017
/// email : "1067600623@qq.com"

class UserInfo {
  UserInfo({
    String? phone,
    String? signature,
    String? sex,
    String? avatar,
    String? userName,
    int? userId,
    String? email,
  }) {
    _phone = phone;
    _signature = signature;
    _sex = sex;
    _avatar = avatar;
    _userName = userName;
    _userId = userId;
    _email = email;
  }

  UserInfo.fromJson(dynamic json) {
    _phone = json['phone'];
    _signature = json['signature'];
    _sex = json['sex'];
    _avatar = json['avatar'];
    _userName = json['userName'];
    _userId = json['userId'];
    _email = json['email'];
  }
  String? _phone;
  String? _signature;
  String? _sex;
  String? _avatar;
  String? _userName;
  int? _userId;
  String? _email;
  UserInfo copyWith({
    String? phone,
    String? signature,
    String? sex,
    String? avatar,
    String? userName,
    int? userId,
    String? email,
  }) =>
      UserInfo(
        phone: phone ?? _phone,
        signature: signature ?? _signature,
        sex: sex ?? _sex,
        avatar: avatar ?? _avatar,
        userName: userName ?? _userName,
        userId: userId ?? _userId,
        email: email ?? _email,
      );
  String? get phone => _phone;
  String? get signature => _signature;
  String? get sex => _sex;
  String? get avatar => _avatar;
  String? get userName => _userName;
  int? get userId => _userId;
  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone'] = _phone;
    map['signature'] = _signature;
    map['sex'] = _sex;
    map['avatar'] = _avatar;
    map['userName'] = _userName;
    map['userId'] = _userId;
    map['email'] = _email;
    return map;
  }
}
