import 'package:dio/dio.dart';
import 'package:pet_community/util/tools.dart';

class DeleteCommentRequest {
  static Future<DeleteCommentModel> deleteComment({
    required int commentId,
    required int userId,
    required String token,
  }) async {
    String url = ApiConfig.baseUrl + "/articleComment/deleteComment";
    var response = await BaseRequest().toPost(
      url,
      parameters: {
        "commentId": commentId,
        "userId": userId,
      },
      options: Options(headers: {PublicKeys.token: token}),
      isShowLoading: true,
    );
    DeleteCommentModel scModel = DeleteCommentModel.fromJson(response);

    return scModel;
  }
}

/// code : 0
/// msg : "删除成功"
/// data : null

class DeleteCommentModel {
  DeleteCommentModel({
    int? code,
    String? msg,
    dynamic data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  DeleteCommentModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['data'];
  }

  int? _code;
  String? _msg;
  dynamic _data;

  DeleteCommentModel copyWith({
    int? code,
    String? msg,
    dynamic data,
  }) =>
      DeleteCommentModel(
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
