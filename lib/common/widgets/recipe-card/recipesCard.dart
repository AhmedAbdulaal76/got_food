import 'package:flutter/material.dart';
import 'package:got_food/common/style/themes/themeColors.dart';
import 'package:got_food/common/widgets/recipe-card/recipeImage.dart';

class RecipesCard extends StatelessWidget {
  const RecipesCard({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsetsDirectional.only(end: 16, top: 16),
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
      child: Column(
        children: [
          RecipeImage(
            imageUrl: imageUrl,
          ),
          const SizedBox(height: 8),
          const Text(
            "wowowo vvery yummy healthy food amazing salad you canty pay for your own freedoom i ate mondi today mutton mandi",
            maxLines: 2,
            style: TextStyle(
                color: ThemeColors.primaryColorDark,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Row(
              children: [
                Text("120 Kcal • ",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ThemeColors.primaryColorDark,
                        )),
                Text(
                  "20 min",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: ThemeColors.primaryColorDark,
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
