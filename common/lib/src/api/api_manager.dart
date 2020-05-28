import 'package:common/src/api/api_error.dart';
import 'package:common/src/api/api_response.dart';
import 'package:dio/dio.dart';

/// @Description
/// @outhor chenkw
/// @create 2020-05-26 11:01
class ApiManager {
  static final ApiManager _shared = ApiManager._internal();

  factory ApiManager() => _shared;

  static ApiManager get instance => ApiManager._shared;

  Dio dio;

  ApiManager._internal() {
    if (dio == null) {
      BaseOptions options = BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        receiveDataWhenStatusError: false,
        connectTimeout: 15000,
        receiveTimeout: 5000,
      );
      dio = Dio(options);
    }
  }

  /// 添加拦截器
  addInterceptor(Interceptor interceptor) {
    if (interceptor != null) {
      dio.interceptors.add(interceptor);
    }
  }

  /// get 请求
  Future httpGet(String url,
      {Map<String, dynamic> params,
      Function(ApiResponse) success,
      Function(ApiError) error}) async {
    await request("get", url, params: params, success: success, error: error);
  }

  /// post请求
  Future httpPost(String url,
      {Map<String, dynamic> params,
      Function(ApiResponse) success,
      Function(ApiError) error}) async {
    await request("post", url, params: params, success: success, error: error);
  }

  /// 请求
  Future request(String method, String url,
      {Map<String, dynamic> params,
      Function(ApiResponse) success,
      Function(ApiError) error}) async {
    try {
      Response response = await dio.request(url,
          queryParameters: params, options: Options(method: method));
      if (_isSuccess(response)) {
        success(ApiResponse(response.data, true, response.statusCode));
      } else {
        error(ApiError(ApiErrorType.api_error, response.statusCode,
            response.statusMessage));
      }
    } on DioError catch (e) {
      ApiError apiError = ApiError(ApiErrorType.none, -1, "");

      switch (e.type) {
        case DioErrorType.CONNECT_TIMEOUT:
        case DioErrorType.RECEIVE_TIMEOUT:
        case DioErrorType.SEND_TIMEOUT:
          apiError = ApiError(ApiErrorType.timeout, -1, e.message);
          break;

        case DioErrorType.CANCEL:
          apiError = ApiError(ApiErrorType.cancel, -1, e.message);
          break;

        case DioErrorType.RESPONSE:
          apiError = ApiError(ApiErrorType.response, -1, e.message);
          break;

        default:
          break;
      }
      error(apiError);
    }
  }

  /// 判断请求是否成功
  _isSuccess(Response response) {
    if (response == null) return false;
    return response.statusCode == 200 || response.statusCode == 201;
  }
}
