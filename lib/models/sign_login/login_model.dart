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
/// data : {"userId":100017,"token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMDY3NjAwNjIzQHFxLmNvbSIsImV4cCI6MTY1MzcwMzgxNywiaW5mbyI6eyJ1c2VyTmFtZSI6IueUqOaItzEwMDAxNyIsInVzZXJJZCI6MTAwMDE3fX0.uwedRsGOXIcnFMyiElR67n7TCUg3Suu2uBAovXepn1c"}

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

/// userId : 100017
/// token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMDY3NjAwNjIzQHFxLmNvbSIsImV4cCI6MTY1MzcwMzgxNywiaW5mbyI6eyJ1c2VyTmFtZSI6IueUqOaItzEwMDAxNyIsInVzZXJJZCI6MTAwMDE3fX0.uwedRsGOXIcnFMyiElR67n7TCUg3Suu2uBAovXepn1c"

class Data {
  Data({
    int? userId,
    String? token,
  }) {
    _userId = userId;
    _token = token;
  }

  Data.fromJson(dynamic json) {
    _userId = json['userId'];
    _token = json['token'];
  }
  int? _userId;
  String? _token;
  Data copyWith({
    int? userId,
    String? token,
  }) =>
      Data(
        userId: userId ?? _userId,
        token: token ?? _token,
      );
  int? get userId => _userId;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['token'] = _token;
    return map;
  }
}
