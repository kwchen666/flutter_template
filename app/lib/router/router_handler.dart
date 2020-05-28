import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import '../page/test_page.dart';
import '../page/next_page.dart';

var testHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return NextPage();
  },
);

var test2Handler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return TestPage();
  },
);
