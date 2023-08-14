
import '../../util/tools.dart';

class ChatRecordModel {
  ChatRecordModel({
    int? code,
    required int type,
    required int userId, //发送者Id
    required int receiverId, //接收者Id
    dynamic data,
    String? msg,
    required int sendTime,
  }) {
    _code = code;
    _type = type;
    _userId = userId;
    _data = data;
    _msg = msg;
    _receiverId = receiverId;
    _sendTime = sendTime;
  }

  ChatRecordModel.fromJson(dynamic json) {
    _code = json['code'];
    _type = json['type'];
    _userId = json['userId'];
    _receiverId = json["receiverId"];
    _data = json['data'];
    _msg = json['msg'];
    _sendTime = json['sendTime'];
  }

  int? _code;
  late int _type;

  late int _userId;
  late int _receiverId;

  dynamic _data;
  String? _msg;
  late int _sendTime;

  ChatRecordModel copyWith({
    int? code,
    required int type,
    required int userId,
    required int receiverId,
    dynamic data,
    String? msg,
    required int sendTime,
  }) =>
      ChatRecordModel(
        code: code ?? _code,
        type: type,
        userId: userId,
        receiverId: receiverId,
        data: data ?? _data,
        msg: msg ?? _msg,
        sendTime: sendTime,
      );

  int? get code => _code;

  int get type => _type;

  int get userId => _userId;

  int get receiverId => _receiverId;

  dynamic get data => _data;

  String? get msg => _msg;

  int get sendTime => _sendTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['type'] = _type;
    map['userId'] = _userId;
    map['receiverId'] = _receiverId;
    map['data'] = _data;
    map['msg'] = _msg;
    map['sendTime'] = _sendTime;
    return map;
  }

  @override
  String toString() {
    return 'ChatRecordModel{_code: $_code, _type: $_type, _userId: $_userId, _receiverId: $_receiverId, _data: $_data, _msg: $_msg, _sendTime: $_sendTime}';
  }

  //解析数据库数据
  ChatRecordModel.fromMap(dynamic map) {
    _code = 0;
    _type = map['type'];
    _userId = map['sender_id'];
    _receiverId = map["receiver_id"];
    _data = map['message'];
    // _msg = map['msg'];
    _sendTime = map['timestamp'];

  }


}
