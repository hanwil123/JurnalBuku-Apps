import 'package:flutter/material.dart';
import 'package:jurnalbukuapps/core/theme/theme.dart';
import 'package:jurnalbukuapps/features/auth/presentation/pages/login/Login.dart';


class MainLogin extends StatefulWidget {
  const MainLogin({ Key? key }) : super(key: key);

  @override
  _MainLoginState createState() => _MainLoginState();
}

class _MainLoginState extends State<MainLogin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkThemeMode,
      home: Scaffold(
        body: Login()
      ),
    );
  }
}