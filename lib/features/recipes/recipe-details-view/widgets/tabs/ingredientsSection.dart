import 'package:flutter/material.dart';
import 'package:got_food/common/models/ingredient.dart';

class IngredientsSection extends StatelessWidget {
  const IngredientsSection({super.key, required this.ingredients});

  final List<Ingredient> ingredients;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Ingredients',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text('${ingredients.length} items'),
        const SizedBox(height: 8),
        const Text('1. 1 cup of flour'),
        const SizedBox(height: 8),
        const Text('2. 1 cup of sugar'),
        const SizedBox(height: 8),
        const Text('3. 1 cup of milk'),
        const SizedBox(height: 8),
        const Text('4. 1 cup of butter'),
        const SizedBox(height: 8),
        const Text('5. 1 cup of eggs'),
      ],
    );
  }
}
