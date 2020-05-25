
import 'package:common/src/router/router_navigator.dart';
import 'package:fluro/fluro.dart';

import '../router/router_provider.dart';
import '../router/abs_navigator.dart';
import '../router/routers.dart';
import '../utils/object_util.dart';

typedef void ConfigureRoutes(Router router);

/// app
class App {

  /// 路由
  static Router router;

  /// 页面路由列表
  static List<IRouterProvider> _listRouter = [];

  /// 导航
  static AbsNavigator navigator;

  /// 初始化
  static void init({List<IRouterProvider> routes, AbsNavigator navigator}) {
    // 创建路由
    App.router = Router();
    // 导航
    App.navigator = navigator ?? RouterNavigator();
    // 配置页面路由
    _configureRoutes(routes);
  }

  /// 配置路由
  static void _configureRoutes(List<IRouterProvider> routes) {
    if (ObjectUtil.isEmptyList(routes)) return;
    if (_listRouter.isNotEmpty) {
      _listRouter.clear();
    }

    // 配置通用页面路由
    _listRouter.add(CommonRoutes());

    // 各自路由由各自模块管理，统一在此添加初始化
    _listRouter.addAll(routes);

    // 初始化路由
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}
