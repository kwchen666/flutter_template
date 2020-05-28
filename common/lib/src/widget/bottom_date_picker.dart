import 'package:flutter/material.dart';

import '../../common.dart';

typedef void DateChangedListener(DateTime curSelect, String dateRange);

/// @Description        底部日期选择器
/// @outhor chenkw
/// @create 2020-05-16 11:17
///
class BottomDatePicker extends StatefulWidget {
  /// 日选择监听器
  final DateChangedListener listener;

  /// 状态句柄
  BottomDatePickerState _state;

  /// 选择模式
  final List<DateSelectMode> modes;

  /// 当前模式类型
  int modeType;

  BottomDatePicker(this.modes, this.modeType, this.listener);

  @override
  State<BottomDatePicker> createState() {
    _state = new BottomDatePickerState();
    return _state;
  }

  DateTime get date => selectMode.date;

  set date(DateTime date) {
    if (selectMode != null) {
      selectMode.date = date;
      rebuild();
    }
  }

  /// 当前选择模式
  DateSelectMode get selectMode {
    return modes != null && modeType < modes.length ? modes[modeType] : null;
  }

  void rebuild() {
    if (_state != null) {
      _state.updateDate();
    }
  }
}

class BottomDatePickerState extends State<BottomDatePicker>
    with SingleTickerProviderStateMixin {
  BottomDatePickerState();

  void updateDate() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var dateString = _getDateString();

    return Material(
      elevation: 16,
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 日期
            _buildDate(dateString, () {
              setState(() {
                widget.selectMode.sub();
                _dateChanged();
              });
            }, () {
              setState(() {
                widget.selectMode.add();
                _dateChanged();
              });
            }),
            // tabs: 年月日
            _buildTabs(widget.modes, (index) {
              setState(() {
                // 切换模式时，需要将date同步一下
                var prevMode = widget.selectMode;
                widget.modeType = index;
                widget.selectMode.date = prevMode.date;

                _dateChanged();
              });
            })
          ],
        ),
      ),
    );
  }

  /// 日期变化
  _dateChanged() {
    if (widget.listener != null) {
      widget.listener(widget.selectMode.date, _getDateRange());
    }
  }

  /// 获取日期区间
  String _getDateRange() {
    return widget.selectMode.getDateRange();
  }

  /// 获取当前显示日期字符串
  String _getDateString() {
    return widget.selectMode.getDateString();
  }

  void dispose() {
    widget._state = null;
    super.dispose();
  }

  /// 日期
  Widget _buildDate(dateString, onPrevCb, onNextCb) {
    bool canAdd = widget.selectMode.canAdd();

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // 日期减
        IconButton(
          icon: Icon(Icons.arrow_left),
          onPressed: onPrevCb,
        ),
        // 日期
        Container(
          constraints: BoxConstraints(minWidth: 80),
          child: Text(
            dateString,
            style: new TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        // 日期加
        IconButton(
          icon: Icon(Icons.arrow_right),
          onPressed: canAdd ? onNextCb : null,
        ),
      ],
    );
  }

  /// 构建年月日tabs
  Widget _buildTabs(List<DateSelectMode> modes, clickListener) {
    var tabButtons = List.generate(modes.length, (index) {
      return Container(
        width: 50,
        child: FlatButton(
          onPressed: () {
            if (clickListener != null) clickListener(index);
          },
          child: new Text(modes[index].name),
          textColor: widget.modeType == index
              ? Theme.of(context).accentColor
              : Theme.of(context).disabledColor,
        ),
      );
    }).toList();
    return Row(
      children: tabButtons,
    );
  }
}

/// 抽象日期选择
abstract class DateSelectMode {
  DateTime date;

  String name;

  DateSelectMode(this.date, {this.name});

  /// 加
  bool add();

  /// 减
  bool sub();

  /// 能加
  bool canAdd();

  /// 获取日字符串
  String getDateString();

  /// 获取日期区间
  String getDateRange();

  /// 日期类型
  String dateType();
}

/// 日选择模式
class DaySelectMode extends DateSelectMode {
  final bool includeToday;

  DaySelectMode(DateTime date, {String name = "日", this.includeToday = true})
      : super(date, name: name);

  @override
  bool add() {
    if (!canAdd()) return false;
    date = date.add(Duration(days: 1));
    return true;
  }

  @override
  bool sub() {
    date = date.subtract(Duration(days: 1));
    return true;
  }

  @override
  bool canAdd() {
    var newDay = date.add(Duration(days: 1));
    return newDay.isBefore(DateUtils.getLocaleTimeNow());
  }

  @override
  String getDateString() {
    return DateUtils.toYearMonthDay(date);
  }

  @override
  String getDateRange() {
    return DateUtils.getDateRange(date, DateRangeType.RangeDay);
  }

  @override
  String dateType() {
    return "day";
  }
}

/// 月选择模式
class MonthSelectMode extends DateSelectMode {
  MonthSelectMode(DateTime date, {String name = "月"}) : super(date, name: name);

  @override
  bool add() {
    if (!canAdd()) return false;
    date = date.add(Duration(days: 30));
    return true;
  }

  @override
  bool sub() {
    date = date.subtract(Duration(days: 30));
    return true;
  }

  @override
  bool canAdd() {
    var nowDate = DateUtils.getLocaleTimeNow();
    if (date.year == nowDate.year)
      return date.month < nowDate.month;
    else if (date.year < nowDate.year) return true;
    return false;
  }

  @override
  String getDateString() {
    return DateUtils.toYearMonthDay(date).substring(0, 7);
  }

  @override
  String getDateRange() {
    return DateUtils.getDateRange(date, DateRangeType.RangeMonth);
  }

  @override
  String dateType() {
    return "month";
  }
}

/// 年选择模式
class YearSelectMode extends DateSelectMode {
  YearSelectMode(DateTime date, {String name = "年"}) : super(date, name: name);

  @override
  bool add() {
    if (!canAdd()) return false;
    date = date.add(Duration(days: 365));
    return true;
  }

  @override
  bool sub() {
    date = date.subtract(Duration(days: 365));
    return true;
  }

  @override
  bool canAdd() {
    var nowDate = DateUtils.getLocaleTimeNow();
    return date.year < nowDate.year;
  }

  @override
  String getDateString() {
    return DateUtils.toYearMonthDay(date).substring(0, 4);
  }

  @override
  String getDateRange() {
    return DateUtils.getDateRange(date, DateRangeType.RangeYear);
  }

  @override
  String dateType() {
    return "year";
  }
}
