import 'package:common/common.dart';

import 'router_handler.dart';

/// 路由定义
class AppRoutes extends IRouterProvider {
  static String root = "/";
  static String test = "/test";

  @override
  void initRouter(Router router) {
    router.define(test, handler: testHandler);
  }
}
