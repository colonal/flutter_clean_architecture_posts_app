import 'package:flutter/material.dart';

import 'app_color.dart';

ThemeData darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryColorDark,
    centerTitle: true,
  ),
  brightness: Brightness.dark,
  primaryColorDark: primaryColorDark,
  backgroundColor: secondaryColorDark,
  colorScheme: const ColorScheme.dark(
    primary: primaryColorDark,
  ),
  progressIndicatorTheme:
      const ProgressIndicatorThemeData(color: primaryColorDark),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: primaryColorDark,
    foregroundColor: secondaryColorDark,
  ),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelStyle: const TextStyle(color: primaryColorDark),
    iconColor: secondaryColorDark,
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: secondaryColorDark),
      borderRadius: BorderRadius.circular(8),
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: primaryColorDark),
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);
