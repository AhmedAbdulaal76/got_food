import 'package:flutter/material.dart';
import 'package:got_food/features/home/categories-view/widgets/categoriesPage.dart';
import 'features/auth/login-view/widgets/loginPage.dart';
import 'features/auth/register-view/widgets/registerPage.dart';
import 'features/home/home-view/widgets/homePage.dart';

Map<String, Widget Function(BuildContext)> get routes => {
      '/home': (context) => const HomePage(),
      '/home/categories': (context) => const CategoriesPage(),
      '/login': (context) => const LoginPage(),
      '/signup': (context) => const SignUpPage(),
    };
