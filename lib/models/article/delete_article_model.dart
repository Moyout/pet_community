import 'package:dio/dio.dart';
import 'package:pet_community/util/tools.dart';

class DeleteArticleRequest {
  static Future<DeleteArticleModel> deleteArticle({
    required int articleId,
    required int userId,
    required String token,
  }) async {
    String url = ApiConfig.baseUrl + "/article/deleteUserArticle";
    var response = await BaseRequest().toPost(
      url,
      parameters: {
        "articleId": articleId,
        "userId": userId,
      },
      options: Options(headers: {PublicKeys.token: token}),
      isShowLoading: true,
    );
    DeleteArticleModel scModel = DeleteArticleModel.fromJson(response);

    return scModel;
  }
}

/// code : 1007
/// msg : "会话已过期,请重新登录"
/// data : null

class DeleteArticleModel {
  DeleteArticleModel({
    int? code,
    String? msg,
    dynamic data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  DeleteArticleModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['data'];
  }

  int? _code;
  String? _msg;
  dynamic _data;

  DeleteArticleModel copyWith({
    int? code,
    String? msg,
    dynamic data,
  }) =>
      DeleteArticleModel(
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
