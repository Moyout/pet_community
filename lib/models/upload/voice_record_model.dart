import 'dart:io';

import 'package:dio/dio.dart';

import 'package:pet_community/models/response_model.dart';
import 'package:pet_community/util/tools.dart';

class VoiceRecordRequest {
  static Future<VoiceRecordModel> uploadVoiceRecord(int userId, int otherUserId, String token, String filePath) async {
    String url = ApiConfig.baseUrl + "/upload/voiceRecord";

    final bytes = await File(filePath).readAsBytes();

    final filename = filePath.split("/").last;

    final file = MultipartFile.fromBytes(bytes, filename: filename);
    FormData formData = FormData.fromMap(
      {
        "file": file,
      },
    );
    var response = await BaseRequest().toPost(
      url,
      parameters: {"userId": userId, "otherUserId": otherUserId},
      options: Options(
        method: "post",
        headers: {PublicKeys.token: token},
        contentType: "multipart/form-data",
      ),
      data: formData,
      isShowLoading: true,
    );
    VoiceRecordModel vrModel = VoiceRecordModel.fromJson(response);

    return vrModel;
  }
}

/// code : 0
/// msg : "成功"
/// data : {"voicePath":"http://localhost:8081/images/100028/voiceRecord_100027/1692709144822.aac"}

class VoiceRecordModel extends ResponseModel {
  VoiceRecordModel({
    Data? data,
  }) {
    _data = data;
  }

  VoiceRecordModel.fromJson(dynamic json) {
    code = json['code'];
    msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Data? _data;

  VoiceRecordModel copyWith({
    Data? data,
  }) =>
      VoiceRecordModel(
        data: data ?? _data,
      );

  Data? get data => _data;

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

/// voicePath : "http://localhost:8081/images/100028/voiceRecord_100027/1692709144822.aac"

class Data {
  Data({
    String? voicePath,
  }) {
    _voicePath = voicePath;
  }

  Data.fromJson(dynamic json) {
    _voicePath = json['voicePath'];
  }

  String? _voicePath;

  Data copyWith({
    String? voicePath,
  }) =>
      Data(
        voicePath: voicePath ?? _voicePath,
      );

  String? get voicePath => _voicePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['voicePath'] = _voicePath;
    return map;
  }
}
