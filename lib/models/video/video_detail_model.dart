import 'package:pet_community/models/response_model.dart';
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
/// data : {"userInfo":{"userId":100027,"userName":"用户272727","avatar":"http://localhost:8081/images/100027/avatar/avatar9.png","phone":"19875606630","sex":"男","area":null,"background":"http://localhost:8081/images/100027/background/avatar2.png","signature":"呵呵呵"},"video":{"videoId":10023,"cover":"http://localhost:8081/images/100027/petVideoCover/2693a96a81a3461691a517452ca744da.png","title":"标题","content":"今天带着多多跑楼顶耍了，随后又带着去打了疫苗，只希望你健健康康的","video":"http://localhost:8081/images/100027/petVideo/2693a96a81a3461691a517452ca744da.mp4","likes":7,"publicationTime":"2023-07-29T19:19:11","userId":100027}}

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

/// userInfo : {"userId":100027,"userName":"用户272727","avatar":"http://localhost:8081/images/100027/avatar/avatar9.png","phone":"19875606630","sex":"男","area":null,"background":"http://localhost:8081/images/100027/background/avatar2.png","signature":"呵呵呵"}
/// video : {"videoId":10023,"cover":"http://localhost:8081/images/100027/petVideoCover/2693a96a81a3461691a517452ca744da.png","title":"标题","content":"今天带着多多跑楼顶耍了，随后又带着去打了疫苗，只希望你健健康康的","video":"http://localhost:8081/images/100027/petVideo/2693a96a81a3461691a517452ca744da.mp4","likes":7,"publicationTime":"2023-07-29T19:19:11","userId":100027}

class Data {
  Data({
    required UserInfo userInfo,
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
    _userInfo = UserInfo.fromJson(json['userInfo']);
    _video = Video.fromJson(json['video']);
  }

  late UserInfo _userInfo;
  late Video _video;

  Data copyWith({
    required UserInfo userInfo,
    required Video video,
  }) =>
      Data(
        userInfo: userInfo,
        video: video,
      );

  UserInfo get userInfo => _userInfo;

  Video get video => _video;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userInfo'] = _userInfo.toJson();
    map['video'] = _video.toJson();
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

/// userId : 100027
/// userName : "用户272727"
/// avatar : "http://localhost:8081/images/100027/avatar/avatar9.png"
/// phone : "19875606630"
/// sex : "男"
/// area : null
/// background : "http://localhost:8081/images/100027/background/avatar2.png"
/// signature : "呵呵呵"

class UserInfo {
  UserInfo({
    required int userId,
    String? userName,
    String? avatar,
    String? phone,
    String? sex,
    String? area,
    String? background,
    String? signature,
  }) {
    _userId = userId;
    _userName = userName;
    _avatar = avatar;
    _phone = phone;
    _sex = sex;
    _area = area;
    _background = background;
    _signature = signature;
  }

  @override
  String toString() {
    return 'UserInfo{_userId: $_userId, _userName: $_userName, _avatar: $_avatar, _phone: $_phone, _sex: $_sex, _area: $_area, _background: $_background, _signature: $_signature}';
  }

  UserInfo.fromJson(dynamic json) {
    _userId = json['userId'];
    _userName = json['userName'];
    _avatar = json['avatar'];
    _phone = json['phone'];
    _sex = json['sex'];
    _area = json['area'];
    _background = json['background'];
    _signature = json['signature'];
  }

  late int _userId;
  String? _userName;
  String? _avatar;
  String? _phone;
  String? _sex;
  String? _area;
  String? _background;
  String? _signature;

  UserInfo copyWith({
    required int userId,
    String? userName,
    String? avatar,
    String? phone,
    String? sex,
    String? area,
    String? background,
    String? signature,
  }) =>
      UserInfo(
        userId: userId,
        userName: userName ?? _userName,
        avatar: avatar ?? _avatar,
        phone: phone ?? _phone,
        sex: sex ?? _sex,
        area: area ?? _area,
        background: background ?? _background,
        signature: signature ?? _signature,
      );

  int get userId => _userId;

  String? get userName => _userName;

  String? get avatar => _avatar;

  String? get phone => _phone;

  String? get sex => _sex;

  String? get area => _area;

  String? get background => _background;

  String? get signature => _signature;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['userName'] = _userName;
    map['avatar'] = _avatar;
    map['phone'] = _phone;
    map['sex'] = _sex;
    map['area'] = _area;
    map['background'] = _background;
    map['signature'] = _signature;
    return map;
  }
}
