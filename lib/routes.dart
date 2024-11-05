import 'package:flutter/material.dart';
import 'package:got_food/features/home/categories-view/widgets/categoriesPage.dart';
import 'package:got_food/features/home/categorys-recipes-view/widgets/categoryDetailsPage.dart';

import 'features/home/home-view/widgets/homePage.dart';

// final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
Map<String, Widget Function(BuildContext)> get routes => {
      '/home': (context) => const HomePage(),
      '/home/categories': (context) => const CategoriesPage(),
      '/home/categories/details': (context) => const CategoryDetailsPage(),
    };
