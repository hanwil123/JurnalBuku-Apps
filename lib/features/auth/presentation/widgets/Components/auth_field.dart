import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hinText;
  final TextEditingController? controller;
  final Color? hintTextColor;
  final Color? textColor;
  final bool isObsecureText;

  const AuthField({
    super.key,
    required this.hinText,
    this.controller,
    this.hintTextColor,
    this.textColor,
    this.isObsecureText = false
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        hintText: hinText,
        hintStyle: TextStyle(color: hintTextColor)
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$hinText enter some text';
        }
        return null;
      },
      obscureText: isObsecureText,
    );
  }
}