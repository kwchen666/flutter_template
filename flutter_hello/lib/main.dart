import 'dart:math';

import 'package:appbase/appbase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'model/user.dart';
import 'page/next_page.dart';

void main() {
  Router router = Router();
  Routes.configureRoutes(router);
  Application.router = router;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
      ],
      child: MyApp(),
    ),
  );
}

class Counter with ChangeNotifier, DiagnosticableTreeMixin {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', count));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;

  User user;

  AnimationController controller;
  Animation<Offset> animation;

  @override
  void initState() {
    super.initState();

    user = User.fromJson({
      "name": "chenkw",
      "nick_name": "小伟",
      "email": "wei53881@126.com",
      "Age": 32,
      "address": {"street": "江西", "city": "南昌"}
    });

    controller =
        AnimationController(duration: const Duration(milliseconds: 200,), vsync: this);
    animation =
        Tween(begin: Offset.zero, end: Offset(4, 0)).animate(controller);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });

    context.read<Counter>().increment();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 360, height: 640);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "姓名：${user.name}",
            ),
            Text(
              "邮箱：${user.email}",
            ),
            Text(
              "邮箱：${user.nick}",
            ),
            Text(
              "年龄：${user.age}",
            ),
            Text(
              "城市：${user.address?.city}",
            ),
            Text(
              "省：${user.address?.street}",
            ),
            Text("${user.toJson()}"),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline5,
            ),
            Icon(Icons.scanner),
            Count(),
            FlatButton(
              child: Text("下一个页面"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NextPage()));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class Count extends StatelessWidget {
  const Count({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('${context.watch<Counter>().count}',
        style: Theme.of(context).textTheme.headline5);
  }
}

class AnimatedContainerApp extends StatefulWidget {
  @override
  _AnimatedContainerAppState createState() => _AnimatedContainerAppState();
}

class _AnimatedContainerAppState extends State<AnimatedContainerApp> {
  // Define the various properties with default values. Update these properties
  // when the user taps a FloatingActionButton.
  double _width = 50;
  double _height = 50;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          // Create a random number generator.
          final random = Random();

          // Generate a random width and height.
          _width = random.nextInt(200).toDouble();
          _height = random.nextInt(200).toDouble();

          // Generate a random color.
          _color = Color.fromRGBO(
            random.nextInt(256),
            random.nextInt(256),
            random.nextInt(256),
            1,
          );

          // Generate a random border radius.
          _borderRadius =
              BorderRadius.circular(random.nextInt(100).toDouble());
        });
      },
      child: AnimatedContainer(
        // Use the properties stored in the State class.
        width: _width,
        height: _height,
        decoration: BoxDecoration(
          color: _color,
          borderRadius: _borderRadius,
        ),
        // Define how long the animation should take.
        duration: Duration(seconds: 1),
        // Provide an optional curve to make the animation feel smoother.
        curve: Curves.fastOutSlowIn,
      ),
    );
  }
}
