import 'package:flutter/material.dart';
import 'package:got_food/common/widgets/recipe-card/recipeImage.dart';

import '../../models/recipe.dart';

class RecipesCard extends StatelessWidget {
  const RecipesCard(
      {super.key,
      required this.recipe,
      this.setFullView = false,
      this.padding,
      this.margin});

  final Recipe recipe;
  final bool setFullView;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/recipes/recipe-details',
            arguments: recipe);
      },
      child: Container(
        padding: padding ??
            (setFullView
                ? const EdgeInsets.symmetric(horizontal: 12, vertical: 20)
                : const EdgeInsets.all(16)),
        margin: margin ??
            (setFullView
                ? const EdgeInsets.symmetric(horizontal: 12, vertical: 16)
                : const EdgeInsetsDirectional.only(end: 16, top: 12)),
        height: 240,
        width: 200,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(9),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: setFullView
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            // recipe image
            RecipeImage(
              recipe: recipe,
              setFullView: setFullView,
            ),
            const SizedBox(height: 8),
            // recipe description
            Text(
              recipe.description,
              maxLines: 2,
              style: TextStyle(
                  // color: ThemeColors.primaryColorDark,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(height: 8),
            // calories and time
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: setFullView ? 16 : null,
                          ),
                      children: [
                        TextSpan(
                          text: '${recipe.calories} Kcal • ',
                        ),
                        TextSpan(
                          text: recipe.time < 60
                              ? '${recipe.time} min'
                              : '${recipe.time ~/ 60} hr ${recipe.time % 60} min',
                        ),
                      ],
                    ),
                  ),
                  // show likes
                  setFullView
                      ? Row(
                          children: [
                            Icon(
                              Icons.thumb_up,
                              // color: ThemeColors.primaryColorDark,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              recipe.likes.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    // color: ThemeColors.primaryColorDark,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
