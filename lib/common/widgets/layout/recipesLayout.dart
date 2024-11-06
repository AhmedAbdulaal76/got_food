import 'package:flutter/material.dart';
import 'package:got_food/common/models/recipe.dart';
import 'package:got_food/common/widgets/recipe-card/recipesCard.dart';

class RecipesLayout extends StatelessWidget {
  RecipesLayout({super.key, required this.recipes, this.setGrid = false});

  final List<Recipe> recipes;
  bool setGrid;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: setGrid ? Axis.vertical : Axis.horizontal,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: setGrid ? 2 : 1,
        childAspectRatio: setGrid ? 0.7 : 1.2,
      ),
      clipBehavior: Clip.none,
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return RecipesCard(recipe: recipes[index], setGrid: setGrid);
      },
    );
  }
}
