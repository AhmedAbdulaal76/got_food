import 'package:flutter/material.dart';
import 'package:got_food/common/style/theme.dart';
import 'package:got_food/features/home/home-view/widgets/homePage.dart';

import 'common/style/themes/themeColors.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: ThemeColors.primaryColor,
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  runApp(
    MaterialApp(
      // darkTheme: ThemeData.dark().copyWith(
      //   colorScheme: kColorScheme,
      //   cardTheme: const CardTheme().copyWith(
      //     color: kDarkColorScheme.secondaryContainer,
      //     margin: const EdgeInsets.symmetric(
      //       horizontal: 16,
      //       vertical: 8,
      //     ),
      //   ),
      //   elevatedButtonTheme: ElevatedButtonThemeData(
      //     style: ElevatedButton.styleFrom(
      //       backgroundColor: kDarkColorScheme.primaryContainer,
      //       foregroundColor: kDarkColorScheme.onPrimaryContainer,
      //     ),
      //   ),
      // ),
      theme: GotFoodTheme.theme,
      // themeMode: ThemeMode.system, // default
      home: const HomePage(),
    ),
  );
}
