import 'package:common/common.dart';

import 'router_handler.dart';

/// 路由定义
class AppRoutes extends IRouterProvider {
  static String root = "/";
  static String test = "/test";
  static String test2 = "/test2";

  @override
  void initRouter(Router router) {
    router.define(test, handler: testHandler);
    router.define(test2, handler: test2Handler);
  }
}
