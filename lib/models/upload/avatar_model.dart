import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:pet_community/util/tools.dart';

class UploadAvatarRequest {
  static Future<AvatarModel> uploadAvatar(int userId, String token, String filePath) async {
    String url = ApiConfig.baseUrl + "/upload/avatarPicture";

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        filePath,
        contentType: MediaType("image", "jpeg"),
      ),
    });

    var response = await BaseRequest().toPost(
      url,
      parameters: {"userId": userId},
      options: Options(
        headers: {PublicKeys.token: token},
        contentType: "multipart/form-data",
      ),
      data: formData,
      isShowLoading: true,
    );
    AvatarModel scModel = AvatarModel.fromJson(response);

    return scModel;
  }
}

/// code : 0
/// msg : "操作成功"
/// data : "http://106.52.246.134:8081/images/100018/avatar/pet15.jpg"

class AvatarModel {
  AvatarModel({
    int? code,
    String? msg,
    String? data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  AvatarModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['data'];
  }

  int? _code;
  String? _msg;
  String? _data;

  AvatarModel copyWith({
    int? code,
    String? msg,
    String? data,
  }) =>
      AvatarModel(
        code: code ?? _code,
        msg: msg ?? _msg,
        data: data ?? _data,
      );

  int? get code => _code;

  String? get msg => _msg;

  String? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    map['data'] = _data;
    return map;
  }
}
