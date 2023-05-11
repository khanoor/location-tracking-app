import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:location_tracking/pages/global/global.dart';

import 'package:location_tracking/pages/login.dart';
import 'package:location_tracking/pages/map.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () => navigationPage());
  }

  void navigationPage() async {
    if (user != null) {
      swithScreenReplacement(context, GoogleMap1());
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          child: Image.asset(
            "assets/icon.png",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
