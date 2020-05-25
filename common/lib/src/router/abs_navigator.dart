import 'package:flutter/widgets.dart';

/// @Description
/// @outhor chenkw
/// @create 2020-05-25 10:19
abstract class AbsNavigator {

  /// 跳转页面，无返回值
  void push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false});

  /// 跳转面面，有返回值
  void pushResult(BuildContext context, String path, Function(Object) callback,
      {bool replace = false, bool clearStack = false});

  /// 返回
  void goBack(BuildContext context);

  /// 带参数返回
  void goBackWithParams(BuildContext context, result);

  /// 释放焦点
  void unfocus();
}

