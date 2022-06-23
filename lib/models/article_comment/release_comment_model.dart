import 'package:dio/dio.dart';
import 'package:pet_community/util/tools.dart';

class ReleaseCommentRequest {
  static Future<ReleaseCommentModel> releaseComment({
    required String commentator,
    required String commentContent,
    required int articleId,
    required int userId,
    required String token,
  }) async {
    String url = ApiConfig.baseUrl + "/articleComment/releaseComment";
    var response = await BaseRequest().toPost(
      url,
      parameters: {
        "commentator": commentator,
        "commentContent": commentContent,
        "articleId": articleId,
        "userId": userId,
      },
      options: Options(headers: {PublicKeys.token: token}),
      isShowLoading: true,
    );
    ReleaseCommentModel scModel = ReleaseCommentModel.fromJson(response);

    return scModel;
  }
}

/// code : 0
/// msg : "评论成功"
/// data : {"commentId":1035}

class ReleaseCommentModel {
  ReleaseCommentModel({
    int? code,
    String? msg,
    Data? data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  ReleaseCommentModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? _code;
  String? _msg;
  Data? _data;
  ReleaseCommentModel copyWith({
    int? code,
    String? msg,
    Data? data,
  }) =>
      ReleaseCommentModel(
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

/// commentId : 1035

class Data {
  Data({
    int? commentId,
  }) {
    _commentId = commentId;
  }

  Data.fromJson(dynamic json) {
    _commentId = json['commentId'];
  }
  int? _commentId;
  Data copyWith({
    int? commentId,
  }) =>
      Data(
        commentId: commentId ?? _commentId,
      );
  int? get commentId => _commentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['commentId'] = _commentId;
    return map;
  }
}
