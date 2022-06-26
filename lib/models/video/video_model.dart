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
    VideoModel scModel = VideoModel.fromJson(response);

    // print(userInfoModel.data);
    return scModel;
  }
}

/// code : 0
/// msg : "成功"
/// data : [{"videoId":10002,"userName":"qwe","avatar":"http://106.52.246.134:8081/images/100018/avatar/image_cropper_1655747662535.jpg","cover":"http://106.52.246.134:8081/images/100018/petVideoCover/4e8187dde9424a568a2965760d3b980b.png","title":"title","content":"content","video":"http://106.52.246.134:8081/images/100018/petVideo/4e8187dde9424a568a2965760d3b980b.mp4","likes":0,"publicationTime":"2022-06-22T17:06:40","userId":100018},{"videoId":10003,"userName":"qwe","avatar":"http://106.52.246.134:8081/images/100018/avatar/image_cropper_1655747662535.jpg","cover":"http://106.52.246.134:8081/images/100018/petVideoCover/2693a96a81a3461691a517452ca744da.png","title":"title","content":"content","video":"http://106.52.246.134:8081/images/100018/petVideo/2693a96a81a3461691a517452ca744da.mp4","likes":0,"publicationTime":"2022-06-22T17:08:48","userId":100018},{"videoId":10004,"userName":"qwe","avatar":"http://106.52.246.134:8081/images/100018/avatar/image_cropper_1655747662535.jpg","cover":"http://106.52.246.134:8081/images/100018/petVideoCover/d12fc3d91dd942e0872d982e63be3ba4.png","title":"title","content":"content","video":"http://106.52.246.134:8081/images/100018/petVideo/d12fc3d91dd942e0872d982e63be3ba4.mp4","likes":0,"publicationTime":"2022-06-22T17:09:11","userId":100018},{"videoId":10014,"userName":"qwe","avatar":"http://106.52.246.134:8081/images/100018/avatar/image_cropper_1655747662535.jpg","cover":"http://106.52.246.134:8081/images/100018/petVideoCover/4e8187dde9424a568a2965760d3b980b.png","title":"title","content":"content","video":"http://106.52.246.134:8081/images/100018/petVideo/4e8187dde9424a568a2965760d3b980b.mp4","likes":0,"publicationTime":"2022-06-22T17:06:40","userId":100018},{"videoId":10015,"userName":"qwe","avatar":"http://106.52.246.134:8081/images/100018/avatar/image_cropper_1655747662535.jpg","cover":"http://106.52.246.134:8081/images/100018/petVideoCover/2693a96a81a3461691a517452ca744da.png","title":"title","content":"content","video":"http://106.52.246.134:8081/images/100018/petVideo/2693a96a81a3461691a517452ca744da.mp4","likes":0,"publicationTime":"2022-06-22T17:08:48","userId":100018}]

class VideoModel {
  VideoModel({
    int? code,
    String? msg,
    List<Data>? data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  VideoModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  int? _code;
  String? _msg;
  List<Data>? _data;

  VideoModel copyWith({
    int? code,
    String? msg,
    List<Data>? data,
  }) =>
      VideoModel(
        code: code ?? _code,
        msg: msg ?? _msg,
        data: data ?? _data,
      );

  int? get code => _code;

  String? get msg => _msg;

  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// videoId : 10002
/// userName : "qwe"
/// avatar : "http://106.52.246.134:8081/images/100018/avatar/image_cropper_1655747662535.jpg"
/// cover : "http://106.52.246.134:8081/images/100018/petVideoCover/4e8187dde9424a568a2965760d3b980b.png"
/// title : "title"
/// content : "content"
/// video : "http://106.52.246.134:8081/images/100018/petVideo/4e8187dde9424a568a2965760d3b980b.mp4"
/// likes : 0
/// publicationTime : "2022-06-22T17:06:40"
/// userId : 100018

class Data {
  Data({
    int? videoId,
    String? userName,
    String? avatar,
    String? cover,
    String? title,
    String? content,
    String? video,
    int? likes,
    String? publicationTime,
    int? userId,
  }) {
    _videoId = videoId;
    _userName = userName;
    _avatar = avatar;
    _cover = cover;
    _title = title;
    _content = content;
    _video = video;
    _likes = likes;
    _publicationTime = publicationTime;
    _userId = userId;
  }

  Data.fromJson(dynamic json) {
    _videoId = json['videoId'];
    _userName = json['userName'];
    _avatar = json['avatar'];
    _cover = json['cover'];
    _title = json['title'];
    _content = json['content'];
    _video = json['video'];
    _likes = json['likes'];
    _publicationTime = json['publicationTime'];
    _userId = json['userId'];
  }

  int? _videoId;
  String? _userName;
  String? _avatar;
  String? _cover;
  String? _title;
  String? _content;
  String? _video;
  int? _likes;
  String? _publicationTime;
  int? _userId;

  Data copyWith({
    int? videoId,
    String? userName,
    String? avatar,
    String? cover,
    String? title,
    String? content,
    String? video,
    int? likes,
    String? publicationTime,
    int? userId,
  }) =>
      Data(
        videoId: videoId ?? _videoId,
        userName: userName ?? _userName,
        avatar: avatar ?? _avatar,
        cover: cover ?? _cover,
        title: title ?? _title,
        content: content ?? _content,
        video: video ?? _video,
        likes: likes ?? _likes,
        publicationTime: publicationTime ?? _publicationTime,
        userId: userId ?? _userId,
      );

  int? get videoId => _videoId;

  String? get userName => _userName;

  String? get avatar => _avatar;

  String? get cover => _cover;

  String? get title => _title;

  String? get content => _content;

  String? get video => _video;

  int? get likes => _likes;

  String? get publicationTime => _publicationTime;

  int? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['videoId'] = _videoId;
    map['userName'] = _userName;
    map['avatar'] = _avatar;
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
