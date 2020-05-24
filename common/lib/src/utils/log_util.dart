
/// Log Util.
class LogUtil {
  static bool debug = false;
  static int maxLen = 600;
  static String tag = "log";


  static void i(Object object, {String tag}) {
    _logout(tag, object);
  }

  static void d(Object object, {String tag}) {
    assert(debug = true);
    if (debug) {
      _logout(tag, object);
    }
  }

  static void _logout(String tag, Object object) {
    String da = object.toString();
    tag = tag ?? LogUtil.tag;
    if (da.length <= maxLen) {
      print("$tag: $da");
      return;
    }
    while (da.isNotEmpty) {
      if (da.length > maxLen) {
        print("$tag| ${da.substring(0, maxLen)}");
        da = da.substring(maxLen, da.length);
      } else {
        print("$tag| $da");
        da = "";
      }
    }
  }
}
