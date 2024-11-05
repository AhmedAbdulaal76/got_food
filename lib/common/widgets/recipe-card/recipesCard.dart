import 'package:flutter/material.dart';
import 'package:got_food/common/style/themes/themeColors.dart';
import 'package:got_food/common/widgets/recipe-card/recipeImage.dart';

import '../../models/recipe.dart';

class RecipesCard extends StatelessWidget {
  const RecipesCard({super.key, required this.recipe, this.setGrid = false});

  final Recipe recipe;
  final bool setGrid;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: setGrid
          ? const EdgeInsets.symmetric(horizontal: 12, vertical: 20)
          : const EdgeInsets.all(16),
      margin: setGrid
          ? const EdgeInsets.symmetric(horizontal: 8, vertical: 16)
          : const EdgeInsetsDirectional.only(end: 16, top: 12),
      height: 240,
      width: 200,
      decoration: BoxDecoration(
        color: ThemeColors.primaryColorLight,
        borderRadius: BorderRadius.circular(9),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: ThemeColors.primaryColorDark.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      // recipe image, description, calories, time
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // recipe image
          RecipeImage(
            imageUrl: recipe.imageUrl,
          ),
          const SizedBox(height: 8),
          // recipe description
          Text(
            recipe.description,
            maxLines: 2,
            style: const TextStyle(
                color: ThemeColors.primaryColorDark,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(height: 8),
          // calories and time
          Expanded(
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ThemeColors.primaryColorDark,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
