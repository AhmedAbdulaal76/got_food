import 'package:flutter/material.dart';
import 'package:got_food/common/style/themes/themeColors.dart';
import 'package:got_food/common/widgets/recipe-card/recipeImage.dart';

import '../../models/recipe.dart';

class RecipesCard extends StatelessWidget {
  const RecipesCard(
      {super.key, required this.recipe, this.setFullView = false});

  final Recipe recipe;
  final bool setFullView;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: setFullView
          ? const EdgeInsets.symmetric(horizontal: 12, vertical: 20)
          : const EdgeInsets.all(16),
      margin: setFullView
          ? const EdgeInsets.symmetric(horizontal: 12, vertical: 16)
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
        crossAxisAlignment:
            setFullView ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          // recipe image
          RecipeImage(
            recipe: recipe,
            setFullView: setFullView,
          ),
          const SizedBox(height: 8),
          // // recipe subtitle
          // setFullView
          //     ? Text(
          //         recipe.subtitle,
          //         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          //               color: ThemeColors.primaryColorDark,
          //             ),
          //       )
          //     : const SizedBox.shrink(),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ThemeColors.primaryColorDark,
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
                          const Icon(
                            Icons.thumb_up,
                            color: ThemeColors.primaryColorDark,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            recipe.likes.toString(),
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: ThemeColors.primaryColorDark,
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
    );
  }
}
