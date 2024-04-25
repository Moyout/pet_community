import 'package:dio/dio.dart';
import 'package:pet_community/models/article_comment/release_comment_model.dart';
import 'package:pet_community/models/response_model.dart';
import 'package:pet_community/util/tools.dart';

class VideoCommentRequest {
  static Future<VideoCommentModel> getComment({required int? videoId, int page = 1, int count = 10}) async {
    String url = ApiConfig.baseUrl + "/videoComment/queryComment";
    var response = await BaseRequest().toGet(
      url,
      parameters: {
        "page": page,
        "count": count,
        "videoId": videoId,
      },
      isShowLoading: true,
    );
    VideoCommentModel scModel = VideoCommentModel.fromJson(response);

    return scModel;
  }

  // static Future<DeleteCommentModel> deleteComment({
  //   required int commentId,
  //   required int userId,
  //   required String token,
  // }) async {
  //   String url = ApiConfig.baseUrl + "/articleComment/deleteComment";
  //   var response = await BaseRequest().toPost(
  //     url,
  //     parameters: {
  //       "commentId": commentId,
  //       "userId": userId,
  //     },
  //     options: Options(headers: {PublicKeys.token: token}),
  //     isShowLoading: true,
  //   );
  //   DeleteCommentModel scModel = DeleteCommentModel.fromJson(response);
  //
  //   return scModel;
  // }

  static Future<ReleaseCommentModel> releaseComment({
    required String commentContent,
    required int? videoId,
    required int? userId,
    required String? token,
  }) async {
    String url = ApiConfig.baseUrl + "/videoComment/releaseComment";
    var response = await BaseRequest().toPost(
      url,
      parameters: {
        "commentContent": commentContent,
        "videoId": videoId,
        "userId": userId,
      },
      options: Options(headers: {PublicKeys.token: token}),
      isShowLoading: true,
    );
    ReleaseCommentModel scModel = ReleaseCommentModel.fromJson(response);

    return scModel;
  }
}

class VideoCommentModel extends ResponseModel {
  VideoCommentModel({
    Data? data,
  }) {
    _data = data;
  }

  VideoCommentModel.fromJson(dynamic json) {
    code = json['code'];
    msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Data? _data;

  VideoCommentModel copyWith({
    Data? data,
  }) =>
      VideoCommentModel(
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

class Data {
  Data({
    required int total,
    required List<VideoComments> videoComments,
  }) {
    _total = total;
    _videoComments = videoComments;
  }

  Data.fromJson(dynamic json) {
    _total = json['total'];
    if (json['videoComments'] != null) {
      _videoComments = [];
      json['videoComments'].forEach((v) {
        _videoComments.add(VideoComments.fromJson(v));
      });
    }
  }

  late int _total;
  late List<VideoComments> _videoComments;

  Data copyWith({
    required int total,
    required List<VideoComments> videoComments,
  }) =>
      Data(
        total: total,
        videoComments: videoComments,
      );

  int get total => _total;

  List<VideoComments> get videoComments => _videoComments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['videoComments'] = _videoComments.map((v) => v.toJson()).toList();
    return map;
  }
}

class VideoComments {
  VideoComments({
    required int commentId,
    String? commentContent,
    String? commentTime,
    required int videoId,
    required int userId,
  }) {
    _commentId = commentId;
    _commentContent = commentContent;
    _commentTime = commentTime;
    _videoId = videoId;
    _userId = userId;
  }

  VideoComments.fromJson(dynamic json) {
    _commentId = json['commentId'];
    _commentContent = json['commentContent'];
    _commentTime = json['commentTime'];
    _videoId = json['videoId'];
    _userId = json['userId'];
  }

  late int _commentId;
  String? _commentContent;
  String? _commentTime;
  late int _videoId;
  late int _userId;

  VideoComments copyWith({
    required int commentId,
    String? commentContent,
    String? commentTime,
    required int videoId,
    required int userId,
  }) =>
      VideoComments(
        commentId: commentId,
        commentContent: commentContent ?? _commentContent,
        commentTime: commentTime ?? _commentTime,
        videoId: videoId,
        userId: userId,
      );

  int get commentId => _commentId;

  String? get commentContent => _commentContent;

  String? get commentTime => _commentTime;

  int get videoId => _videoId;

  int get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['commentId'] = _commentId;
    map['commentContent'] = _commentContent;
    map['commentTime'] = _commentTime;
    map['videoId'] = _videoId;
    map['userId'] = _userId;
    return map;
  }
}
