import 'package:flutter/material.dart';
import 'package:got_food/common/models/recipe.dart';
import 'package:got_food/common/widgets/layout/customScaffold.dart';
import 'package:got_food/features/recipes/recipe-details-view/widgets/bottomContainer.dart';
import 'package:got_food/main.dart';
import 'package:provider/provider.dart';

import '../recipeDetailsViewModel.dart';
import 'recipeDetailsImage.dart';

class RecipeDetailsPage extends StatelessWidget {
  const RecipeDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Recipe recipe = ModalRoute.of(context)!.settings.arguments as Recipe;
    final viewModel = Provider.of<RecipeDetailsViewModel>(context);
    viewModel.context = context;
    return CustomScaffold(
      actionIcon: supabase.auth.currentUser?.id == recipe.creatorId
          ? const Icon(Icons.delete)
          : null,
      actionFunc: () {
        // confirmation dialog
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Delete Recipe'),
                content:
                    const Text('Are you sure you want to delete this recipe?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      viewModel.deleteRecipe(recipe.recipeId);
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('No'),
                  ),
                ],
              );
            });
      },
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
