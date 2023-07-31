import 'package:pet_community/models/response_model.dart';
import 'package:pet_community/util/tools.dart';

class ArticleRequest {
  static Future<ArticleModel> getArticle({
    int page = 1,
    int count = 5,
    bool isShowLoading = true,
  }) async {
    String url = ApiConfig.baseUrl + "/article/queryArticle";
    var response = await BaseRequest().toGet(
      url,
      parameters: {"page": page, "count": count},
      isShowLoading: isShowLoading,
    );
    ArticleModel scModel = ArticleModel.fromJson(response);

    // print(userInfoModel.data);
    return scModel;
  }
}

/// code : 0
/// msg : "成功"
/// data : {"total":5,"articles":[{"articleId":31378,"title":"标题2","content":"内容2","cover":"cover","pictures":["http://localhost:8081/images/100027/article/avatar9.png","http://localhost:8081/images/100027/article/avatar2.png"],"likes":10,"publicationTime":"2023-07-26T18:50:10","userId":100027},{"articleId":31379,"title":"","content":"六小只的第13天 \r\n睡姿各异，可爱可爱……","cover":"cover","pictures":["http://localhost:8081/images/100027/article/avatar2.png","http://localhost:8081/images/100027/article/avatar8.png"],"likes":13,"publicationTime":"2023-07-15T12:48:59","userId":100027},{"articleId":31384,"title":"","content":"你大哥和二哥都生病隔离中只能拍你了","cover":"cover","pictures":["http://106.52.246.134:8081/images/100011/article/68cdfb656cb141d3a03bdb7707218bfa.jpg","http://106.52.246.134:8081/images/100011/article/9221195e451241a4aecc6e4b16fc2161.jpg"],"likes":3,"publicationTime":"2023-07-15T12:48:51","userId":100027},{"articleId":31380,"title":"","content":"六小只的第14只 今天老大睁眼了哦😘😘老四也露点了😜加油哦其他的小布点😘😘","cover":"cover","pictures":["http://localhost:8081/images/100028/article/avatar9.png","http://localhost:8081/images/100028/article/avatar1.png"],"likes":33,"publicationTime":"2023-07-15T12:48:44","userId":100028},{"articleId":31382,"title":"","content":"刚洗完澡  姨姨们贴贴","cover":"cover","pictures":["http://localhost:8081/images/100029/article/avatar9.png"],"likes":7,"publicationTime":"2023-07-15T12:48:46","userId":100029}]}

class ArticleModel extends ResponseModel {
  ArticleModel({
    Data? data,
  }) {
    _data = data;
  }

  ArticleModel.fromJson(dynamic json) {
    code = json['code'];
    msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Data? _data;

  ArticleModel copyWith({
    Data? data,
  }) =>
      ArticleModel(
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

/// total : 5
/// articles : [{"articleId":31378,"title":"标题2","content":"内容2","cover":"cover","pictures":["http://localhost:8081/images/100027/article/avatar9.png","http://localhost:8081/images/100027/article/avatar2.png"],"likes":10,"publicationTime":"2023-07-26T18:50:10","userId":100027},{"articleId":31379,"title":"","content":"六小只的第13天 \r\n睡姿各异，可爱可爱……","cover":"cover","pictures":["http://localhost:8081/images/100027/article/avatar2.png","http://localhost:8081/images/100027/article/avatar8.png"],"likes":13,"publicationTime":"2023-07-15T12:48:59","userId":100027},{"articleId":31384,"title":"","content":"你大哥和二哥都生病隔离中只能拍你了","cover":"cover","pictures":["http://106.52.246.134:8081/images/100011/article/68cdfb656cb141d3a03bdb7707218bfa.jpg","http://106.52.246.134:8081/images/100011/article/9221195e451241a4aecc6e4b16fc2161.jpg"],"likes":3,"publicationTime":"2023-07-15T12:48:51","userId":100027},{"articleId":31380,"title":"","content":"六小只的第14只 今天老大睁眼了哦😘😘老四也露点了😜加油哦其他的小布点😘😘","cover":"cover","pictures":["http://localhost:8081/images/100028/article/avatar9.png","http://localhost:8081/images/100028/article/avatar1.png"],"likes":33,"publicationTime":"2023-07-15T12:48:44","userId":100028},{"articleId":31382,"title":"","content":"刚洗完澡  姨姨们贴贴","cover":"cover","pictures":["http://localhost:8081/images/100029/article/avatar9.png"],"likes":7,"publicationTime":"2023-07-15T12:48:46","userId":100029}]

class Data {
  Data({
    required int total,
    required List<Articles> articles,
  }) {
    _total = total;
    _articles = articles;
  }

  Data.fromJson(dynamic json) {
    _total = json['total'];
    if (json['articles'] != null) {
      _articles = [];
      json['articles'].forEach((v) {
        _articles.add(Articles.fromJson(v));
      });
    }
  }

  late int _total;
  late List<Articles> _articles;

  Data copyWith({
    required int total,
    required List<Articles> articles,
  }) =>
      Data(
        total: total,
        articles: articles,
      );

  int get total => _total;

  List<Articles>? get articles => _articles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['articles'] = _articles.map((v) => v.toJson()).toList();
    return map;
  }
}

/// articleId : 31378
/// title : "标题2"
/// content : "内容2"
/// cover : "cover"
/// pictures : ["http://localhost:8081/images/100027/article/avatar9.png","http://localhost:8081/images/100027/article/avatar2.png"]
/// likes : 10
/// publicationTime : "2023-07-26T18:50:10"
/// userId : 100027

class Articles {
  Articles({
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

  Articles.fromJson(dynamic json) {
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

  Articles copyWith({
    required int articleId,
    String? title,
    String? content,
    String? cover,
    List<String>? pictures,
    required int likes,
    String? publicationTime,
    required int userId,
  }) =>
      Articles(
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
