import 'package:pet_community/models/response_model.dart';
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

class UserArticleModel extends ResponseModel {
  UserArticleModel({
    List<Data>? data,
  }) {
    _data = data;
  }

  UserArticleModel.fromJson(dynamic json) {
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

  UserArticleModel copyWith({
    List<Data>? data,
  }) =>
      UserArticleModel(
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
    required int articleId,
    String? title,
    String? content,
    String? cover,
    List<String>? pictures,
    required int likes,
    String? publicationTime,
    required int userId,
  }) {
    _articleId = articleId;

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

    _title = json['title'];
    _content = json['content'];
    _cover = json['cover'];
    _pictures = json['pictures'] != null ? json['pictures'].cast<String>() : [];
    _likes = json['likes'];
    _publicationTime = json['publicationTime'];
    _userId = json['userId'];
  }

  late int _articleId;

  String? _title;
  String? _content;
  String? _cover;
  List<String>? _pictures;
  late int _likes;
  String? _publicationTime;
  late int _userId;

  Data copyWith({
    required int articleId,
    String? title,
    String? content,
    String? cover,
    List<String>? pictures,
    required int likes,
    String? publicationTime,
    required int userId,
  }) =>
      Data(
        articleId: articleId,
        title: title ?? _title,
        content: content ?? _content,
        cover: cover ?? _cover,
        pictures: pictures ?? _pictures,
        likes: likes,
        publicationTime: publicationTime ?? _publicationTime,
        userId: userId,
      );

  int get articleId => _articleId;

  String? get title => _title;

  String? get content => _content;

  String? get cover => _cover;

  List<String>? get pictures => _pictures;

  int get likes => _likes;

  String? get publicationTime => _publicationTime;

  int get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['articleId'] = _articleId;
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
