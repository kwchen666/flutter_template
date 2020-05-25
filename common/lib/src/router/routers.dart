import 'package:common/src/router/router_provider.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../page/page404.dart';

/// 通用页面路由
class CommonRoutes extends IRouterProvider {

  @override
  void initRouter(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          return WidgetNotFound();
        });
  }
}
