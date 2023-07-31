import 'package:dio/dio.dart';
import 'package:pet_community/models/response_model.dart';
import 'package:pet_community/util/tools.dart';

class SetSignatureRequest {
  static Future<SetSignatureModel> setUserSignature(int userId, String token, String signature) async {
    String url = ApiConfig.baseUrl + "/user/setUserSignature";
    var response = await BaseRequest().toPost(
      url,
      parameters: {"userId": userId, "signature": signature},
      options: Options(headers: {PublicKeys.token: token}),
      isShowLoading: true,
    );
    SetSignatureModel scModel = SetSignatureModel.fromJson(response);
    // print(userInfoModel.data);
    return scModel;
  }
}

/// code : 0
/// msg : "操作成功"
/// data : null

class SetSignatureModel extends ResponseModel {
  SetSignatureModel({
    dynamic data,
  }) {
    _data = data;
  }

  SetSignatureModel.fromJson(dynamic json) {
    code = json['code'];
    msg = json['msg'];
    _data = json['data'];
  }

  dynamic _data;

  SetSignatureModel copyWith({
    dynamic data,
  }) =>
      SetSignatureModel(
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
