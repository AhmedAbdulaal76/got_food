import 'package:flutter/material.dart';
import 'package:got_food/common/style/themes/themeColors.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:got_food/common/widgets/layout/recipesLayout.dart';
import 'package:got_food/features/home/home-view/homeViewModel.dart';
import 'package:got_food/features/home/home-view/widgets/homeHeader.dart';
import 'package:provider/provider.dart';

import 'categoryTabs/categoryTabs.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    if (viewModel.recipes.isEmpty) {
      viewModel.fetchRecipes();
    } else {
      print('Recipes already loaded');
    }

    if (viewModel.categories.isEmpty) {
      viewModel.fetchCategories();
    } else {
      print('Categories already loaded');
    }

    return CustomScaffold(
      title: "Home Page",
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsDirectional.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const HomeHeader(),
              const SizedBox(height: 8),
              // show featured recipes
              viewModel.recipes.isEmpty
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      height: 270,
                      child: RecipesLayout(recipes: viewModel.recipes),
                    ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  Text('See All',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: ThemeColors.secondaryTextColor))
                ],
              ),
              const SizedBox(height: 12),
              // show categories as tabs
              viewModel.categories.isEmpty
                  ? const CircularProgressIndicator()
                  : CategoryTabs(categories: viewModel.categories),
            ],
          ),
        ),
      ),
    );
  }
}
