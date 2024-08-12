import 'package:flutter/material.dart';
import 'package:jurnalbukuapps/core/theme/app_pallete.dart';

class AppTheme {
  static _border ([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: AppPallete.borderColor,
          width: 3
        )
      );
  static final darkThemeMode  = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(40),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient1)
    )
  );
}