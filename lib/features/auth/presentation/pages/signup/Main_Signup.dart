// ignore: file_names
import 'package:flutter/material.dart';
import 'package:jurnalbukuapps/core/theme/theme.dart';
import 'package:jurnalbukuapps/features/auth/presentation/pages/signup/Signup.dart';

class MainSignup extends StatefulWidget {
  // ignore: use_super_parameters
  const MainSignup({ Key? key }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainSignupState createState() => _MainSignupState();
}

class _MainSignupState extends State<MainSignup> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: AppTheme.darkThemeMode,
      home: const Scaffold(
        body: Signup()
      ),
    );
  }
}