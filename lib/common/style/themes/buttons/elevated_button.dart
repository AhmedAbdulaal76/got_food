import 'package:flutter/material.dart';

import '../themeColors.dart';

class ElevatedTheme {
  static ElevatedButtonThemeData theme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 38),
      backgroundColor: ThemeColors.primaryColor,
      foregroundColor: Colors.white,
      shadowColor: Colors.black,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
    ),
  );

  static ElevatedButtonThemeData get themeData => theme;
}
