import 'package:flutter/material.dart';
import 'package:got_food/common/style/themes/forms/inputStyle.dart';

import 'themes/buttons/elevated_button.dart';
import 'themes/themeColors.dart';
import 'themes/themeText.dart';

class GotFoodTheme {
  static final ColorScheme kColorScheme = ColorScheme.fromSwatch(
    primarySwatch: MaterialColor(
      ThemeColors.primaryColor.value,
      const <int, Color>{
        50: ThemeColors.primaryColorLight,
        100: ThemeColors.primaryColorLight,
        200: ThemeColors.primaryColorLight,
        300: ThemeColors.primaryColorLight,
        400: ThemeColors.primaryColor,
        500: ThemeColors.primaryColor,
        600: ThemeColors.primaryColor,
        700: ThemeColors.primaryColorDark,
        800: ThemeColors.primaryColorDark,
        900: ThemeColors.primaryColorDark,
      },
    ),
    accentColor: ThemeColors.accentColor,
  ).copyWith(
    onPrimary: ThemeColors.primaryTextColor,
    onSecondary: ThemeColors.secondaryTextColor,
    surface: ThemeColors.primaryColor,
    onSurface: ThemeColors.primaryTextColor,
    error: Colors.red,
    onError: Colors.white,
    brightness: Brightness.light,
  );

  static ThemeData get theme {
    return ThemeData().copyWith(
      colorScheme: kColorScheme,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: ThemeColors.primaryColor,
        foregroundColor: ThemeColors.primaryTextColor,
      ),
      cardTheme: const CardTheme().copyWith(
        color: ThemeColors.primaryColorLight,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),
      elevatedButtonTheme: ElevatedTheme.theme,
      textTheme: ThemeTextStyles.textTheme,
      inputDecorationTheme: InputStyle.inputStyle,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(
            ThemeColors.primaryColor.value,
            const <int, Color>{
              50: ThemeColors.primaryColorLight,
              100: ThemeColors.primaryColorLight,
              200: ThemeColors.primaryColorLight,
              300: ThemeColors.primaryColorLight,
              400: ThemeColors.primaryColor,
              500: ThemeColors.primaryColor,
              600: ThemeColors.primaryColor,
              700: ThemeColors.primaryColorDark,
              800: ThemeColors.primaryColorDark,
              900: ThemeColors.primaryColorDark,
            },
          ),
          accentColor: ThemeColors.accentColor,
        ).copyWith(
          onPrimary: ThemeColors.primaryTextColor,
          onSecondary: ThemeColors.secondaryTextColor,
          surface: ThemeColors.primaryColor,
          onSurface: ThemeColors.primaryTextColor,
          error: Colors.red,
          onError: Colors.white,
          brightness: Brightness.dark,
        ),
        cardTheme: const CardTheme().copyWith(
          color: ThemeColors.primaryColorDark,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedTheme.theme,
        textTheme: ThemeTextStyles.textTheme);
  }
}
