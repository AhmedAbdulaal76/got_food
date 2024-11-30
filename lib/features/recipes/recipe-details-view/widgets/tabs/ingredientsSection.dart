import 'package:flutter/material.dart';
import 'package:got_food/common/models/ingredient.dart';

import 'IngredientCard.dart';

class IngredientsSection extends StatelessWidget {
  const IngredientsSection({super.key, required this.ingredients});

  final List<Ingredient> ingredients;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingredients',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text('${ingredients.length} items',
            style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: ingredients.length,
            itemBuilder: (context, index) {
              return IngredientCard(
                ingredient: ingredients[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
