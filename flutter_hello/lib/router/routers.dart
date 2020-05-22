import 'package:flutter/material.dart';

class Routes {
  static String root = "/";
  static String home = "/home";
  static String error404 = '/error/404';

  static void configureRoutes(Router router) {
    List widgetDemosList = new WidgetDemoList().getDemos();
//    router.notFoundHandler = new Handler(
//      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//      }
//    );
    router.define(home, handler: homeHandler);

    widgetDemosList.forEach((demo) {
      Handler handler = new Handler(handlerFunc:
          (BuildContext context, Map<String, List<String>> params) {
        return demo.buildRouter(context);
      });
      String path = demo.routerName;
      router.define('${path.toLowerCase()}', handler: handler);
    });
//    router.define(webViewPage,handler:webViewPageHand);
//    standardPages.forEach((String id, String md) => {
//
//    });
  }
}
