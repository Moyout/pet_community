import 'package:pet_community/models/response_model.dart';
import 'package:pet_community/util/tools.dart';

class CommentRequest {
  static Future<CommentModel> getComment({required int articleId, int page = 1, int count = 5}) async {
    String url = ApiConfig.baseUrl + "/articleComment/queryComment";
    var response = await BaseRequest().toGet(
      url,
      parameters: {
        "page": page,
        "count": count,
        "articleId": articleId,
      },
      isShowLoading: true,
    );
    CommentModel scModel = CommentModel.fromJson(response);

    return scModel;
  }
}

/// code : 0
/// msg : "操作成功"
/// data : [{"commentId":1001,"commentator":"陌友2","avatar":null,"commentContent":"这是一条评论内容","commentTime":"2022-04-29T20:54:04","articleId":31269,"userId":100018}]

class CommentModel extends ResponseModel {
  CommentModel({
    List<Data>? data,
  }) {
    _data = data;
  }

  CommentModel.fromJson(dynamic json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  List<Data>? _data;

  CommentModel copyWith({
    List<Data>? data,
  }) =>
      CommentModel(
        data: data ?? _data,
      );

  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['msg'] = msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// commentId : 1001
/// commentator : "陌友2"
/// avatar : null
/// commentContent : "这是一条评论内容"
/// commentTime : "2022-04-29T20:54:04"
/// articleId : 31269
/// userId : 100018

class Data {
  Data({
    int? commentId,
    String? commentator,
    dynamic avatar,
    String? commentContent,
    String? commentTime,
    int? articleId,
    int? userId,
  }) {
    _commentId = commentId;
    _commentator = commentator;
    _avatar = avatar;
    _commentContent = commentContent;
    _commentTime = commentTime;
    _articleId = articleId;
    _userId = userId;
  }

  Data.fromJson(dynamic json) {
    _commentId = json['commentId'];
    _commentator = json['commentator'];
    _avatar = json['avatar'];
    _commentContent = json['commentContent'];
    _commentTime = json['commentTime'];
    _articleId = json['articleId'];
    _userId = json['userId'];
  }

  int? _commentId;
  String? _commentator;
  dynamic _avatar;
  String? _commentContent;
  String? _commentTime;
  int? _articleId;
  int? _userId;

  Data copyWith({
    int? commentId,
    String? commentator,
    dynamic avatar,
    String? commentContent,
    String? commentTime,
    int? articleId,
    int? userId,
  }) =>
      Data(
        commentId: commentId ?? _commentId,
        commentator: commentator ?? _commentator,
        avatar: avatar ?? _avatar,
        commentContent: commentContent ?? _commentContent,
        commentTime: commentTime ?? _commentTime,
        articleId: articleId ?? _articleId,
        userId: userId ?? _userId,
      );

  int? get commentId => _commentId;

  String? get commentator => _commentator;

  dynamic get avatar => _avatar;

  String? get commentContent => _commentContent;

  String? get commentTime => _commentTime;

  int? get articleId => _articleId;

  int? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['commentId'] = _commentId;
    map['commentator'] = _commentator;
    map['avatar'] = _avatar;
    map['commentContent'] = _commentContent;
    map['commentTime'] = _commentTime;
    map['articleId'] = _articleId;
    map['userId'] = _userId;
    return map;
  }
}
