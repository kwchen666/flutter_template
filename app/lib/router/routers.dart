import 'package:appbase/appbase.dart';

import 'router_handler.dart';

/// 路由定义
class Routes {
  static String root = "/";
  static String home = "/home";
  static String error404 = '/error/404';

  static void configureRoutes(Router router) {
    router.define(home, handler: homeHandler);
  }
}
