import 'package:appbase/appbase.dart';

enum ENV {
  PRODUCTION,
  DEV,
}

class Application {
  /// 通过Application设计环境变量
  static ENV env = ENV.DEV;

  static Router router;
  static SpUtil sharePeference;

  static void init() async {
    router = Router();
    sharePeference = await SpUtil.instance;
  }

  /// 所有获取配置的唯一入口
  Map<String, String> get config {
    if (Application.env == ENV.PRODUCTION) {
      return {};
    }
    if (Application.env == ENV.DEV) {
      return {};
    }
    return {};
  }
}
