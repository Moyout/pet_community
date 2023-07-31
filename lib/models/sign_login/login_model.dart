import 'package:pet_community/models/response_model.dart';
import 'package:pet_community/util/tools.dart';

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
/// data : {"userId":100027,"email":"1067600623@qq.com","token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMDY3NjAwNjIzQHFxLmNvbSIsImV4cCI6MTY5MDg3OTQ3NiwiaW5mbyI6eyJsZXZlbCI6MiwidXNlck5hbWUiOiLnlKjmiLcyNzI3MjciLCJ1c2VySWQiOjEwMDAyNywiZW1haWwiOiIxMDY3NjAwNjIzQHFxLmNvbSJ9fQ.1WigqjiXkpuTDtwyMBuqn4ZTSKrZXxG-UZxpOHK1tBk"}

class LoginModel extends ResponseModel {
  LoginModel({
    Data? data,
  }) {
    _data = data;
  }

  LoginModel.fromJson(dynamic json) {
    code = json['code'];
    msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Data? _data;

  LoginModel copyWith({
    Data? data,
  }) =>
      LoginModel(
        data: data ?? _data,
      );

  @override
  Data? get data => _data;

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['msg'] = msg;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// userId : 100027
/// email : "1067600623@qq.com"
/// token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMDY3NjAwNjIzQHFxLmNvbSIsImV4cCI6MTY5MDg3OTQ3NiwiaW5mbyI6eyJsZXZlbCI6MiwidXNlck5hbWUiOiLnlKjmiLcyNzI3MjciLCJ1c2VySWQiOjEwMDAyNywiZW1haWwiOiIxMDY3NjAwNjIzQHFxLmNvbSJ9fQ.1WigqjiXkpuTDtwyMBuqn4ZTSKrZXxG-UZxpOHK1tBk"

class Data {
  Data({
    required int userId,
    String? email,
    required String token,
  }) {
    _userId = userId;
    _email = email;
    _token = token;
  }

  Data.fromJson(dynamic json) {
    _userId = json['userId'];
    _email = json['email'];
    _token = json['token'];
  }

  late int _userId;
  String? _email;
  late String _token;

  Data copyWith({
    required int userId,
    String? email,
    required String token,
  }) =>
      Data(
        userId: userId,
        email: email ?? _email,
        token: token,
      );

  int get userId => _userId;

  String? get email => _email;

  String get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['email'] = _email;
    map['token'] = _token;
    return map;
  }
}
