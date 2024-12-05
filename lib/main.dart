import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:got_food/common/style/theme.dart';
import 'package:got_food/core/appProviders.dart';
import 'package:got_food/core/locator.dart';
import 'package:got_food/routes.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'common/providers/userViewModel.dart';
import 'common/providers/themeProvider.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    debug: true,
  );
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ...appProviders,
      ],
      child: const MyApp(),
    ),
  );
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel =
        Provider.of<UserViewModel>(context, listen: false);
    userViewModel.fetchUserDetails();
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      theme: GotFoodTheme.theme,
      darkTheme: GotFoodTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      initialRoute: supabase.auth.currentUser != null ? '/home' : '/boarding',
      routes: routes,
      // home: const HomePage(),
    );
  }
}
