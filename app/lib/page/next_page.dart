import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../main.dart';

/// @Description
/// @outhor chenkw
/// @create 2020-05-21 14:19
class NextPage extends StatefulWidget {
  NextPage({Key key}) : super(key: key);

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("下一页"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Consumer<Counter>(
              builder: (context, value, child) {
                return Column(
                  children: <Widget>[
                    child,
                    Text('${value.count}',
                        style: Theme.of(context).textTheme.headline2),
                  ],
                );
              },
              child: _buildChild(),
            ),
            FlatButton(
                onPressed: () {
                  context.read<Counter>().increment();
                },
                child: Text("累加")),
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("返回")),
          ],
        ),
      ),
    );
  }

  Widget _buildChild() {
    count++;
    return Text("$count");
  }
}
