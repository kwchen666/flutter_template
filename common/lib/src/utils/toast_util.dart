import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// @Description      提示消息
/// @outhor chenkw
/// @create 2020-05-25 11:52
class ToastUtil {

  /// 显示提示消息
  static void show(String msg,
      {toastLength = Toast.LENGTH_LONG,
      backgroundColor = Colors.black54,
      textColor = Colors.white,
      fontSize = 16}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: toastLength,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: fontSize);
  }
}
