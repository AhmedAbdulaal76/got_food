import 'package:flutter/material.dart';
import 'package:got_food/common/models/recipe.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:got_food/features/recipes/recipe-details-view/widgets/bottomContainer.dart';

import 'recipeDetailsImage.dart';

class RecipeDetailsPage extends StatelessWidget {
  const RecipeDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Recipe recipe = ModalRoute.of(context)!.settings.arguments as Recipe;
    return CustomScaffold(
      title: recipe.name,
      body: Stack(
        children: [
          // show recipe image
          RecipeDetailsImage(imageUrl: recipe.imageUrl),
          BottomContainer(recipe: recipe),
        ],
      ),
    );
  }
}
