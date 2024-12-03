import 'package:flutter/material.dart';
import 'package:got_food/features/account/profile-view/widgets/profilePage.dart';
import 'package:got_food/features/home/categories-view/widgets/categoriesPage.dart';
import 'package:got_food/features/home/categorys-recipes-view/widgets/categoryDetailsPage.dart';
import 'package:got_food/features/recipes/recipe-details-view/widgets/recipeDetailsPage.dart';

import 'features/auth/login-view/widgets/loginPage.dart';
import 'features/auth/register-view/widgets/registerPage.dart';
import 'features/favorites/favoritesPage.dart';
import 'features/home/home-view/widgets/homePage.dart';

// final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
Map<String, Widget Function(BuildContext)> get routes => {
      '/home': (context) => const HomePage(),
      '/home/categories': (context) => const CategoriesPage(),
      '/login': (context) => const LoginPage(),
      '/signup': (context) => SignUpPage(),
      '/home/categories/details': (context) => const CategoryDetailsPage(),
      '/profile': (context) => const ProfilePage(),
      '/recipes/recipe-details': (context) => const RecipeDetailsPage(),
      '/favorites': (context) => FavoritesPage(),
    };
