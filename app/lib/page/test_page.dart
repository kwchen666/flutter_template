import 'package:common/common.dart';
import 'package:flutter/material.dart';

/// @Description
/// @outhor chenkw
/// @create 2020-05-26 14:19
class TestPage extends BaseProviderPage<TestProvider> {
  BottomDatePicker _datePicker;

  @override
  TestProvider getProvider() {
    return TestProvider();
  }

  @override
  Widget renderPage(BuildContext context) {
    LogUtil.d("renderPage build ... ");

    if (_datePicker == null) {
      _datePicker = BottomDatePicker([
        DaySelectMode(DateTime.now()),
        MonthSelectMode(DateTime.now()),
        YearSelectMode(DateTime.now()),
      ], 0, (date, dateRange) {
        var selector = _datePicker?.selectMode;

        if (selector != null) {
          context.read<TestProvider>().setDate(
              selector.getDateString(),
              selector.getDateRange());
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Test Page"),
      ),
      body: Consumer<TestProvider>(
        builder: (context, value, child) {
          LogUtil.d("Consumer build ...");
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('当前日期：${value.date.toString()}',
                  style: Theme.of(context).textTheme.headline6),
              Text('当前日期区间：${value.dateRange.toString()}',
                  style: Theme.of(context).textTheme.headline6),
              _datePicker,
            ],
          );
        },
      ),
    );
  }
}

class TestProvider extends ChangeNotifier {
  String date;
  String dateRange;

  setDate(String value, String dateRange) {
    date = value;
    this.dateRange = dateRange;
    notifyListeners();
  }

}
