import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import '../page/next_page.dart';

var testHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return NextPage();
  },
);