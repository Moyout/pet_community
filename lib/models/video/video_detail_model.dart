import 'package:pet_community/models/response_model.dart';
import 'package:pet_community/models/user/user_info_model.dart';
import 'package:pet_community/util/tools.dart';

class VideoDetailRequest {
  static Future<VideoDetailModel> getVideoDetail({bool isShowLoading = true, required int videoId}) async {
    String url = ApiConfig.baseUrl + "/video/queryVideoDetail";
    var response = await BaseRequest().toPost(
      url,
      parameters: {"videoId": videoId},
      isShowLoading: isShowLoading,
    );
    VideoDetailModel scModel = VideoDetailModel.fromJson(response);

    // print(userInfoModel.data);
    return scModel;
  }
}

/// code : 0
/// msg : "成功"

class VideoDetailModel extends ResponseModel {
  VideoDetailModel({
    Data? data,
  }) {
    _data = data;
  }

  VideoDetailModel.fromJson(dynamic json) {
    code = json['code'];
    msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Data? _data;

  VideoDetailModel copyWith({
    Data? data,
  }) =>
      VideoDetailModel(
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
    required UserInfoModel userInfo,
    required Video video,
  }) {
    _userInfo = userInfo;
    _video = video;
  }

  @override
  String toString() {
    return 'Data{_userInfo: $_userInfo, _video: $_video}';
  }

  Data.fromJson(dynamic json) {
    _userInfo = UserInfoModel.fromJson(json['userInfo']);
    _video = Video.fromJson(json['video']);
  }

  late UserInfoModel _userInfo;
  late Video _video;

  Data copyWith({
    required UserInfoModel userInfo,
    required Video video,
  }) =>
      Data(
        userInfo: userInfo,
        video: video,
      );

  UserInfoModel get userInfo => _userInfo;

  Video get video => _video;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userInfo'] = _userInfo.toJson();
    map['video'] = _video.toJson();
    return map;
  }
}

class Video {
  Video({
    required int videoId,
    String? cover,
    String? title,
    String? content,
    required String video,
    required int likes,
    required String publicationTime,
    required int userId,
  }) {
    _videoId = videoId;
    _cover = cover;
    _title = title;
    _content = content;
    _video = video;
    _likes = likes;
    _publicationTime = publicationTime;
    _userId = userId;
  }

  @override
  String toString() {
    return 'Video{_videoId: $_videoId, _cover: $_cover, _title: $_title, _content: $_content, _video: $_video, _likes: $_likes, _publicationTime: $_publicationTime, _userId: $_userId}';
  }

  Video.fromJson(dynamic json) {
    _videoId = json['videoId'];
    _cover = json['cover'];
    _title = json['title'];
    _content = json['content'];
    _video = json['video'];
    _likes = json['likes'];
    _publicationTime = json['publicationTime'];
    _userId = json['userId'];
  }

  late int _videoId;
  String? _cover;
  String? _title;
  String? _content;
  late String _video;
  late int _likes;
  late String _publicationTime;
  late int _userId;

  Video copyWith({
    required int videoId,
    String? cover,
    String? title,
    String? content,
    required String video,
    required int likes,
    required String publicationTime,
    required int userId,
  }) =>
      Video(
        videoId: videoId,
        cover: cover ?? _cover,
        title: title ?? _title,
        content: content ?? _content,
        video: video,
        likes: likes,
        publicationTime: publicationTime,
        userId: userId,
      );

  int get videoId => _videoId;

  String? get cover => _cover;

  String? get title => _title;

  String? get content => _content;

  String get video => _video;

  int get likes => _likes;

  String get publicationTime => _publicationTime;

  int get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['videoId'] = _videoId;
    map['cover'] = _cover;
    map['title'] = _title;
    map['content'] = _content;
    map['video'] = _video;
    map['likes'] = _likes;
    map['publicationTime'] = _publicationTime;
    map['userId'] = _userId;
    return map;
  }
}
