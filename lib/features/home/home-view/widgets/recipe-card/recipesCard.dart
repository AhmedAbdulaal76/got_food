import 'package:flutter/material.dart';
import 'package:got_food/common/style/themes/themeColors.dart';
import 'package:got_food/features/home/home-view/widgets/recipe-card/recipeImage.dart';

class RecipesCard extends StatelessWidget {
  const RecipesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 24),
      height: 240,
      width: 200,
      decoration: BoxDecoration(
        color: ThemeColors.primaryColorBright,
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
          const RecipeImage(
              imageUrl:
                  "https://www.dishgen.com/_next/image?url=https%3A%2F%2Fupcdn.io%2FW142hmp%2Frecipe%2Fuploads%2F2023%2F04%2F19%2FQuinoa-Skillet-7YXS.jpg.webp.crop&w=828&q=75"),
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
