import 'package:dio/dio.dart';
import 'package:pet_community/util/tools.dart';

class ReleaseArticleRequest {
  static Future<ReleaseArticleModel> releaseArticle({
    required String author,
    required String title,
    required String content,
    required String cover,
    required String? pictures,
    required int userId,
    required String token,
  }) async {
    String url = ApiConfig.baseUrl + "/article/create";

    Map<String, dynamic>? dataMap = {
      "author": author,
      "title": title,
      "content": content,
      "cover": cover,
      // "pictures": pictures,
      "userId": userId,
    };
    if (pictures != null) {
      dataMap.addAll({"pictures": pictures});
    }
    var response = await BaseRequest().toPost(
      url,
      parameters: dataMap,
      options: Options(headers: {PublicKeys.token: token}),
      isShowLoading: true,
    );
    ReleaseArticleModel scModel = ReleaseArticleModel.fromJson(response);
    return scModel;
  }
}

/// code : 0
/// msg : "发布成功"
/// data : null

class ReleaseArticleModel {
  ReleaseArticleModel({
    int? code,
    String? msg,
    dynamic data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  ReleaseArticleModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['data'];
  }

  int? _code;
  String? _msg;
  dynamic _data;

  ReleaseArticleModel copyWith({
    int? code,
    String? msg,
    dynamic data,
  }) =>
      ReleaseArticleModel(
        code: code ?? _code,
        msg: msg ?? _msg,
        data: data ?? _data,
      );

  int? get code => _code;

  String? get msg => _msg;

  dynamic get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    map['data'] = _data;
    return map;
  }
}
