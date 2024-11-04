import 'package:flutter/material.dart';
import 'package:got_food/common/models/recipe.dart';
import 'package:got_food/common/widgets/recipe-card/recipesCard.dart';

class RecipesLayout extends StatelessWidget {
  const RecipesLayout({super.key, required this.recipes});

  final List<Recipe> recipes;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Check available width and adjust crossAxisCount
        int crossAxisCount = constraints.maxWidth < 600 ? 1 : 2;
        Axis scrollDirection =
            constraints.maxHeight < 400 ? Axis.horizontal : Axis.vertical;

        return GridView.builder(
          scrollDirection: scrollDirection,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 1.2,
          ),
          clipBehavior: Clip.none,
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            return RecipesCard(recipe: recipes[index]);
          },
        );
      },
    );
  }
}
