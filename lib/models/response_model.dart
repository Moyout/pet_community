class ResponseModel {
  late int code;
  late String msg;
  dynamic data;

  ResponseModel();

  ResponseModel.fromJson(Map<String, dynamic> json)
      : code = json["code"],
        msg = json["msg"],
        data = json["data"];

  Map<String, dynamic> toJson() => <String, dynamic>{
        "code": code,
        "msg": msg,
        "data": data,
      };

  @override
  String toString() {
    return 'ResponseModel{code: $code, msg: $msg, data: $data}';
  }
}
