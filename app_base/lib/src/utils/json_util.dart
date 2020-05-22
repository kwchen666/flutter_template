import 'dart:convert';

/// Json Util.
class JsonUtil {
  static String encode(Object value) {
    return value == null ? null : json.encode(value);
  }

  static Object decode(String value) {
    return value == null ? null : json.decode(value);
  }

  static T getObj<T>(String source, T f(Map v)) {
    if (source == null || source.isEmpty) return null;
    try {
      Map map = json.decode(source);
      return map == null ? null : f(map);
    } catch (e) {
      print("JsonUtil convert error, Exception：${e.toString()}");
    }
    return null;
  }

  static T getObject<T>(Object source, T f(Map v)) {
    if (source == null || source.toString().isEmpty) return null;
    try {
      Map map;
      if (source is String) {
        map = json.decode(source);
      } else {
        map = source;
      }
      return map == null ? null : f(map);
    } catch (e) {
      print("JsonUtil convert error, Exception：${e.toString()}");
    }
    return null;
  }

  static List<T> getObjList<T>(String source, T f(Map v)) {
    if (source == null || source.isEmpty) return null;
    try {
      List list = json.decode(source);
      return list?.map((value) {
        return f(value);
      })?.toList();
    } catch (e) {
      print("JsonUtil convert error, Exception：${e.toString()}");
    }
    return null;
  }

  static List<T> getObjectList<T>(Object source, T f(Map v)) {
    if (source == null || source.toString().isEmpty) return null;
    try {
      List list;
      if (source is String) {
        list = json.decode(source);
      } else {
        list = source;
      }
      return list?.map((value) {
        return f(value);
      })?.toList();
    } catch (e) {
      print("JsonUtil convert error, Exception：${e.toString()}");
    }
    return null;
  }
}
