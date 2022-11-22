/// code : 0
/// msg : "验证成功"

class WsResponseModel {
  WsResponseModel({
    int? code,
    String? msg,
  }) {
    _code = code;
    _msg = msg;
  }

  WsResponseModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
  }
  int? _code;
  String? _msg;
  WsResponseModel copyWith({
    int? code,
    String? msg,
  }) =>
      WsResponseModel(
        code: code ?? _code,
        msg: msg ?? _msg,
      );
  int? get code => _code;
  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    return map;
  }
}
