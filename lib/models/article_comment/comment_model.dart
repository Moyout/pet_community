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
/// msg : "成功"
/// data : {"total":4,"articleComments":[{"commentId":20001,"commentContent":"好可爱的修勾","commentTime":"2022-06-26T03:05:16","articleId":31379,"userId":100029},{"commentId":20002,"commentContent":"可爱","commentTime":"2022-06-26T09:06:27","articleId":31379,"userId":100028},{"commentId":20003,"commentContent":"太可爱了吧","commentTime":"2022-06-26T08:07:12","articleId":31379,"userId":100028},{"commentId":20004,"commentContent":"带着小发卡太可爱了","commentTime":"2022-06-26T10:08:00","articleId":31379,"userId":100027}]}

class CommentModel extends ResponseModel {
  CommentModel({
    Data? data,
  }) {
    _data = data;
  }

  CommentModel.fromJson(dynamic json) {
    code = json['code'];
    msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Data? _data;

  CommentModel copyWith({
    Data? data,
  }) =>
      CommentModel(
        data: data ?? _data,
      );

  @override
  Data? get data => _data;

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['msg'] = msg;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// total : 4
/// articleComments : [{"commentId":20001,"commentContent":"好可爱的修勾","commentTime":"2022-06-26T03:05:16","articleId":31379,"userId":100029},{"commentId":20002,"commentContent":"可爱","commentTime":"2022-06-26T09:06:27","articleId":31379,"userId":100028},{"commentId":20003,"commentContent":"太可爱了吧","commentTime":"2022-06-26T08:07:12","articleId":31379,"userId":100028},{"commentId":20004,"commentContent":"带着小发卡太可爱了","commentTime":"2022-06-26T10:08:00","articleId":31379,"userId":100027}]

class Data {
  Data({
    required int total,
    required List<ArticleComments> articleComments,
  }) {
    _total = total;
    _articleComments = articleComments;
  }

  Data.fromJson(dynamic json) {
    _total = json['total'];
    if (json['articleComments'] != null) {
      _articleComments = [];
      json['articleComments'].forEach((v) {
        _articleComments.add(ArticleComments.fromJson(v));
      });
    }
  }

  late int _total;
  late List<ArticleComments> _articleComments;

  Data copyWith({
    required int total,
    required List<ArticleComments> articleComments,
  }) =>
      Data(
        total: total,
        articleComments: articleComments,
      );

  int get total => _total;

  List<ArticleComments> get articleComments => _articleComments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['articleComments'] = _articleComments.map((v) => v.toJson()).toList();
    return map;
  }
}

/// commentId : 20001
/// commentContent : "好可爱的修勾"
/// commentTime : "2022-06-26T03:05:16"
/// articleId : 31379
/// userId : 100029

class ArticleComments {
  ArticleComments({
    required int commentId,
    String? commentContent,
    String? commentTime,
    required int articleId,
    required int userId,
  }) {
    _commentId = commentId;
    _commentContent = commentContent;
    _commentTime = commentTime;
    _articleId = articleId;
    _userId = userId;
  }

  ArticleComments.fromJson(dynamic json) {
    _commentId = json['commentId'];
    _commentContent = json['commentContent'];
    _commentTime = json['commentTime'];
    _articleId = json['articleId'];
    _userId = json['userId'];
  }

  late int _commentId;
  String? _commentContent;
  String? _commentTime;
  late int _articleId;
  late int _userId;

  ArticleComments copyWith({
    required int commentId,
    String? commentContent,
    String? commentTime,
    required int articleId,
    required int userId,
  }) =>
      ArticleComments(
        commentId: commentId,
        commentContent: commentContent ?? _commentContent,
        commentTime: commentTime ?? _commentTime,
        articleId: articleId,
        userId: userId,
      );

  int get commentId => _commentId;

  String? get commentContent => _commentContent;

  String? get commentTime => _commentTime;

  int get articleId => _articleId;

  int get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['commentId'] = _commentId;
    map['commentContent'] = _commentContent;
    map['commentTime'] = _commentTime;
    map['articleId'] = _articleId;
    map['userId'] = _userId;
    return map;
  }
}
