import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:got_food/common/models/recipe.dart';
import 'package:got_food/common/style/themes/themeColors.dart';
import 'package:provider/provider.dart';

import '../../../features/favorites/favoritesViewModel.dart';
import '../../../main.dart';

class RecipeImage extends StatefulWidget {
  final Recipe recipe;
  final bool setFullView;
  late bool favorite;
   RecipeImage({
    super.key,
    required this.recipe,
    this.setFullView = false,
     this.favorite = false,
  });

  @override
  _RecipeImageState createState() => _RecipeImageState();
}

class _RecipeImageState extends State<RecipeImage> {
  late bool favorite, setFullView;
  late Recipe recipe;
  void initState() {
    super.initState();
    favorite = widget.favorite; 
    setFullView = widget.setFullView;
    recipe = widget.recipe;
  }

  
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<FavoritesViewModel>(context);
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
                          // Colors.black.withOpacity(0.3),
                          Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.3),
                          BlendMode.darken,
                        )
                      : null),
            ),
          ),
          placeholder: (context, url) => const Icon(
            Icons.fastfood_rounded,
            size: 64,
            color: Colors.white,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
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
                setState(() {
                  favorite ? 
                      viewModel.removeFromFavorites(supabase.auth.currentUser!.id, recipe)
                      : viewModel.addToFavorites(supabase.auth.currentUser!.id, recipe);

                  favorite = !favorite;
                });
            }, // TODO: Add to favourite
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: ThemeColors.primaryColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                favorite ? Icons.favorite_rounded:
                Icons.favorite_border_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
