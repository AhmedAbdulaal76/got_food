import 'package:flutter/material.dart';
import 'package:got_food/common/style/themes/themeColors.dart';

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
      ),
      child: Column(
        children: [
          Container(
            width: 168,
            height: 128,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: ThemeColors.primaryColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: ThemeColors.primaryColorDark.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(
                  Icons.fastfood,
                  size: 64,
                  color: ThemeColors.primaryTextColor,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {}, // TODO: Add to favourite
                    child: const Icon(
                      Icons.favorite_border_outlined,
                      color: ThemeColors.primaryTextColor,
                    ),
                  ),
                ),
              ],
            ),
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
          const Expanded(
            child: Row(
              children: [
                Text(
                  "120 Kcal",
                  style: TextStyle(
                    color: ThemeColors.primaryColorDark,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  "20 min",
                  style: TextStyle(
                    color: ThemeColors.primaryColorDark,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
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
