class UploadVideoModel {
  UploadVideoModel({
    num? code,
    String? msg,
    Data? data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  UploadVideoModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _code;
  String? _msg;
  Data? _data;
  UploadVideoModel copyWith({
    num? code,
    String? msg,
    Data? data,
  }) =>
      UploadVideoModel(
        code: code ?? _code,
        msg: msg ?? _msg,
        data: data ?? _data,
      );
  num? get code => _code;
  String? get msg => _msg;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    String? cover,
    String? video,
  }) {
    _cover = cover;
    _video = video;
  }

  Data.fromJson(dynamic json) {
    _cover = json['cover'];
    _video = json['video'];
  }
  String? _cover;
  String? _video;
  Data copyWith({
    String? cover,
    String? video,
  }) =>
      Data(
        cover: cover ?? _cover,
        video: video ?? _video,
      );
  String? get cover => _cover;
  String? get video => _video;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cover'] = _cover;
    map['video'] = _video;
    return map;
  }
}
