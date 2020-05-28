import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// @Description    基础Provider页面
/// @outhor chenkw
/// @create 2020-05-26 9:10
abstract class BaseProviderPage<T extends ChangeNotifier>
    extends StatelessWidget {

  BuildContext _context;

  BuildContext getContext() => _context;

  @override
  Widget build(BuildContext context) {
    LogUtil.d("page build ... ");

    _context = context;
    var provider = getProvider();

    if (provider == null) {
      return renderPage(context);
    }

    return ChangeNotifierProvider(
      create: (_) => provider,
      child: Builder(builder: (BuildContext context) {
        return renderPage(context);
      }),
    );
  }

  /// 获取provider
  T getProvider();

  Widget renderPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Base Page"),
      ),
      body: Text("Base Page"),
    );
  }
}
