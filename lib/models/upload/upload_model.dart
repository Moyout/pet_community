import 'package:dio/dio.dart';
import 'package:pet_community/models/upload/upload_video_model.dart';
import 'package:pet_community/util/tools.dart';
import 'package:http_parser/http_parser.dart';

class UploadRequest {
  static Future<UploadVideoModel> uploadVideoFile(String filePath, int? userId, String? token) async {
    String url = ApiConfig.baseUrl + "/upload/petVideo";

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        filePath,
        contentType: MediaType("video", "mp4"),
      ),
    });

    var response = await BaseRequest().toPost(
      url,
      parameters: {"userId": userId},
      options: Options(
        headers: {PublicKeys.token: token},
        contentType: "multipart/form-data",
      ),
      data: formData,
      isShowLoading: true,
    );

    UploadVideoModel scModel = UploadVideoModel.fromJson(response);

    return scModel;
  }
}
