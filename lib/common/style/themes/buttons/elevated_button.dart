import 'package:flutter/material.dart';

import '../themeColors.dart';

class ElevatedTheme {
  static ElevatedButtonThemeData theme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: ThemeColors.primaryColor,
      foregroundColor: ThemeColors.primaryTextColor,
      shadowColor: Colors.black,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
    ),
  );

  static ElevatedButtonThemeData get themeData => theme;
}
