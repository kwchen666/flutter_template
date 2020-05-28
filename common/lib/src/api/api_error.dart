/// @Description      api 请求错误
/// @outhor chenkw
/// @create 2020-05-26 11:48
class ApiError {

  // 错误类型
  ApiErrorType type;

  // 错误代码
  int code;

  // 错误消息
  String msg;

  ApiError(this.type, this.code, this.msg);
}

/// 错误类型
enum ApiErrorType {
  timeout,
  response,
  cancel,
  none,
  api_error,
}