/// @Description
/// @outhor chenkw
/// @create 2020-05-07 11:17

enum DateRangeType {
  // 年区间
  RangeYear,
  // 月区间
  RangeMonth,
  // 日区间
  RangeDay,
}

class DateUtils {
  /// 服务器的时区偏移量，单位：ms
  static const serverZoneOffset = 8 * Duration.millisecondsPerHour;

  /// 获取本地当前时间
  static DateTime getLocaleTimeNow() {
    return DateTime.now();
  }

  /// 获取当前时间
  static DateTime getTimeNow() {
    return convertServerTime(DateTime.now());
  }

  /// 转换成服务器时间
  static DateTime convertServerTime(DateTime date) {
    if (date == null) return null;

    int localeZoneOffset = date.timeZoneOffset.inMilliseconds;
    int timeOffset = serverZoneOffset - localeZoneOffset;
    return timeOffset != 0
        ? DateTime.fromMillisecondsSinceEpoch(
        date.millisecondsSinceEpoch + timeOffset)
        : date;
  }

  /// 转变成本地时间
  static DateTime convertLocaleTime(DateTime date) {
    if (date == null) return null;

    int localeZoneOffset = DateTime
        .now()
        .timeZoneOffset
        .inMilliseconds;
    int timeOffset = localeZoneOffset - serverZoneOffset;
    return timeOffset != 0
        ? DateTime.fromMillisecondsSinceEpoch(
        date.millisecondsSinceEpoch + timeOffset)
        : date;
  }

  /// 转换成年月日 xxxx-xx-xx
  static String toYearMonthDay(DateTime date) {
    if (date == null) return "";
    return '${date.year}-${_getTwoNumString(date.month)}-${_getTwoNumString(
        date.day)}';
  }

  /// 获得2位数字符串
  static String _getTwoNumString(int value) {
    return value < 10 ? '0$value' : '$value';
  }

  /// 获取日期区间
  static String getDateRange(DateTime date, DateRangeType type,
      {beforeNow = true}) {
    if (date == null) return "";

    int year = date.year;
    int month = date.month;
    int day = date.day;
    String monthStr = _getTwoNumString(month);
    String dayStr = _getTwoNumString(day);

    var nowDate = getLocaleTimeNow();

    switch (type) {
      case DateRangeType.RangeYear:
        var yearLast = '$year-12-31';
        var yearLastDate = DateTime.parse(yearLast);

        if (yearLastDate.isAfter(nowDate)) {
          yearLast = toYearMonthDay(nowDate);
        }

        return '$year-01-01 - $yearLast';

      case DateRangeType.RangeMonth:
        int maxDays = getMaxDaysOfMonth(date);
        String maxDaysStr = maxDays >= 10 ? '$maxDays' : '0$maxDays';
        return '$year-$monthStr-01 - $year-$monthStr-$maxDaysStr';

      case DateRangeType.RangeDay:
        return '$year-$monthStr-$dayStr - $year-$monthStr-$dayStr';

      default:
        return "";
    }
  }

  /// 获取当前日期所在月份的天数
  static int getMaxDaysOfMonth(DateTime date, {enableToday = true, canAfterNow = false}) {
    if (date == null) return 0;

    int month = date.month;

    if (!canAfterNow) {
      DateTime _now = getLocaleTimeNow();
      if (equalYearMonth(date, _now)) {
        return enableToday ? _now.day : _now.day - 1;
      }
    }

    switch (month) {
      case 2:
        return isLeapYear(date) ? 29 : 28;

      case 4:
      case 6:
      case 9:
      case 11:
        return 30;

      default:
        return 31;
    }
  }

  /// 判断当前年份是否为闰年
  static bool isLeapYear(DateTime date) {
    if (date == null) return false;

    int year = date.year;
    return (((year % 4) == 0) && ((year % 100) != 0)) || (year % 400 == 0);
  }

  /// 获这个月最后一天的日期
  static DateTime getLastDateOfMonth(DateTime date, {canAfterNow = true}) {
    if (date == null) return null;

    var lastDay = getMaxDaysOfMonth(date, canAfterNow: canAfterNow);
    return DateTime(date.year, date.month, lastDay);
  }

  /// 判断2个日期是否相同，年月日相同
  static bool equal(DateTime date1, DateTime date2) {
    if (date1 == null || date2 == null) return false;

    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// 判断2个日期是否相同，年相同
  static bool equalYear(DateTime date1, DateTime date2) {
    if (date1 == null || date2 == null) return false;

    return date1.year == date2.year;
  }

  /// 判断2个日期是否相同，年月相同
  static bool equalYearMonth(DateTime date1, DateTime date2) {
    if (date1 == null || date2 == null) return false;

    return date1.year == date2.year && date1.month == date2.month;
  }
}
