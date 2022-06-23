import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:pet_community/util/tools.dart';

class UploadArticlePicRequest {
  static Future<ArticleModel> uploadArticlePic(int userId, String token, String filePath) async {
    String url = ApiConfig.baseUrl + "/upload/articlePictures";

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
    ArticleModel scModel = ArticleModel.fromJson(response);
    // if (scModel.code == 1007) {
    //   RouteUtil.push(AppUtils.getContext(), const SignLoginView(), animation: RouteAnimation.popDown);
    // }
    return scModel;
  }
}

/// code : 0
/// msg : "操作成功"
/// data : "http://localhost:8081/images/100018/article/avatar10.png"

class ArticleModel {
  ArticleModel({
    int? code,
    String? msg,
    String? data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  ArticleModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['data'];
  }
  int? _code;
  String? _msg;
  String? _data;
  ArticleModel copyWith({
    int? code,
    String? msg,
    String? data,
  }) =>
      ArticleModel(
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
