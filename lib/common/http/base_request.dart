import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:pet_community/util/tools.dart';
import 'package:pet_community/view_models/nav_viewmodel.dart';

class BaseRequest {
  static final BaseRequest _instance = BaseRequest._internal();
  late Dio dio;
  bool isShowLoading = false;

  // CancelToken cancelToken = CancelToken();
  Response? response;

  factory BaseRequest() => _instance;

  BaseRequest._internal() {
    dio = Dio(BaseOptions(connectTimeout: 10000, receiveTimeout: 10000));
    interceptor();
  }

  ///拦截器
  void interceptor() {
    // if (dio?.interceptors.length == 0) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          debugPrint("\n================== 请求数据 ==========================");
          debugPrint("url = ${options.uri.toString()}");
          debugPrint("headers = ${options.headers}");
          debugPrint("params = ${options.data}");
          handler.next(options);
          if (isShowLoading) {
            ToastUtil.showCustomLoadingToast(seconds: 10, clickClose: false);
          }
          // Toast.showLoadingToast(seconds: 10, clickClose: false);
          // cancelToken.cancel();
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) async {
          debugPrint("\n================== 响应数据 ==========================");
          debugPrint("code = ${response.statusCode}");
          debugPrint("data = ${response.data}");
          debugPrint("\n");
          await Future.delayed(const Duration(milliseconds: 600), () {
            ToastUtil.closeLoading();
          });
          handler.next(response);
        },
        onError: (DioError e, ErrorInterceptorHandler handler) async {
          debugPrint("\n================== 错误响应数据 ======================");
          debugPrint("type = ${e.type}");
          debugPrint("message = ${e.message}");
          debugPrint("\n");
          handler.next(e);

          /*error统一处理*/
          if (e.type == DioErrorType.connectTimeout) {
            // Toast.showBotToast("连接超时");
            ToastUtil.showBottomToast("连接超时");
          } else if (e.type == DioErrorType.sendTimeout) {
            // Toast.showBotToast("请求超时");
            ToastUtil.showBottomToast("请求超时");
          } else if (e.type == DioErrorType.receiveTimeout) {
            // Toast.showBotToast("响应超时");
            ToastUtil.showBottomToast("响应超时");
          } else if (e.type == DioErrorType.response) {
            // Toast.showBotToast("出现异常");
            ToastUtil.showBottomToast("出现异常");
          } else if (e.type == DioErrorType.cancel) {
            // Toast.showBotToast("请求取消");
            ToastUtil.showBottomToast("请求取消");
          } else {
            // Toast.showBotToast("请求错误");
          }
          Future.delayed(const Duration(milliseconds: 2000), () {
            ToastUtil.closeLoading();
          });
        },
      ),
    );
    // }
  }

  ///get请求
  Future toGet(
    url, {
    Map<String, dynamic>? parameters,
    Options? options,
    bool isShowLoading = false,
  }) async {
    this.isShowLoading = isShowLoading;

    dynamic result;
    if (AppUtils.getContext().read<NavViewModel>().netMode == ConnectivityResult.none) {
      ToastUtil.showBotToast(PublicKeys.netError,bgColor: PublicKeys.errorColor);
    } else {
      response = await dio.get(
        url, queryParameters: parameters, options: options,
        // cancelToken: cancelToken,
      );
      try {
        result = await jsonDecode(response?.data);
      } catch (e) {
        debugPrint("=========jsonDecode 错误" + e.toString());
        result = response?.data;
      }
    }

    return result;
  }

  ///post请求
  Future<dynamic> toPost(
    url, {
    data,
    Map<String, dynamic>? parameters,
    Options? options,
    bool isShowLoading = false,
  }) async {
    this.isShowLoading = isShowLoading;
    if (AppUtils.getContext().read<NavViewModel>().netMode == ConnectivityResult.none) {
      ToastUtil.showBotToast(PublicKeys.netError,bgColor: PublicKeys.errorColor);
    } else {
      response = await dio.post(url, queryParameters: parameters, options: options, data: data).catchError((e) {
        debugPrint("=======post错误========================>$e");
      });
      // print("################${response.data}");
    }
    return response?.data;
  }

  /*
   * 下载文件
   */
  Future<dynamic> downloadFile(urlPath, savePath) async {
    try {
      String progress = "";
      response = await dio.download(
        urlPath,
        savePath,
        options: Options(receiveTimeout: 0),
        onReceiveProgress: (int count, int total) {
          //进度
          debugPrint((count / total).toStringAsFixed(2));
          progress = (count / total).toStringAsFixed(2);
        },

        // cancelToken: CancelToken(),//取消操作
      );
      return progress;
    } on DioError catch (e) {
      debugPrint('downloadFile error---------$e');
      return response;
    }
  }

  ///上传文件
  Future<dynamic> uploadFile(
    String url,
    String filePath, {
    Map<String, dynamic>? parameters,
    ProgressCallback? onSendProgress,
    Map<String, dynamic>? headers,
  }) async {
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(filePath),
    });
    Options options = Options(
      method: "POST",
      contentType: "multipart/form-data",
      headers: headers,
      sendTimeout: 0,
    );
    if (AppUtils.getContext().read<NavViewModel>().netMode == ConnectivityResult.none) {
      ToastUtil.showBotToast(PublicKeys.netError);
    } else {
      response = await dio
          .post(
        url,
        data: formData,
        queryParameters: parameters,
        options: options,
        onSendProgress: onSendProgress,
      )
          .catchError(
        (e) {
          debugPrint("e--------->${e}");
        },
      );
    }
    return response;
  }
}
