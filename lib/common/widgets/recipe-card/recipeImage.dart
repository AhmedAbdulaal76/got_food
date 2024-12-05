import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:got_food/common/models/recipe.dart';
import 'package:got_food/common/style/themes/themeColors.dart';
import 'package:got_food/features/favourites/favorites-view/favoritesViewModel.dart';
import 'package:got_food/main.dart';
import 'package:provider/provider.dart';

class RecipeImage extends StatelessWidget {
  final Recipe recipe;
  final bool setFullView;

  const RecipeImage({
    super.key,
    required this.recipe,
    this.setFullView = false,
  });

  @override
  Widget build(BuildContext context) {
    final favouritesViewModel = Provider.of<FavoritesViewModel>(context);
    bool isFavorite = favouritesViewModel.isFavorite(recipe.recipeId);
    return Stack(
      // fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        CachedNetworkImage(
          width: setFullView ? 400 : 168,
          height: setFullView ? 148 : 128,
          imageUrl: recipe.imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(4, 6),
                ),
              ],
              image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  colorFilter: setFullView
                      ? ColorFilter.mode(
                          Colors.black.withOpacity(0.3),
                          BlendMode.darken,
                        )
                      : null),
            ),
          ),
          placeholder: (context, url) => const Icon(
            Icons.fastfood_rounded,
            size: 64,
            // color: Colors.white,
          ),
          errorWidget: (context, url, error) => const Icon(
            Icons.fastfood_rounded,
            size: 64,
          ),
        ),
        // name of the recipe
        setFullView
            ? Positioned(
                bottom: 8,
                left: 8,
                child: Text(
                  recipe.name,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              )
            : const SizedBox.shrink(),
        // favourite icon
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () {
              favouritesViewModel.context = context;
              isFavorite
                  ? favouritesViewModel.removeFromFavorites(
                      supabase.auth.currentUser!.id, recipe)
                  : favouritesViewModel.addToFavorites(
                      supabase.auth.currentUser!.id, recipe);
            }, // TODO: Add to favourite
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: ThemeColors.primaryColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
