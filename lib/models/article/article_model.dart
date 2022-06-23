import 'package:pet_community/util/tools.dart';

class ArticleRequest {
  static Future<ArticleModel> getArticle({int page = 1, int count = 5}) async {
    String url = ApiConfig.baseUrl + "/article/queryArticle";
    var response = await BaseRequest().toGet(
      url,
      parameters: {"page": page, "count": count},
      isShowLoading: true,
    );
    ArticleModel scModel = ArticleModel.fromJson(response);

    // print(userInfoModel.data);
    return scModel;
  }
}

/// code : 0
/// msg : "操作成功"
/// data : [{"articleId":31263,"author":"moyou","avatar":null,"title":"title","content":"content","cover":"cover","pictures":["pictures"],"likes":0,"publicationTime":"2022-05-31T06:54:45","userId":100018},{"articleId":31264,"author":"moyou","avatar":null,"title":"title","content":"content","cover":"cover","pictures":["pictures"],"likes":0,"publicationTime":"2022-05-31T06:55:05","userId":100018},{"articleId":31267,"author":"moyou","avatar":null,"title":"title","content":"content","cover":"cover","pictures":["pictures"],"likes":0,"publicationTime":"2022-05-31T10:31:28","userId":100018},{"articleId":31269,"author":"moyou","avatar":"http://106.52.246.134:8081/images/100018/avatar/image_cropper_1653287231038.jpg","title":"title","content":"content","cover":"cover","pictures":["pictures"],"likes":0,"publicationTime":"2022-05-31T10:48:29","userId":100018},{"articleId":31270,"author":"moyou","avatar":"http://106.52.246.134:8081/images/100018/avatar/image_cropper_1653287231038.jpg","title":"title","content":"content","cover":"cover","pictures":["pictures"],"likes":0,"publicationTime":"2022-05-31T10:49:08","userId":100018}]

class ArticleModel {
  ArticleModel({
    int? code,
    String? msg,
    List<Data>? data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  ArticleModel.fromJson(dynamic json) {
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
  ArticleModel copyWith({
    int? code,
    String? msg,
    List<Data>? data,
  }) =>
      ArticleModel(
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

/// articleId : 31263
/// author : "moyou"
/// avatar : null
/// title : "title"
/// content : "content"
/// cover : "cover"
/// pictures : ["pictures"]
/// likes : 0
/// publicationTime : "2022-05-31T06:54:45"
/// userId : 100018

class Data {
  Data({
    int? articleId,
    String? author,
    dynamic avatar,
    String? title,
    String? content,
    String? cover,
    List<String>? pictures,
    int? likes,
    String? publicationTime,
    int? userId,
  }) {
    _articleId = articleId;
    _author = author;
    _avatar = avatar;
    _title = title;
    _content = content;
    _cover = cover;
    _pictures = pictures;
    _likes = likes;
    _publicationTime = publicationTime;
    _userId = userId;
  }

  Data.fromJson(dynamic json) {
    _articleId = json['articleId'];
    _author = json['author'];
    _avatar = json['avatar'];
    _title = json['title'];
    _content = json['content'];
    _cover = json['cover'];
    _pictures = json['pictures'] != null ? json['pictures'].cast<String>() : [];
    _likes = json['likes'];
    _publicationTime = json['publicationTime'];
    _userId = json['userId'];
  }
  int? _articleId;
  String? _author;
  dynamic _avatar;
  String? _title;
  String? _content;
  String? _cover;
  List<String>? _pictures;
  int? _likes;
  String? _publicationTime;
  int? _userId;
  Data copyWith({
    int? articleId,
    String? author,
    dynamic avatar,
    String? title,
    String? content,
    String? cover,
    List<String>? pictures,
    int? likes,
    String? publicationTime,
    int? userId,
  }) =>
      Data(
        articleId: articleId ?? _articleId,
        author: author ?? _author,
        avatar: avatar ?? _avatar,
        title: title ?? _title,
        content: content ?? _content,
        cover: cover ?? _cover,
        pictures: pictures ?? _pictures,
        likes: likes ?? _likes,
        publicationTime: publicationTime ?? _publicationTime,
        userId: userId ?? _userId,
      );
  int? get articleId => _articleId;
  String? get author => _author;
  dynamic get avatar => _avatar;
  String? get title => _title;
  String? get content => _content;
  String? get cover => _cover;
  List<String>? get pictures => _pictures;
  int? get likes => _likes;
  String? get publicationTime => _publicationTime;
  int? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['articleId'] = _articleId;
    map['author'] = _author;
    map['avatar'] = _avatar;
    map['title'] = _title;
    map['content'] = _content;
    map['cover'] = _cover;
    map['pictures'] = _pictures;
    map['likes'] = _likes;
    map['publicationTime'] = _publicationTime;
    map['userId'] = _userId;
    return map;
  }
}
