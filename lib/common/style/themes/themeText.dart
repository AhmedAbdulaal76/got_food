import 'package:flutter/material.dart';

class ThemeTextStyles {
  static const titleLarge = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  static const titleMedium = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  static const titleSmall = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
  static const bodyLarge = TextStyle(
    fontSize: 16,
  );
  static const bodyMedium = TextStyle(
    fontSize: 14,
  );
  static const bodySmall = TextStyle(
    fontSize: 12,
  );

  static TextTheme get textTheme {
    return const TextTheme(
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
    );
  }
}
