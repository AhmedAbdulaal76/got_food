import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:got_food/common/style/theme.dart';
import 'package:got_food/core/appProviders.dart';
import 'package:got_food/core/locator.dart';
import 'package:got_food/features/home/home-view/widgets/homePage.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  setupLocator();
  runApp(
    MultiProvider(
      providers: appProviders,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: GotFoodTheme.theme,
      themeMode: ThemeMode.system, // default
      home: const HomePage(),
    );
  }
}
