import 'package:dio/dio.dart';
import 'package:pet_community/util/toast_util.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';
import 'package:pet_community/view_models/sign_login/sign_login_viewmodel.dart';
import 'package:pet_community/views/sign_login/sign_login_view.dart';

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
    if (scModel.code == 0) {
      SpUtil.putObject("UserInfoModel", scModel);
      AppUtils.getContext().read<NavViewModel>().userInfoModel = scModel;
      AppUtils.getContext().read<NavViewModel>().notifyListeners();
    } else if (scModel.code == 1007) {
      SpUtil.remove("UserInfoModel");
      ToastUtil.showBottomToast(scModel.msg!);
      AppUtils.getContext().read<NavViewModel>().isLogin = false;
      SpUtil.setBool(PublicKeys.isLogin, false);
      AppUtils.getContext().read<NavViewModel>().userInfoModel = UserInfoModel();
      AppUtils.getContext().read<NavViewModel>().notifyListeners();
      Future.delayed(const Duration(milliseconds: 500), () {
        AppUtils.getContext().read<SignLoginViewModel>().initialPage = 1;
        RouteUtil.pushReplacement(AppUtils.getContext(), const SignLoginView());
      });
    }

    // print(userInfoModel.data);
    return scModel;
  }
}

/// code : 0
/// msg : "操作成功"
/// data : {"userId":100018,"userName":"吴绮诗a","avatar":"http://106.52.246.134:8081/images/100018/avatar/image_cropper_1653287231038.jpg","phone":null,"background":null,"email":"1067600623@qq.com","sex":"女","signature":"很懒aa😂👿😉😡😘😘","area":"广东省"}

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

/// userId : 100018
/// userName : "吴绮诗a"
/// avatar : "http://106.52.246.134:8081/images/100018/avatar/image_cropper_1653287231038.jpg"
/// phone : null
/// background : null
/// email : "1067600623@qq.com"
/// sex : "女"
/// signature : "很懒aa😂👿😉😡😘😘"
/// area : "广东省"

class Data {
  Data({
    int? userId,
    String? userName,
    String? avatar,
    dynamic phone,
    dynamic background,
    String? email,
    String? sex,
    String? signature,
    String? area,
  }) {
    _userId = userId;
    _userName = userName;
    _avatar = avatar;
    _phone = phone;
    _background = background;
    _email = email;
    _sex = sex;
    _signature = signature;
    _area = area;
  }

  Data.fromJson(dynamic json) {
    _userId = json['userId'];
    _userName = json['userName'];
    _avatar = json['avatar'];
    _phone = json['phone'];
    _background = json['background'];
    _email = json['email'];
    _sex = json['sex'];
    _signature = json['signature'];
    _area = json['area'];
  }

  int? _userId;
  String? _userName;
  String? _avatar;
  dynamic _phone;
  dynamic _background;
  String? _email;
  String? _sex;
  String? _signature;
  String? _area;

  Data copyWith({
    int? userId,
    String? userName,
    String? avatar,
    dynamic phone,
    dynamic background,
    String? email,
    String? sex,
    String? signature,
    String? area,
  }) =>
      Data(
        userId: userId ?? _userId,
        userName: userName ?? _userName,
        avatar: avatar ?? _avatar,
        phone: phone ?? _phone,
        background: background ?? _background,
        email: email ?? _email,
        sex: sex ?? _sex,
        signature: signature ?? _signature,
        area: area ?? _area,
      );

  int? get userId => _userId;

  String? get userName => _userName;

  String? get avatar => _avatar;

  dynamic get phone => _phone;

  dynamic get background => _background;

  String? get email => _email;

  String? get sex => _sex;

  String? get signature => _signature;

  String? get area => _area;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['userName'] = _userName;
    map['avatar'] = _avatar;
    map['phone'] = _phone;
    map['background'] = _background;
    map['email'] = _email;
    map['sex'] = _sex;
    map['signature'] = _signature;
    map['area'] = _area;
    return map;
  }
}
