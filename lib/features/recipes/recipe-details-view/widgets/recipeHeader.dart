import 'package:flutter/material.dart';
import 'package:got_food/common/models/recipe.dart';

class RecipeHeader extends StatelessWidget {
  const RecipeHeader({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // recipe name & time in single row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // recipe name
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.66,
              child: Text(
                recipe.name,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 3,
              ),
            ),
            // recipe time
            Row(
              children: [
                Icon(
                  Icons.timer,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                const SizedBox(width: 8),
                Text(
                  '${recipe.time} min',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
        // recipe subtitle
        Text(
          recipe.subtitle,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        // recipe description
        Text(
          recipe.description,
          maxLines: 2,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
