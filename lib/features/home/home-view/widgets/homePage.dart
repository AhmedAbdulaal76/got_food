import 'package:flutter/material.dart';
import 'package:got_food/common/style/themes/themeColors.dart';
import 'package:got_food/common/widgets/category/categoryCard.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:got_food/common/widgets/recipe-card/recipesCard.dart';
import 'package:got_food/features/home/home-view/homeViewModel.dart';
import 'package:got_food/features/home/home-view/widgets/homeHeader.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    if (viewModel.isRecipesLoading) {
      viewModel.fetchRecipes();
    } else {
      print('Recipes already loaded');
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
              viewModel.isRecipesLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      height: 270,
                      width: 500,
                      child: ListView.builder(
                        itemCount: viewModel.recipes.length,
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return RecipesCard(
                            imageUrl: viewModel.recipes[index]['imageurl'],
                          );
                        },
                      ),
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
              // show categories
              SizedBox(
                height: 41,
                width: 453,
                child: ListView.builder(
                  itemCount: 5,
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return CategoryCard(
                        name: 'Breakfast',
                        isSelected: true,
                      );
                    }
                    return CategoryCard(name: 'Breakfast');
                  },
                ),
              ),
              // show list of recipes
              SizedBox(
                height: 270,
                width: 500,
                child: ListView.builder(
                  itemCount: 5,
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return const RecipesCard(
                      imageUrl:
                          'https://www.dishgen.com/_next/image?url=https%3A%2F%2Fupcdn.io%2FW142hmp%2Frecipe%2Fuploads%2F2023%2F04%2F19%2FQuinoa-Skillet-7YXS.jpg.webp.crop&w=828&q=75',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
