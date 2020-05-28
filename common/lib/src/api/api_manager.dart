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
  Future<ApiResponse> httpGet(String url,
      {Map<String, dynamic> params}) async {
    return await request("get", url, params: params);
  }

  /// post请求
  Future<ApiResponse> httpPost(String url,
      {Map<String, dynamic> params}) async {
    return await request("post", url, params: params);
  }

  /// 请求
  Future<ApiResponse> request(String method, String url,
      {Map<String, dynamic> params}) async {
    try {
      Response response = await dio.request(url,
          queryParameters: params, options: Options(method: method));
      if (_isSuccess(response)) {
        return ApiResponse(response.data, true, response.statusCode);
      } else {
        return ApiResponse(null, false, response.statusCode, error: ApiError(ApiErrorType.api_error, response.statusCode,
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
      return ApiResponse(null, false, -1, error: apiError);
    }
  }

  /// 判断请求是否成功
  _isSuccess(Response response) {
    if (response == null) return false;
    return response.statusCode == 200 || response.statusCode == 201;
  }
}
