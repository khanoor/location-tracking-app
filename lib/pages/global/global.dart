// import 'dart:html';

import 'package:flutter/cupertino.dart';

swithScreenPush(context, screen) {
  return Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, _, __) => screen,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
  );
}

swithScreenReplacement(context, screen) {
  return Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (context, _, __) => screen,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
  );
}

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(em);
}


