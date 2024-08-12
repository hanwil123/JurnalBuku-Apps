// ignore: file_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jurnalbukuapps/features/auth/presentation/pages/homepage/homePage_view.dart';
import 'package:jurnalbukuapps/features/auth/presentation/pages/signup/Main_Signup.dart';

class LauncherScreenView extends StatefulWidget {
  // ignore: use_super_parameters
  const LauncherScreenView({ Key? key }) : super(key: key);

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
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Image.asset("assets/TRISHA1.jpg", 
        height: 100,
        width: 200,
        ),
      ),
    );
  }
}
