import 'package:pet_community/util/tools.dart';

class UserArticleRequest {
  static Future<UserArticleModel> getUserArticle({
    int page = 1,
    int count = 10,
    required int userId,
  }) async {
    String url = ApiConfig.baseUrl + "/article/queryUserArticle";
    var response = await BaseRequest().toGet(
      url,
      parameters: {"page": page, "count": count, "userId": userId},
      isShowLoading: true,
    );
    UserArticleModel scModel = UserArticleModel.fromJson(response);

    // print(userInfoModel.data);
    return scModel;
  }
}

/// code : 0
/// msg : "成功"
/// data : [{"articleId":31270,"author":"吴绮诗啊嘿嘿","avatar":"http://106.52.246.134:8081/images/100018/avatar/image_cropper_1655205945737.jpg","title":"title","content":"content","cover":"cover","pictures":["http://106.52.246.134:8081/images/pet1.jpg","http://106.52.246.134:8081/images/pet2.jpg"],"likes":20,"publicationTime":"2022-06-14T19:25:54","userId":100018},{"articleId":31273,"author":"吴绮诗啊嘿嘿","avatar":"http://106.52.246.134:8081/images/100018/avatar/image_cropper_1655205945737.jpg","title":"title","content":"content","cover":"cover","pictures":["http://106.52.246.134:8081/images/pet1.jpg","http://106.52.246.134:8081/images/pet2.jpg","http://106.52.246.134:8081/images/pet3.jpg"],"likes":22,"publicationTime":"2022-06-14T19:25:54","userId":100018},{"articleId":31274,"author":"吴绮诗啊嘿嘿","avatar":"http://106.52.246.134:8081/images/100018/avatar/image_cropper_1655205945737.jpg","title":"title","content":"content","cover":"cover","pictures":["http://106.52.246.134:8081/images/pet1.jpg","http://106.52.246.134:8081/images/pet2.jpg","http://106.52.246.134:8081/images/pet3.jpg","http://106.52.246.134:8081/images/pet4.jpg"],"likes":6,"publicationTime":"2022-06-14T19:25:54","userId":100018},{"articleId":31275,"author":"吴绮诗啊嘿嘿","avatar":"http://106.52.246.134:8081/images/100018/avatar/image_cropper_1655205945737.jpg","title":"123","content":"content","cover":"cover","pictures":["http://106.52.246.134:8081/images/pet1.jpg","http://106.52.246.134:8081/images/pet2.jpg","http://106.52.246.134:8081/images/pet3.jpg","http://106.52.246.134:8081/images/pet4.jpg","http://106.52.246.134:8081/images/pet5.jpg"],"likes":12,"publicationTime":"2022-06-16T10:51:37","userId":100018},{"articleId":31276,"author":"吴绮诗啊嘿嘿","avatar":"http://106.52.246.134:8081/images/100018/avatar/image_cropper_1655205945737.jpg","title":"title","content":null,"cover":"cover","pictures":["http://106.52.246.134:8081/images/pet1.jpg","http://106.52.246.134:8081/images/pet2.jpg","http://106.52.246.134:8081/images/pet3.jpg","http://106.52.246.134:8081/images/100018/avatar/image_cropper_1654737819871.jpg","http://106.52.246.134:8081/images/pet5.jpg"],"likes":32,"publicationTime":"2022-06-16T10:45:14","userId":100018}]

class UserArticleModel {
  UserArticleModel({
    int? code,
    String? msg,
    List<Data>? data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  UserArticleModel.fromJson(dynamic json) {
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

  UserArticleModel copyWith({
    int? code,
    String? msg,
    List<Data>? data,
  }) =>
      UserArticleModel(
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

/// articleId : 31270
/// author : "吴绮诗啊嘿嘿"
/// avatar : "http://106.52.246.134:8081/images/100018/avatar/image_cropper_1655205945737.jpg"
/// title : "title"
/// content : "content"
/// cover : "cover"
/// pictures : ["http://106.52.246.134:8081/images/pet1.jpg","http://106.52.246.134:8081/images/pet2.jpg"]
/// likes : 20
/// publicationTime : "2022-06-14T19:25:54"
/// userId : 100018

class Data {
  Data({
    int? articleId,
    String? author,
    String? avatar,
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
  String? _avatar;
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
    String? avatar,
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

  String? get avatar => _avatar;

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
