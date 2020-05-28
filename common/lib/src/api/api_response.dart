/// @Description
/// @outhor chenkw
/// @create 2020-05-26 11:48
class ApiResponse {

  // 数据
  var data;

  // 是否成功
  bool isSuccess;

  // 状态
  int code;

  var headers;

  ApiResponse(this.data, this.isSuccess, this.code, {this.headers});

}

