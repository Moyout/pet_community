import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:pet_community/util/tools.dart';

class UploadBackgroundRequest {
  static Future<BackgroundModel> uploadBackground(int userId, String token, String filePath) async {
    String url = ApiConfig.baseUrl + "/upload/backgroundPicture";

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
    BackgroundModel scModel = BackgroundModel.fromJson(response);

    return scModel;
  }
}

/// code : 0
/// msg : "成功"
/// data : "http://localhost:8081/images/100018/background/pet8.jpg"

class BackgroundModel {
  BackgroundModel({
    int? code,
    String? msg,
    String? data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  BackgroundModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['data'];
  }

  int? _code;
  String? _msg;
  String? _data;

  BackgroundModel copyWith({
    int? code,
    String? msg,
    String? data,
  }) =>
      BackgroundModel(
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
