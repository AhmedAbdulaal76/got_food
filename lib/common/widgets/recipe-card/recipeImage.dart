import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:got_food/common/models/recipe.dart';
import 'package:got_food/common/style/themes/themeColors.dart';

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
                        // background: Paint()
                        //   ..color = Theme.of(context)
                        //       .colorScheme
                        //       .onSurface
                        //       .withOpacity(0.4)
                        //   ..style = PaintingStyle.fill,
                      ),
                ),
              )
            : const SizedBox.shrink(),
        // favourite icon
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () {}, // TODO: Add to favourite
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: ThemeColors.primaryColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
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
