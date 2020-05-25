import 'package:common/src/router/abs_navigator.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../app/app.dart';

/// fluro的路由跳转工具类
class RouterNavigator extends AbsNavigator {

  /// 跳转页面，无返回值
  void push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false}) {
    unfocus();
    App.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native);
  }

  /// 跳转面面，有返回值
  void pushResult(BuildContext context, String path, Function(Object) callback,
      {bool replace = false, bool clearStack = false}) {
    unfocus();
    App.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native).then((result) {
      // 页面返回result为null
      if (result == null) {
        return;
      }
      callback(result);
    }).catchError((error) {
      print('$error');
    });
  }

  /// 返回
  void goBack(BuildContext context) {
    unfocus();
    Navigator.pop(context);
  }

  /// 带参数返回
  void goBackWithParams(BuildContext context, result) {
    unfocus();
    Navigator.pop(context, result);
  }

  /// 释放焦点
  void unfocus() {
    // 使用下面的方式，会触发不必要的build。
    // FocusScope.of(context).unfocus();
    // https://github.com/flutter/flutter/issues/47128#issuecomment-627551073
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
