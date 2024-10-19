import 'package:flutter/material.dart';

import '../themeColors.dart';

class ElevatedTheme {
  static ElevatedButtonThemeData theme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: ThemeColors.primaryTextColor,
      backgroundColor: ThemeColors.primaryColor,
      shadowColor: Colors.black,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );

  static ElevatedButtonThemeData get themeData => theme;
}
