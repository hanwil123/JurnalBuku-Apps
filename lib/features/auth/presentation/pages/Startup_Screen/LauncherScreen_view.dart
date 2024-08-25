// ignore: file_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jurnalbukuapps/features/auth/presentation/pages/homepage/homePage_view.dart';
import 'package:jurnalbukuapps/features/auth/presentation/pages/signup/Main_Signup.dart';

class LauncherScreenView extends StatefulWidget {
  // ignore: use_super_parameters
  const LauncherScreenView({Key? key}) : super(key: key);

  @override
  _LauncherScreenVieStatew createState() => new _LauncherScreenVieStatew();
}

class _LauncherScreenVieStatew extends State<LauncherScreenView> {
  @override
  void initState() {
    super.initState();
    startLaunching();
  }
    startLaunching() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        // ignore: prefer_const_constructors
        return HomePageView();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    final widthApp = MediaQuery.of(context).size.width;
    final heightApp = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: Image.asset("assets/novelnestlogo.jpg",
                    height: heightApp * 0.2, width: widthApp * 0.2),
            ),
            Container(
              child: Text('Novel Nest',
                  style: TextStyle(
                      fontSize: widthApp * 0.09,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
