import 'package:flutter/material.dart';

/// @Description
/// @outhor chenkw
/// @create 2020-05-26 9:59
class BasePage extends StatefulWidget {

  @override
  BasePageState createState() => BasePageState();

}

class BasePageState extends State<BasePage> {

  @override
  Widget build(BuildContext context) {
    return renderPage(context);
  }

  Widget renderPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Base Page"),),
      body: Text("Base Page"),
    );
  }
}
