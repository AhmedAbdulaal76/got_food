import 'package:flutter/material.dart';

class ThemeColors {
  // globals
  static const errorColor = Color(0xFFD32F2F);
  static const successColor = Color(0xFF388E3C);
  static const warningColor = Color(0xFFE64A19);

  // for light theme
  static const primaryColor = Color.fromARGB(255, 92, 141, 136);
  static const primaryColorDark = Color(0xFF16423C);
  static const primaryColorLight = Color(0xFFC4DAD2);
  static const primaryColorBright = Colors.white;
  static const accentColor = Color(0xFF00BCD3);
  static const primaryTextColor = Colors.black;
  static const secondaryTextColor = Color(0xFF757574);
  static const dividerColor = Color(0xFFBDBDBC);

  static const lightColorScheme = ColorScheme(
    primary: primaryColor,
    onPrimary: primaryTextColor,
    secondary: primaryColorDark,
    onSecondary: primaryTextColor,
    surface: primaryColorLight,
    onSurface: primaryColorDark,
    error: errorColor,
    onError: primaryTextColor,
    brightness: Brightness.light,
  );

  // for dark theme

  static const secondaryColor = Color(0xFF183D3D);
  static const secondaryColorDark = Color.fromARGB(255, 226, 244, 238);
  static const secondaryColorLight = Color.fromARGB(255, 53, 135, 135);
  static const secondaryColorBright = Color(0xFF76ABAE);
  static const secondaryTextColorDark = Colors.white;

  static const darkColorScheme = ColorScheme.dark(
    primary: secondaryColor,
    onPrimary: secondaryTextColorDark,
    secondary: secondaryColorDark,
    onSecondary: secondaryTextColorDark,
    surface: secondaryColorLight,
    onSurface: secondaryColorDark,
    error: errorColor,
    onError: secondaryTextColorDark,
    brightness: Brightness.dark,
  );
}
