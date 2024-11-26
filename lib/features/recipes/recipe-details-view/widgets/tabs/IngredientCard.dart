import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:got_food/common/models/ingredient.dart';

class IngredientCard extends StatelessWidget {
  const IngredientCard({super.key, required this.ingredient});

  final Ingredient ingredient;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Leading Image
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: CachedNetworkImage(
              imageUrl: ingredient.imageUrl,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) {
                print(
                    "error in loading image: ${error.toString()}, specified url:  $url");
                return const Icon(Icons.error);
              },
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          // Title (Ingredient Name)
          Text(
            ingredient.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          const Spacer(),
          // Trailing (Quantity and Unit)
          Text(
            "${ingredient.quantity} ${ingredient.unit ?? 'N/A'}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
