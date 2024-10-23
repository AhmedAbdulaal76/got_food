import 'package:flutter/material.dart';

class ThemeTextStyles {
  static const titleLarge = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: Colors.black,
  );
  static const titleMedium = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
    color: Colors.black,
  );
  static const titleSmall = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 12,
    color: Colors.black,
  );
  static const bodyLarge = TextStyle(
    fontSize: 20,
    color: Colors.black,
  );
  static const bodyMedium = TextStyle(
    fontSize: 16,
    color: Colors.black,
  );
  static const bodySmall = TextStyle(
    fontSize: 14,
    color: Colors.black,
  );

  static const headLine1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const headLine2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const headLine3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextTheme get textTheme {
    return const TextTheme(
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      headlineLarge: headLine1,
      headlineMedium: headLine2,
      headlineSmall: headLine3,
    );
  }
}
