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
}

/// code : 0
/// msg : "成功"
/// data : {"total":2,"videos":[{"videoId":10023,"cover":"http://localhost:8081/images/100027/petVideoCover/2693a96a81a3461691a517452ca744da.png","title":"标题","content":"今天带着多多跑楼顶耍了，随后又带着去打了疫苗，只希望你健健康康的","video":"http://localhost:8081/images/100027/petVideo/2693a96a81a3461691a517452ca744da.mp4","likes":7,"publicationTime":"2023-07-29T19:19:11","userId":100027},{"videoId":10025,"cover":"http://localhost:8081/images/100029/petVideoCover/6c6d0be14ed2e7502d2638d0a93d69b6.png","title":"title2","content":"像不像你女朋友生气时候的样子😂2","video":"http://localhost:8081/images/100029/petVideo/6c6d0be14ed2e7502d2638d0a93d69b6.mp4","likes":30,"publicationTime":"2023-07-29T21:42:30","userId":100029}]}

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

/// total : 2
/// videos : [{"videoId":10023,"cover":"http://localhost:8081/images/100027/petVideoCover/2693a96a81a3461691a517452ca744da.png","title":"标题","content":"今天带着多多跑楼顶耍了，随后又带着去打了疫苗，只希望你健健康康的","video":"http://localhost:8081/images/100027/petVideo/2693a96a81a3461691a517452ca744da.mp4","likes":7,"publicationTime":"2023-07-29T19:19:11","userId":100027},{"videoId":10025,"cover":"http://localhost:8081/images/100029/petVideoCover/6c6d0be14ed2e7502d2638d0a93d69b6.png","title":"title2","content":"像不像你女朋友生气时候的样子😂2","video":"http://localhost:8081/images/100029/petVideo/6c6d0be14ed2e7502d2638d0a93d69b6.mp4","likes":30,"publicationTime":"2023-07-29T21:42:30","userId":100029}]

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

/// videoId : 10023
/// cover : "http://localhost:8081/images/100027/petVideoCover/2693a96a81a3461691a517452ca744da.png"
/// title : "标题"
/// content : "今天带着多多跑楼顶耍了，随后又带着去打了疫苗，只希望你健健康康的"
/// video : "http://localhost:8081/images/100027/petVideo/2693a96a81a3461691a517452ca744da.mp4"
/// likes : 7
/// publicationTime : "2023-07-29T19:19:11"
/// userId : 100027

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
