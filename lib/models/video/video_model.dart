import 'package:dio/dio.dart';
import 'package:pet_community/models/response_model.dart';
import 'package:pet_community/util/tools.dart';

class VideoRequest {
  static Future<VideoModel> getVideo({
    int page = 1,
    int count = 10,
    bool isShowLoading = true,
  }) async {
    String url = ApiConfig.baseUrl + "/video/queryPetVideo";
    var response = await BaseRequest().toGet(
      url,
      parameters: {"page": page, "count": count},
      isShowLoading: isShowLoading,
    );
    VideoModel scModel = VideoModel();
    if (response != null) scModel = VideoModel.fromJson(response);

    // print(userInfoModel.data);
    return scModel;
  }

  static Future<List<Videos>> getUserVideoList(
    int? userId, {
    int page = 1,
    int count = 20,
    bool isShowLoading = true,
  }) async {
    String url = ApiConfig.baseUrl + "/video/queryUserVideo";
    var response = await BaseRequest().toGet(
      url,
      parameters: {"page": page, "count": count, "userId": userId},
      isShowLoading: isShowLoading,
    );
    List<Videos> list = [];
    if (response != null) {
      (response["data"] as List).forEach((element) {
        var video = Videos.fromJson(element);
        list.add(video);
      });
    }
    debugPrint("list---------------------->${list}");
    return list;
  }

  static Future<bool> releaseVideo({
    required String? title,
    required String? content,
    required String? cover,
    required String? videoPath,
    required int? userId,
    required String? token,
  }) async {
    String url = ApiConfig.baseUrl + "/video/releasePetVideo";

    Map<String, dynamic>? dataMap = {
      "title": title,
      "content": content,
      "cover": cover,
      "video": videoPath,
      "userId": userId,
    };
    var response = await BaseRequest().toPost(
      url,
      parameters: dataMap,
      options: Options(headers: {PublicKeys.token: token}),
      isShowLoading: true,
    );

    // ReleaseArticleModel scModel = ReleaseArticleModel.fromJson(response);
    // return scModel;
    return response['code'] == 0;
  }
}

class VideoModel extends ResponseModel {
  VideoModel({
    Data? data,
  }) {
    _data = data;
  }

  VideoModel.fromJson(dynamic json) {
    code = json['code'];
    msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Data? _data;

  VideoModel copyWith({
    Data? data,
  }) =>
      VideoModel(
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
    required List<Videos> videos,
  }) {
    _total = total;
    _videos = videos;
  }

  Data.fromJson(dynamic json) {
    _total = json['total'];
    if (json['videos'] != null) {
      _videos = [];
      json['videos'].forEach((v) {
        _videos.add(Videos.fromJson(v));
      });
    }
  }

  late int _total;
  late List<Videos> _videos;

  Data copyWith({
    required int total,
    required List<Videos> videos,
  }) =>
      Data(
        total: total,
        videos: videos,
      );

  int get total => _total;

  List<Videos> get videos => _videos;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['videos'] = _videos.map((v) => v.toJson()).toList();
    return map;
  }
}

class Videos {
  Videos({
    required int videoId,
    String? cover,
    String? title,
    String? content,
    String? video,
    required int likes,
    String? publicationTime,
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

  Videos.fromJson(dynamic json) {
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
  String? _video;
  late int _likes;
  String? _publicationTime;
  late int _userId;

  Videos copyWith({
    required int videoId,
    String? cover,
    String? title,
    String? content,
    String? video,
    required int likes,
    String? publicationTime,
    required int userId,
  }) =>
      Videos(
        videoId: videoId,
        cover: cover ?? _cover,
        title: title ?? _title,
        content: content ?? _content,
        video: video ?? _video,
        likes: likes,
        publicationTime: publicationTime ?? _publicationTime,
        userId: userId,
      );

  int get videoId => _videoId;

  String? get cover => _cover;

  String? get title => _title;

  String? get content => _content;

  String? get video => _video;

  int get likes => _likes;

  String? get publicationTime => _publicationTime;

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
