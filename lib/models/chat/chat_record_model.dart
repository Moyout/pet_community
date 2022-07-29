/// type : 2
/// userName : "moyou"
/// userId : 100020
/// addressee : "weizhi"
/// addresseeId : 100018
/// data : "hahhahahah"

class ChatRecordModel {
  ChatRecordModel({
    int? code,
    int? type,
    String? userName,
    String? userAvatar,
    int? userId,
    String? addressee,
    int? addresseeId,
    String? data,
    String? msg,
  }) {
    _code = code;
    _type = type;
    _userName = userName;
    _userAvatar = userAvatar;
    _userId = userId;
    _addressee = addressee;
    _addresseeId = addresseeId;
    _data = data;
    _msg = msg;
  }

  ChatRecordModel.fromJson(dynamic json) {
    _code = json['code'];
    _type = json['type'];
    _userName = json['userName'];
    _userAvatar = json['userAvatar'];
    _userId = json['userId'];
    _addressee = json['addressee'];
    _addresseeId = json['addresseeId'];
    _data = json['data'];
    _msg = json['msg'];
  }

  int? _code;
  int? _type;
  String? _userName;
  String? _userAvatar;
  int? _userId;
  String? _addressee;
  int? _addresseeId;
  String? _data;
  String? _msg;

  ChatRecordModel copyWith({
    int? code,
    int? type,
    String? userName,
    String? userAvatar,
    int? userId,
    String? addressee,
    int? addresseeId,
    String? data,
    String? msg,
  }) =>
      ChatRecordModel(
        code: code ?? _code,
        type: type ?? _type,
        userName: userName ?? _userName,
        userAvatar: userAvatar ?? _userAvatar,
        userId: userId ?? _userId,
        addressee: addressee ?? _addressee,
        addresseeId: addresseeId ?? _addresseeId,
        data: data ?? _data,
        msg: msg ?? _msg,
      );

  int? get code => _code;

  int? get type => _type;

  String? get userName => _userName;
  String? get userAvatar => _userAvatar;

  int? get userId => _userId;

  String? get addressee => _addressee;

  int? get addresseeId => _addresseeId;

  String? get data => _data;
  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['type'] = _type;
    map['userName'] = _userName;
    map['userAvatar'] = _userAvatar;
    map['userId'] = _userId;
    map['addressee'] = _addressee;
    map['addresseeId'] = _addresseeId;
    map['data'] = _data;
    map['msg'] = _msg;
    return map;
  }
}
