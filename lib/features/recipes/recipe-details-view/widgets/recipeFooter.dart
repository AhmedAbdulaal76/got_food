// footer of the recipe details view that has the recipe creator & his avatar
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:got_food/common/models/recipe.dart';
import 'package:got_food/features/recipes/recipe-details-view/recipeDetailsViewModel.dart';
import 'package:provider/provider.dart';

class RecipeFooter extends StatelessWidget {
  const RecipeFooter({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    RecipeDetailsViewModel viewModel =
        Provider.of<RecipeDetailsViewModel>(context);

    viewModel.fetchRecipeCreator(recipe.creatorId);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Created by',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              // Radius.circular(20),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 30,
                offset: const Offset(0, -6),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipOval(
                child: CircleAvatar(
                  radius: 30,
                  child: viewModel.isCreatorLoading
                      ? const CircularProgressIndicator()
                      : CachedNetworkImage(
                          imageUrl: viewModel
                              .fetchedCreators[recipe.creatorId]!.imageUrl,
                          placeholder: (context, url) =>
                              const Icon(Icons.person),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.person),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(width: 8),
              // name of the recipe creator
              Text(
                viewModel.isCreatorLoading
                    ? 'Loading...'
                    : viewModel.fetchedCreators[recipe.creatorId]!.username,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 16,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
