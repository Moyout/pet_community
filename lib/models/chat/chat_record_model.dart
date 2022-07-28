/// type : 2
/// userName : "moyou"
/// userId : 100020
/// addressee : "weizhi"
/// addresseeId : 100018
/// data : "hahhahahah"

class ChatRecordModel {
  ChatRecordModel({
    int? type,
    String? userName,
    int? userId,
    String? addressee,
    int? addresseeId,
    String? data,
  }) {
    _type = type;
    _userName = userName;
    _userId = userId;
    _addressee = addressee;
    _addresseeId = addresseeId;
    _data = data;
  }

  ChatRecordModel.fromJson(dynamic json) {
    _type = json['type'];
    _userName = json['userName'];
    _userId = json['userId'];
    _addressee = json['addressee'];
    _addresseeId = json['addresseeId'];
    _data = json['data'];
  }
  int? _type;
  String? _userName;
  int? _userId;
  String? _addressee;
  int? _addresseeId;
  String? _data;
  ChatRecordModel copyWith({
    int? type,
    String? userName,
    int? userId,
    String? addressee,
    int? addresseeId,
    String? data,
  }) =>
      ChatRecordModel(
        type: type ?? _type,
        userName: userName ?? _userName,
        userId: userId ?? _userId,
        addressee: addressee ?? _addressee,
        addresseeId: addresseeId ?? _addresseeId,
        data: data ?? _data,
      );
  int? get type => _type;
  String? get userName => _userName;
  int? get userId => _userId;
  String? get addressee => _addressee;
  int? get addresseeId => _addresseeId;
  String? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['userName'] = _userName;
    map['userId'] = _userId;
    map['addressee'] = _addressee;
    map['addresseeId'] = _addresseeId;
    map['data'] = _data;
    return map;
  }
}
